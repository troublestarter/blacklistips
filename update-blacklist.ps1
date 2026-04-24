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

$enableCIDROptimization = $false

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
Write-Host "🚀 START SCRIPT (FULL + STATS)"
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

$urls = @()

foreach ($line in [System.IO.File]::ReadAllLines($listFile)) {

    $line = $line.Trim()

    if (-not $line) { continue }
    if ($line -match '^\s*#') { continue }

    if ($line -match '#') {
        $line = ($line -split '#')[0].Trim()
    }

    if ($line -match '^https?://') {
        $urls += $line
    }
}

Write-Host "🔗 Nombre de sources :" $urls.Count

# ================================
# DOWNLOAD + PARSE
# ================================
Write-Host "📥 Téléchargement..."

$results = $urls | ForEach-Object -Parallel {

    $url = $_
    Write-Host "→ $url"

    $result = New-Object System.Collections.Generic.List[string]

    try {
        $content = (New-Object System.Net.WebClient).DownloadString($url)

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

    }
    catch {
        Write-Host "⚠️ Erreur : $url"
    }

    [PSCustomObject]@{
        Url   = $url
        Count = $result.Count
        Data  = $result
    }

} -ThrottleLimit 2

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
# FLATTEN
# ================================
$tempData = foreach ($r in $results) { $r.Data }

# ================================
# CLEAN + DEDUP
# ================================
Write-Host "🧹 Nettoyage + suppression des doublons..."

$uniqueData = $tempData |
    Where-Object { $_ -ne "" } |
    Sort-Object -Unique

Write-Host "📊 Total avant whitelist :" $uniqueData.Count

# ================================
# STATS AVANT WHITELIST
# ================================
$ipCount   = ($uniqueData | Where-Object { $_ -notmatch "/" }).Count
$cidrCount = ($uniqueData | Where-Object { $_ -match "/" }).Count

Write-Host "📊 IP :" $ipCount
Write-Host "📊 CIDR :" $cidrCount

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

    # stats post WL
    $ipCount   = ($uniqueData | Where-Object { $_ -notmatch "/" }).Count
    $cidrCount = ($uniqueData | Where-Object { $_ -match "/" }).Count

    Write-Host "📊 (POST-WL) IP :" $ipCount
    Write-Host "📊 (POST-WL) CIDR :" $cidrCount
}

# ================================
# CIDR OPTIMIZATION
# ================================
if ($enableCIDROptimization) {

    Write-Host "🔍 Optimisation CIDR activée"

    $cidrs = $uniqueData | Where-Object { $_ -match "/" }
    $ips   = $uniqueData | Where-Object { $_ -notmatch "/" }

    $cidrRanges = $cidrs | ForEach-Object { CIDRToRange $_ }

    $filteredIPs = foreach ($ip in $ips) {

        $ipInt = IPToInt $ip
        $skip = $false

        foreach ($r in $cidrRanges) {
            if ($ipInt -ge $r.start -and $ipInt -le $r.end) {
                $skip = $true
                break
            }
        }

        if (-not $skip) { $ip }
    }

    $uniqueData = $filteredIPs + $cidrs

    Write-Host "📊 Total après CIDR :" $uniqueData.Count
}
else {
    Write-Host "ℹ️ Optimisation CIDR désactivée"
}

# ================================
# SAVE
# ================================
$uniqueData | Out-File -Encoding ASCII $outputFile
$uniqueData.Count | Out-File -Encoding ASCII $countFile

Write-Host "✅ blacklist.txt généré"
Write-Host "📄 count.txt généré"

# ================================
# GIT PUSH
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