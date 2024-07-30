# Función para instalar programas
function Install-Program {
    param (
        [string]$programName
        )
        winget install --id $programName
    }
    
# Instalar programas necesarios
Install-Program "Microsoft.VisualStudioCode"
Install-Program "CoreyButler.NVMforWindows"
Install-Program "JanDeDobbeleer.OhMyPosh"
Install-Program "Microsoft.PowerShell"
Install-Program "Discord.Discord"
Install-Program "Neovim.Neovim"
Install-Program "Google.Chrome"
Install-Program "Brave.Brave"
Install-Program "Valve.Steam"
    
# Terminal-Icons install
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
# Lanzar una nueva terminal para ejecutar comandos específicos
Start-Process "powershell" "-NoProfile", "oh-my-posh font install JetBrainsMono"

# Copiar configuración de Windows Terminal
$terminalConfigPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (-Not (Test-Path -Path $terminalConfigPath)) {
    New-Item -ItemType Directory -Force -Path $terminalConfigPath
}

Copy-Item -Path "C:\Users\rios\.dotfiles\terminal\settings.json" -Destination "$terminalConfigPath\settings.json" -Force

# Copiar configuración de PowerShell
$profileDirectory = Split-Path -Path $PROFILE -Parent
if (-Not (Test-Path -Path $profileDirectory)) {
    New-Item -ItemType Directory -Force -Path $profileDirectory
}

Copy-Item -Path "C:\Users\rios\.dotfiles\terminal\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force


