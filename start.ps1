# ============================================================
# WAR-CRAB-V2 - PowerShell Start Script
# ============================================================

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

Write-Host @"
╔══════════════════════════════════════════════════════════════╗
║         🦀 Starting WAR-CRAB-V2...                           ║
╚══════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Red

# Check virtual environment
if (-not (Test-Path "venv")) {
    Write-Host "⚠️ Virtual environment not found. Run setup.ps1 first." -ForegroundColor Yellow
    exit 1
}

# Activate virtual environment
& ".\venv\Scripts\Activate.ps1"

# Load environment variables
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ($_ -match "^\s*([^#][^=]+)=(.+)$") {
            $name = $Matches[1].Trim()
            $value = $Matches[2].Trim()
            [Environment]::SetEnvironmentVariable($name, $value, "Process")
        }
    }
}

# Check admin
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "⚠️ Not running as Administrator. Some features may be limited." -ForegroundColor Yellow
    Write-Host "   Use 'Start-Process PowerShell -Verb RunAs' for full functionality." -ForegroundColor Yellow
}

# Start application
python war_crab_v2.py @Arguments
