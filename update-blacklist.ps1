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
$whitelistFile = Join-Path $repoDir "whitelist.txt"

# ================================
# FUNCTIONS
# ================================
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

# ================================
# INIT
# ================================
Write-Host "========================================="
Write-Host "🚀 START SCRIPT (FINAL FIXED)"
Write-Host "📁 Repo :" $repoDir
Write-Host "========================================="

$globalStart = Get-Date

# ================================
# LOAD URL LIST (FIXED)
# ================================
Write-Host "📥 Chargement des sources..."

if (-not (Test-Path $listFile)) {
    Write-Host "❌ ExternalLists.txt introuvable"
    exit
}

$urls = @()

foreach ($line in [System.IO.File]::ReadAllLines($listFile)) {

    $line = $line.Trim()

    if (-not $line) { continue }
    if ($line -match '^\s*#') { continue }

    # enlever commentaires inline
    if ($line -match '#') {
        $line = ($line -split '#')[0].Trim()
    }

    if ($line -match '^https?://') {
        $urls += $line
    }
}

Write-Host "🔗 Nombre de sources :" $urls.Count
$urls | ForEach-Object { Write-Host "→ $_" }

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
# STATS
# ================================
Write-Host "=============================="
Write-Host "📊 STATS PAR SOURCE"
Write-Host "=============================="

$results | Sort-Object Count -Descending | ForEach-Object {
    Write-Host ("{0} → {1} entrées" -f $_.Url, $_.Count)
}

# ================================
# FLATTEN
# ================================
$tempData = foreach ($r in $results) { $r.Data }

# ================================
# CLEAN + UNIQUE
# ================================
Write-Host "🧹 Nettoyage..."

$uniqueData = $tempData |
    Where-Object { $_ -ne "" } |
    Sort-Object -Unique

Write-Host "📊 Total avant whitelist :" $uniqueData.Count

# ================================
# WHITELIST
# ================================
if (Test-Path $whitelistFile) {

    Write-Host "🛡️ Application whitelist..."

    $whitelist = [System.IO.File]::ReadAllLines($whitelistFile) |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -ne "" -and -not $_.StartsWith("#") }

    $wlCIDR = $whitelist | Where-Object { $_ -match "/" }
    $wlIP   = $whitelist | Where-Object { $_ -notmatch "/" }

    $wlRanges = $wlCIDR | ForEach-Object { CIDRToRange $_ }

    $filtered = foreach ($entry in $uniqueData) {

        if ($entry -match "/") {
            if ($wlCIDR -contains $entry) { continue }
            $entry
        }
        else {
            if ($wlIP -contains $entry) { continue }

            $ipInt = IPToInt $entry
            $skip = $false

            foreach ($r in $wlRanges) {
                if ($ipInt -ge $r.start -and $ipInt -le $r.end) {
                    $skip = $true
                    break
                }
            }

            if (-not $skip) { $entry }
        }
    }

    $uniqueData = $filtered

    Write-Host "📊 Total après whitelist :" $uniqueData.Count
}

# ================================
# VALIDATION
# ================================
if ($uniqueData.Count -lt 10) {
    Write-Host "❌ ERREUR : blacklist trop petite"
    exit
}

# ================================
# SAVE
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
# GIT PUSH (SMART)
# ================================
if (Test-Path ".git") {

    Write-Host "🚀 Push Git..."

    git add .

    if (-not (git diff --cached --quiet)) {
        git commit -m "Auto update blacklist ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))" | Out-Null
        git push
        Write-Host "✅ Push OK"
    }
    else {
        Write-Host "ℹ️ Aucun changement"
    }
}
else {
    Write-Host "❌ Pas de repo git"
}