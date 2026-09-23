# Automatic GitHub Deployment Script for Spice Street (Free Domain)
param(
    [string]$RepoUrl = ""
)

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  SPICE STREET - GITHUB PAGES FREE DOMAIN DEPLOYMENT   " -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# 1. Package the deployment archive
Write-Host "[1/2] Creating production package (spice-street-deploy.zip)..." -ForegroundColor Cyan
$zipDeploy = Join-Path $ScriptDir "spice-street-deploy.zip"
$itemsToZip = @("index.html", "dashboard.html", "css", "js", "assets", "README.md", ".github", ".gitignore")
$existingItems = @()
foreach ($item in $itemsToZip) {
    $fullPath = Join-Path $ScriptDir $item
    if (Test-Path $fullPath) {
        $existingItems += $fullPath
    }
}

if ($existingItems.Count -gt 0) {
    Compress-Archive -Path $existingItems -DestinationPath $zipDeploy -Force
    Write-Host "      ✓ Ready: spice-street-deploy.zip" -ForegroundColor Green
}

# 2. Check for Git
$gitCmd = $null
$possiblePaths = @(
    "git",
    "C:\Program Files\Git\cmd\git.exe",
    "C:\Program Files\Git\bin\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe"
)

foreach ($p in $possiblePaths) {
    if (Get-Command $p -ErrorAction SilentlyContinue) {
        $gitCmd = $p
        break
    }
    if (Test-Path $p) {
        $gitCmd = $p
        break
    }
}

if ($gitCmd) {
    Write-Host ""
    Write-Host "[2/2] Git detected ($gitCmd)" -ForegroundColor Green
    
    if (-not (Test-Path (Join-Path $ScriptDir ".git"))) {
        Write-Host "      Initializing repository..." -ForegroundColor Cyan
        & $gitCmd init -b main
        & $gitCmd config user.name "Vinay Palsam"
        & $gitCmd config user.email "vinay@spicestreet.in"
    }

    if ([string]::IsNullOrWhiteSpace($RepoUrl)) {
        Write-Host ""
        Write-Host "Enter your GitHub repository URL (e.g. https://github.com/your-username/spice-street.git):" -ForegroundColor Yellow
        $RepoUrl = Read-Host "Repo URL"
    }

    if (-not [string]::IsNullOrWhiteSpace($RepoUrl) -and $RepoUrl -ne "SKIP") {
        & $gitCmd remote remove origin 2>$null
        & $gitCmd remote add origin $RepoUrl.Trim()
        & $gitCmd add .
        & $gitCmd commit -m "Deploy Spice Street to GitHub Pages with Free Domain"
        & $gitCmd push -u origin main
        
        Write-Host ""
        Write-Host "✓ Pushed successfully to GitHub!" -ForegroundColor Green
        if ($RepoUrl -match "github\.com[/:]([^/]+)/([^/\.]+)") {
            $user = $matches[1]
            $repo = $matches[2]
            $freeUrl = "https://$user.github.io/$repo/"
            Write-Host "🎉 Your free domain is: $freeUrl" -ForegroundColor Yellow
            Write-Host "🎉 Kitchen Dashboard: ${freeUrl}dashboard.html" -ForegroundColor Yellow
        }
    }
}

if (-not $gitCmd -or $RepoUrl -eq "SKIP") {
    Write-Host ""
    Write-Host "[2/2] Free Deployment Methods Available:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  METHOD 1 (Official Free GitHub Domain - 100% Free):" -ForegroundColor Green
    Write-Host "  1. Go to https://github.com/new"
    Write-Host "  2. Name repository 'spice-street' and create it"
    Write-Host "  3. Click 'Upload files' and drag all files (or 'spice-street-deploy.zip')"
    Write-Host "  4. In repo Settings -> Pages -> Source: select 'GitHub Actions' (or main branch)"
    Write-Host "  -> Your free domain: https://<your-username>.github.io/spice-street/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  METHOD 2 (Instant 10-Second Free Domain):" -ForegroundColor Green
    Write-Host "  Drag 'spice-street-deploy.zip' directly to: https://app.netlify.com/drop"
    Write-Host "  -> Gives an instant live free HTTPS website with 0 setup!" -ForegroundColor Yellow
}
