# ================================
# CHECK VERSION
# ================================
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "❌ Ce script nécessite PowerShell 7+"
    exit
}

# ================================
# CONFIG
# ================================
$repoDir    = Get-Location
$outputFile = Join-Path $repoDir "blacklist.txt"
$countFile  = Join-Path $repoDir "count.txt"
$listFile   = Join-Path $repoDir "ExternalLists.txt"

# ================================
# FUNCTION : IP IN CIDR
# ================================
function Test-IPInCIDR {
    param ($ip, $cidr)

    $parts = $cidr -split "/"
    $network = $parts[0]
    $prefix = [int]$parts[1]

    $ipBytes  = $ip.Split('.')  | ForEach-Object {[int]$_}
    $netBytes = $network.Split('.') | ForEach-Object {[int]$_}

    $ipInt  = ($ipBytes[0] -shl 24) -bor ($ipBytes[1] -shl 16) -bor ($ipBytes[2] -shl 8) -bor $ipBytes[3]
    $netInt = ($netBytes[0] -shl 24) -bor ($netBytes[1] -shl 16) -bor ($netBytes[2] -shl 8) -bor $netBytes[3]

    $mask = [uint32]::MaxValue -shl (32 - $prefix)

    return ($ipInt -band $mask) -eq ($netInt -band $mask)
}

# ================================
# INIT
# ================================
Write-Host "========================================="
Write-Host "🚀 START SCRIPT (FINAL OPTIMIZED)"
Write-Host "📁 Repo :" $repoDir
Write-Host "========================================="

$globalStart = Get-Date

# ================================
# LOAD URL LIST
# ================================
Write-Host "📥 Chargement des sources..."

if (-not (Test-Path $listFile)) {
    Write-Host "❌ ExternalLists.txt introuvable"
    exit
}

$urls = [System.IO.File]::ReadAllLines($listFile) |
    ForEach-Object { $_.Trim() } |
    Where-Object {
        $_ -ne "" -and
        -not $_.StartsWith("#") -and
        $_ -match '^https?://'
    }

Write-Host "🔗 Nombre de sources :" $urls.Count

# ================================
# DOWNLOAD + PARSE
# ================================
Write-Host "📥 Téléchargement..."

$downloadStart = Get-Date

$tempData = $urls | ForEach-Object -Parallel {

    $url = $_
    Write-Host "→ $url"

    $result = New-Object System.Collections.Generic.List[string]

    try {
        $wc = New-Object System.Net.WebClient
        $content = $wc.DownloadString($url)

        foreach ($line in $content -split "`n") {

            $clean = $line.Trim()

            if (-not $clean) { continue }

            # commentaires
            if ($clean.StartsWith("#") -or $clean.StartsWith(";")) { continue }

            # enlever après ;
            if ($clean -match ';') {
                $clean = ($clean -split ';')[0].Trim()
            }

            # IP ou CIDR
            if (
                $clean -match '^\d{1,3}(\.\d{1,3}){3}$' -or
                $clean -match '^\d{1,3}(\.\d{1,3}){3}/\d{1,2}$'
            ) {
                [void]$result.Add($clean)
            }
        }

        Write-Host "✅ OK"
    }
    catch {
        Write-Host "⚠️ Erreur : $url"
    }

    return $result

} -ThrottleLimit 2

$downloadEnd = Get-Date

# ================================
# CLEAN + UNIQUE
# ================================
Write-Host "🧹 Nettoyage..."

$uniqueData = $tempData |
    Where-Object { $_ -ne "" } |
    Sort-Object -Unique

# ================================
# REMOVE IP INCLUDED IN CIDR
# ================================
Write-Host "🔍 Suppression IP incluses dans CIDR..."

$cidrs = $uniqueData | Where-Object { $_ -match "/" }
$ips   = $uniqueData | Where-Object { $_ -notmatch "/" }

$filteredIPs = @()

foreach ($ip in $ips) {
    $inside = $false

    foreach ($cidr in $cidrs) {
        if (Test-IPInCIDR $ip $cidr) {
            $inside = $true
            break
        }
    }

    if (-not $inside) {
        $filteredIPs += $ip
    }
}

$uniqueData = $filteredIPs + $cidrs

Write-Host "📊 Après optimisation :" $uniqueData.Count "entrées"

# ================================
# VALIDATION
# ================================
if ($uniqueData.Count -lt 10) {
    Write-Host "❌ ERREUR : blacklist trop petite"
    exit
}

# ================================
# SAVE FILES
# ================================
$uniqueData | Out-File -Encoding ASCII $outputFile
$uniqueData.Count | Out-File -Encoding ASCII $countFile

Write-Host "✅ blacklist.txt généré"
Write-Host "📄 count.txt généré"

# ================================
# TIMINGS
# ================================
$totalEnd = Get-Date

Write-Host "========================================="
Write-Host "⏱️ Download :" ($downloadEnd - $downloadStart).TotalSeconds "sec"
Write-Host "⏱️ Total :" ($totalEnd - $globalStart).TotalSeconds "sec"
Write-Host "========================================="

# ================================
# GIT PUSH
# ================================
if (Test-Path ".git") {

    Write-Host "🚀 Push Git..."

    git add .
    git commit -m "Auto update blacklist ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))" | Out-Null
    git push

    Write-Host "✅ Push OK"
}
else {
    Write-Host "❌ Pas de repo git"
}