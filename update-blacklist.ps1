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
# INIT
# ================================
Write-Host "========================================="
Write-Host "🚀 START SCRIPT (FINAL CLEAN + COMMENTS)"
Write-Host "📁 Repo :" $repoDir
Write-Host "========================================="

$globalStart = Get-Date

# ================================
# LOAD URL LIST (WITH COMMENTS SUPPORT)
# ================================
Write-Host "📥 Chargement des sources..."

if (-not (Test-Path $listFile)) {
    Write-Host "❌ ExternalLists.txt introuvable"
    exit
}

$urls = [System.IO.File]::ReadAllLines($listFile) |
    ForEach-Object {
        $line = $_.Trim()

        # ignorer vide
        if (-not $line) { return }

        # ignorer commentaires complets
        if ($line -match '^\s*#') { return }

        # enlever commentaire inline
        if ($line -match '#') {
            $line = ($line -split '#')[0].Trim()
        }

        # garder uniquement URL valides
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
# STATS
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

Write-Host "📊 Total final :" $uniqueData.Count

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