# install.ps1
param(
    [string]$InstallDir = "$Env:ProgramFiles\veb"
)

# Download config
$ConfigUrl = "https://vebinstall.overload.studio/bin/install-config.sh"
Write-Host "Downloading config from $ConfigUrl"
Invoke-WebRequest -Uri $ConfigUrl -OutFile "$env:TEMP\veb-install-config.sh"
# Note: PowerShell cannot directly “source” a bash script. We’ll parse manually.

# Simple parsing of needed variables
$cfg = Get-Content "$env:TEMP\veb-install-config.sh"
foreach ($line in $cfg) {
    if ($line -match '^BASE_URL="(.+)"') { $BaseUrl = $matches[1] }
    if ($line -match '^ASSET_WIN_X64="(.+)"') { $AssetWin = $matches[1] }
}

if (!$BaseUrl -or !$AssetWin) {
    Write-Error "Could not parse config file"
    exit 1
}

$DlUrl = "$BaseUrl/$AssetWin"
Write-Host "Downloading binary from $DlUrl"

$OutFile = "$env:TEMP\veb.exe"
Invoke-WebRequest -Uri $DlUrl -OutFile $OutFile

# Create installation directory
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}

# Move binary
Move-Item -Path $OutFile -Destination "$InstallDir\veb.exe" -Force

# Add to PATH (for current user)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($env:Path -notlike "*$InstallDir*") {
    Write-Host "Adding $InstallDir to user PATH"
    [System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$InstallDir", "User")
    Write-Host "Please restart your PowerShell session or log out/in to use 'veb'"
}

Write-Host "Installation complete. Run `veb --help`"
