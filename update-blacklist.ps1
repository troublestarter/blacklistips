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

$tempDir = [System.IO.Path]::GetTempPath()
$outputFile = Join-Path $tempDir "blacklist.txt"

# ================================
# INIT
# ================================
Write-Host "========================================="
Write-Host "🚀 START SCRIPT (PS7 PARALLEL)"
Write-Host "📁 Temp dir :" $tempDir
Write-Host "========================================="

$globalStart = Get-Date

# ================================
# GET URL LIST
# ================================
Write-Host "📥 Récupération des URLs..."

$urlsContent = (New-Object System.Net.WebClient).DownloadString($externalListUrl)

$urls = $urlsContent -split "`n" |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_ -ne "" -and -not $_.StartsWith("#") }

Write-Host "🔗 Nombre de sources :" $urls.Count

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
            if ($clean -and -not $clean.StartsWith("#")) {
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
# SAVE FILE
# ================================
$uniqueData | Out-File -Encoding ASCII $outputFile

Write-Host "✅ Fichier généré : $outputFile"
Write-Host "📊 Total IPs :" $uniqueData.Count

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
# PUSH (SAFE SANS ELSE)
# ================================
if (Test-Path ".git") {
    Write-Host "🚀 Repo détecté, push..."

    Copy-Item $outputFile .\blacklist.txt -Force

    git add blacklist.txt
    git commit -m "Auto update blacklist ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))" | Out-Null
    git push

    Write-Host "✅ Push OK"
}

if (-not (Test-Path ".git")) {
    Write-Host "ℹ️ Pas de repo git → aucun push"
}