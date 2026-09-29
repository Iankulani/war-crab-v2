# ============================================================
# WAR-CRAB-V2 - PowerShell Setup Script
# ============================================================

#Requires -Version 5.1

param(
    [switch]$SkipSystemDeps,
    [switch]$SkipVenv,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Colors
function Write-Color {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

function Write-Banner {
    Write-Color @"
╔══════════════════════════════════════════════════════════════╗
║         🦀 WAR-CRAB-V2 - Setup Script v2.0.0                ║
║         Ultimate Cybersecurity Platform                      ║
╚══════════════════════════════════════════════════════════════╝
"@ -Color Red
}

function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-Python {
    Write-Color "`n🔍 Checking Python installation..." -Color Blue
    
    try {
        $pythonVersion = python --version 2>&1
        if ($pythonVersion -match "Python (\d+)\.(\d+)") {
            $major = [int]$Matches[1]
            $minor = [int]$Matches[2]
            
            if ($major -ge 3 -and $minor -ge 8) {
                Write-Color "✅ Python $major.$minor found (compatible)" -Color Green
                return $true
            } else {
                Write-Color "❌ Python 3.8+ required. Found: $major.$minor" -Color Red
                return $false
            }
        }
    } catch {
        Write-Color "❌ Python not found. Please install Python 3.8+ from python.org" -Color Red
        return $false
    }
    
    return $false
}

function Install-SystemDeps {
    Write-Color "`n📦 Installing system dependencies..." -Color Blue
    
    # Check for winget
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Color "Using winget to install dependencies..." -Color Yellow
        
        $packages = @(
            "Python.Python.3.11",
            "Git.Git",
            "Docker.DockerDesktop",
            "Kubernetes.kubectl",
            "Kubernetes.helm",
            "Insecure.Nmap",
            "curl.curl",
            "GnuWin32.Make"
        )
        
        foreach ($package in $packages) {
            Write-Color "Installing $package..." -Color Yellow
            try {
                winget install --id $package --accept-source-agreements --accept-package-agreements --silent
            } catch {
                Write-Color "⚠️ Failed to install $package" -Color Yellow
            }
        }
    } else {
        Write-Color "⚠️ winget not found. Please install dependencies manually." -Color Yellow
        Write-Color "Required tools:" -Color Yellow
        Write-Color "  - Python 3.8+" -Color White
        Write-Color "  - Git" -Color White
        Write-Color "  - Nmap" -Color White
        Write-Color "  - Docker Desktop (optional)" -Color White
    }
}

function New-VirtualEnvironment {
    Write-Color "`n🐍 Creating Python virtual environment..." -Color Blue
    
    if (Test-Path "venv") {
        if ($Force) {
            Write-Color "Removing existing virtual environment..." -Color Yellow
            Remove-Item -Recurse -Force "venv"
        } else {
            Write-Color "⚠️ Virtual environment already exists" -Color Yellow
            $recreate = Read-Host "Do you want to recreate it? (y/n)"
            if ($recreate -eq "y") {
                Remove-Item -Recurse -Force "venv"
            } else {
                return
            }
        }
    }
    
    python -m venv venv
    Write-Color "✅ Virtual environment created" -Color Green
}

function Install-PythonDeps {
    Write-Color "`n📦 Installing Python dependencies..." -Color Blue
    
    # Activate virtual environment
    & ".\venv\Scripts\Activate.ps1"
    
    # Upgrade pip
    python -m pip install --upgrade pip setuptools wheel
    
    # Install requirements
    if (Test-Path "requirements.txt") {
        pip install -r requirements.txt
        Write-Color "✅ Python dependencies installed" -Color Green
    } else {
        Write-Color "❌ requirements.txt not found" -Color Red
        throw "requirements.txt not found"
    }
}

function Set-Configuration {
    Write-Color "`n⚙️ Setting up configuration..." -Color Blue
    
    $directories = @(
        ".war_crab_v2",
        ".war_crab_v2\payloads",
        ".war_crab_v2\workspaces",
        ".war_crab_v2\scans",
        ".war_crab_v2\phishing_pages",
        ".war_crab_v2\captured_credentials",
        ".war_crab_v2\keylog_exfil",
        ".war_crab_v2\deployments",
        ".war_crab_v2\domain_hosting",
        ".war_crab_v2\dns_cache",
        "war_crab_v2_reports",
        "war_crab_v2_reports\graphics",
        "logs",
        "temp"
    )
    
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
    }
    
    # Copy .env
    if (-not (Test-Path ".env") -and (Test-Path ".env.example")) {
        Copy-Item ".env.example" ".env"
        Write-Color "✅ Created .env from template" -Color Green
    }
    
    Write-Color "✅ Configuration directories created" -Color Green
}

function Test-Installation {
    Write-Color "`n🔍 Verifying installation..." -Color Blue
    
    & ".\venv\Scripts\Activate.ps1"
    
    $testScript = @"
import sys
try:
    import requests
    import psutil
    import cryptography
    print('✅ Core dependencies verified')
except ImportError as e:
    print(f'❌ Missing dependency: {e}')
    sys.exit(1)
"@
    
    $result = python -c $testScript
    
    if ($LASTEXITCODE -ne 0) {
        throw "Installation verification failed"
    }
    
    if (Test-Path "war_crab_v2.py") {
        python -m py_compile war_crab_v2.py
        if ($LASTEXITCODE -eq 0) {
            Write-Color "✅ Main script compiles successfully" -Color Green
        }
    }
}

function Show-Summary {
    Write-Color @"

╔══════════════════════════════════════════════════════════════╗
║              🦀 SETUP COMPLETE! 🦀                           ║
╚══════════════════════════════════════════════════════════════╝

"@ -Color Green
    
    Write-Color "To start WAR-CRAB-V2:" -Color Cyan
    Write-Color "  .\venv\Scripts\Activate.ps1" -Color Green
    Write-Color "  python war_crab_v2.py" -Color Green
    Write-Color ""
    Write-Color "Or use:" -Color Cyan
    Write-Color "  .\scripts\start.ps1" -Color Green
    Write-Color ""
    Write-Color "Docker:" -Color Cyan
    Write-Color "  docker-compose up -d" -Color Green
    Write-Color ""
    Write-Color "Kubernetes:" -Color Cyan
    Write-Color "  kubectl apply -f kubernetes/" -Color Green
    Write-Color ""
    Write-Color "⚠️ For authorized security testing only!" -Color Yellow
    Write-Color ""
}

# ==================== MAIN ====================
function Main {
    Write-Banner
    
    # Check admin
    if (-not (Test-Admin)) {
        Write-Color "⚠️ Not running as Administrator" -Color Yellow
        Write-Color "   Some features may be limited" -Color Yellow
        Write-Color "   Consider running as Administrator for full functionality" -Color Yellow
    }
    
    # Check Python
    if (-not (Test-Python)) {
        exit 1
    }
    
    # Install system deps
    if (-not $SkipSystemDeps) {
        Install-SystemDeps
    }
    
    # Create venv
    if (-not $SkipVenv) {
        New-VirtualEnvironment
    }
    
    # Install Python deps
    Install-PythonDeps
    
    # Setup config
    Set-Configuration
    
    # Verify
    Test-Installation
    
    # Summary
    Show-Summary
}

# Run
Main
