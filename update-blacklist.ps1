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

# 🔥 Activer / désactiver optimisation CIDR
$enableCIDROptimization = $true

# ================================
# INIT
# ================================
Write-Host "========================================="
Write-Host "🚀 START SCRIPT (FINAL + CIDR OPTIONAL)"
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
    ForEach-Object {
        $line = $_.Trim()

        if (-not $line) { return }
        if ($line -match '^\s*#') { return }

        if ($line -match '#') {
            $line = ($line -split '#')[0].Trim()
        }

        if ($line -match '^https?://') {
            $line
        }
    }

Write-Host "🔗 Nombre de sources :" $urls.Count

# ================================
# DOWNLOAD + PARSE
# ================================
Write-Host "📥 Téléchargement..."

$downloadStart = Get-Date

$results = $urls | ForEach-Object -Parallel {

    $url = $_
    Write-Host "→ $url"

    $result = New-Object System.Collections.Generic.List[string]

    try {
        $wc = New-Object System.Net.WebClient
        $content = $wc.DownloadString($url)

        foreach ($line in $content -split "`n") {

            $clean = $line.Trim()

            if (-not $clean) { continue }
            if ($clean.StartsWith("#") -or $clean.StartsWith(";")) { continue }

            if ($clean -match ';') {
                $clean = ($clean -split ';')[0].Trim()
            }

            if (
                $clean -match '^\d{1,3}(\.\d{1,3}){3}$' -or
                $clean -match '^\d{1,3}(\.\d{1,3}){3}/\d{1,2}$'
            ) {
                [void]$result.Add($clean)
            }
        }

        Write-Host "✅ OK ($($result.Count))"
    }
    catch {
        Write-Host "⚠️ Erreur : $url"
    }

    [PSCustomObject]@{
        Url   = $url
        Data  = $result
        Count = $result.Count
    }

} -ThrottleLimit 2

$downloadEnd = Get-Date

# ================================
# STATS PAR SOURCE
# ================================
Write-Host "=============================="
Write-Host "📊 STATS PAR SOURCE"
Write-Host "=============================="

$results | Sort-Object Count -Descending | ForEach-Object {
    Write-Host ("{0} → {1} entrées" -f $_.Url, $_.Count)
}

# ================================
# FLATTEN PROPRE
# ================================
$tempData = foreach ($r in $results) { $r.Data }

# ================================
# CLEAN + UNIQUE
# ================================
Write-Host "🧹 Nettoyage..."

$uniqueData = $tempData |
    Where-Object { $_ -ne "" } |
    Sort-Object -Unique

Write-Host "📊 Total avant CIDR :" $uniqueData.Count

# ================================
# CIDR OPTIMIZATION (OPTIONNEL)
# ================================
if ($enableCIDROptimization) {

    Write-Host "🔍 Optimisation IP incluses dans CIDR..."

    function IPToInt($ip) {
        $b = $ip.Split('.') | ForEach-Object {[int]$_}
        return ($b[0] -shl 24) -bor ($b[1] -shl 16) -bor ($b[2] -shl 8) -bor $b[3]
    }

    function CIDRToRange($cidr) {
        $parts = $cidr -split "/"
        $ip = $parts[0]
        $prefix = [int]$parts[1]

        $base = IPToInt $ip
        $size = [math]::Pow(2, (32 - $prefix))

        return @{
            start = $base
            end   = $base + $size - 1
        }
    }

    $cidrs = $uniqueData | Where-Object { $_ -match "/" }
    $ips   = $uniqueData | Where-Object { $_ -notmatch "/" }

    Write-Host "📊 IP :" $ips.Count " | CIDR :" $cidrs.Count

    $cidrRanges = $cidrs | ForEach-Object { CIDRToRange $_ } |
        Sort-Object start

    $filteredIPs = foreach ($ip in $ips) {

        $ipInt = IPToInt $ip
        $match = $false

        foreach ($range in $cidrRanges) {

            if ($ipInt -lt $range.start) { break }

            if ($ipInt -le $range.end) {
                $match = $true
                break
            }
        }

        if (-not $match) { $ip }
    }

    $uniqueData = $filteredIPs + $cidrs

    Write-Host "📊 Total après CIDR :" $uniqueData.Count
}

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