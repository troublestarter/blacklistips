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
$externalListUrl = "https://raw.githubusercontent.com/troublestarter/blacklistips/main/ExternalLists.txt"

$repoDir = Get-Location
$outputFile = Join-Path $repoDir "blacklist.txt"
$countFile = Join-Path $repoDir "count.txt"

# ================================
# INIT
# ================================
Write-Host "========================================="
Write-Host "🚀 START SCRIPT (IP + CIDR + COUNT)"
Write-Host "📁 Repo dir :" $repoDir
Write-Host "========================================="

$globalStart = Get-Date

# ================================
# GET URL LIST
# ================================
Write-Host "📥 Récupération des URLs (local)..."

$localFile = Join-Path (Get-Location) "ExternalLists.txt"

if (-not (Test-Path $localFile)) {
    Write-Host "❌ ExternalLists.txt introuvable"
    exit
}

$urls = Get-Content $localFile |
    ForEach-Object { $_.Trim() } |
    Where-Object {
        $_ -ne "" -and
        -not $_.StartsWith("#") -and
        $_ -match '^https?://'
    }

Write-Host "🔗 Nombre de sources :" $urls.Count

# DEBUG (optionnel)
$urls | ForEach-Object { Write-Host "→ $_" }

# ================================
# DOWNLOAD (PARALLEL x2)
# ================================
Write-Host "📥 Téléchargement (max 2 en parallèle)..."

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

            if (-not $clean -or $clean.StartsWith("#")) {
                continue
            }

            if ($clean -match '^\d{1,3}(\.\d{1,3}){3}$' -or
                $clean -match '^\d{1,3}(\.\d{1,3}){3}/\d{1,2}$') {
                [void]$result.Add($clean)
            }
        }

        Write-Host "✅ OK : $url"
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

$cleanStart = Get-Date

$uniqueData = $tempData |
    Where-Object { $_ -ne "" } |
    Sort-Object -Unique

$cleanEnd = Get-Date

# ================================
# VALIDATION
# ================================
if ($uniqueData.Count -lt 10) {
    Write-Host "❌ ERREUR : blacklist trop petite → abort"
    exit
}

# ================================
# SAVE FILES
# ================================
$uniqueData | Out-File -Encoding ASCII $outputFile

# 🔥 COUNT FILE
$uniqueData.Count | Out-File -Encoding ASCII $countFile

Write-Host "✅ blacklist.txt généré"
Write-Host "📊 Total entrées :" $uniqueData.Count
Write-Host "📄 count.txt généré"

# ================================
# TIMINGS
# ================================
$totalEnd = Get-Date

Write-Host "========================================="
Write-Host "⏱️ Download :" ($downloadEnd - $downloadStart).TotalSeconds "sec"
Write-Host "⏱️ Clean :" ($cleanEnd - $cleanStart).TotalSeconds "sec"
Write-Host "⏱️ Total :" ($totalEnd - $globalStart).TotalSeconds "sec"
Write-Host "========================================="

# ================================
# GIT PUSH
# ================================
if (Test-Path ".git") {
    Write-Host "🚀 Push vers GitHub..."

git add .
git commit -m "Auto update blacklist ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))" | Out-Null
git push

    Write-Host "✅ Push OK"
}
else {
    Write-Host "❌ Pas de repo git"
}