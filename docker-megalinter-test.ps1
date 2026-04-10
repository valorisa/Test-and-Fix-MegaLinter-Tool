# MegaLinter Docker Test Script
# Usage: .\docker-megalinter-test.ps1 [-Fix]

param(
    [switch]$Fix
)

$ProjectRoot = $PSScriptRoot
$TestFile = "test.md"
$BeforeFile = "$ProjectRoot\test-BEFORE.md"
$AfterFile = "$ProjectRoot\test-AFTER.md"

Write-Host "🔍 MegaLinter Docker Test (XML/Markdown hybride)" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

# Copy original
if (Test-Path $BeforeFile) { Remove-Item $BeforeFile -Force }
Copy-Item "$ProjectRoot\$TestFile" $BeforeFile
Write-Host "✅ Fichier original copié vers test-BEFORE.md" -ForegroundColor Green

# Run MegaLinter
$FixArg = if ($Fix) { "all" } else { "none" }
Write-Host "`n🚀 Lancement de MegaLinter..." -ForegroundColor Yellow

docker run --rm `
    -v "${ProjectRoot}:/workspace" `
    -e "GITHUB_WORKSPACE=/workspace" `
    -e "VALIDATE_ALL_CODEBASE=true" `
    -e "APPLY_FIXES=$FixArg" `
    megalinter/megalinter-documentation | Out-Host

# Copy after state
if (Test-Path $AfterFile) { Remove-Item $AfterFile -Force }
Copy-Item "$ProjectRoot\$TestFile" $AfterFile

Write-Host "`n📊 Fichiers de comparaison:" -ForegroundColor Cyan
Write-Host "  • test-BEFORE.md  → AVANT MegaLinter" -ForegroundColor Gray
Write-Host "  • test.md         → APRÈS MegaLinter" -ForegroundColor Gray
Write-Host "  • test-AFTER.md   → Copie de l'état après" -ForegroundColor Gray
Write-Host "`n→ Comparer avec: code test-BEFORE.md test.md" -ForegroundColor Green

if ($Fix) {
    Write-Host "`n⚠️ test.md a été modifié! Pour restaurer:" -ForegroundColor Red
    Write-Host "   Copy-Item test-BEFORE.md test.md -Force" -ForegroundColor Gray
}