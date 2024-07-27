# Copiar configuración de Windows Terminal$terminalConfigPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (-Not (Test-Path -Path $terminalConfigPath)) {
    New-Item -ItemType Directory -Force -Path $terminalConfigPath
}

Copy-Item -Path "C:\Users\rios\dotfiles\terminal\settings.json" -Destination "$terminalConfigPath\settings.json" -Force

# Copiar configuración de PowerShell
$profileDirectory = Split-Path -Path $PROFILE -Parent
if (-Not (Test-Path -Path $profileDirectory)) {
    New-Item -ItemType Directory -Force -Path $profileDirectory
}

Copy-Item -Path "C:\Users\rios\dotfiles\terminal\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force

Write-Output "SetUp finish!!!"