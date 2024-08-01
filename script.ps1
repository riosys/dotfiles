# Definir colores usando el tema Catppuccin Mocha
$promptColor = "DarkGreen"  # F9E2AF
$defaultColor = "Red"  # CDD6F4
$successColor = "yellow"  # A6E3A1
$errorColor = "DarkMagenta"  # F38BA8
$infoColor = "DarkCyan"  # 89DCEB

# Función para mostrar el prompt con colores
function ColoredRead-Host {
    param (
        [string]$message
    )
    $origColor = $Host.UI.RawUI.ForegroundColor
    $Host.UI.RawUI.ForegroundColor = $promptColor
    $response = Read-Host $message
    $Host.UI.RawUI.ForegroundColor = $defaultColor
    return $response
}

$response = ColoredRead-Host "¿Quieres instalar los programas? (y/n)"

if ($response -eq '' -or $response -eq 'y') {
    function Install-Program {
        param (
            [string]$programName
        )
    Write-Host " "
    $response = ColoredRead-Host "Quieres instalar? $programName (y/n)"
    Write-Host " "
        if ($response -eq '' -or $response -eq 'y') {
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            Write-Host "`t` `t`Instalando $programName" -ForegroundColor $infoColor
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            winget install --id $programName
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            Write-Host "`t` `t` $programName ha sido instalado." -ForegroundColor $successColor
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
        } else {
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            Write-Host "`t` `t` $programName no será instalado." -ForegroundColor $errorColor
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
        }
    }

    # Instalar programas básicos
    Install-Program "Microsoft.VisualStudioCode"
    Install-Program "CoreyButler.NVMforWindows"
    Install-Program "Microsoft.WindowsTerminal"
    Install-Program "JanDeDobbeleer.OhMyPosh"
    Install-Program "Microsoft.Powershell"
    Install-Program "Python.Python.3.12"
    Install-Program "Discord.Discord"
    Install-Program "Neovim.Neovim"
    Install-Program "Google.Chrome"
    Install-Program "Valve.Steam"
    Install-Program "Brave.Brave"
    Install-Program "Chocolatey"
    
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
    Write-Host "`t` `t`La instalación de programas ha terminado!" -ForegroundColor $successColor
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
} else {
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
    Write-Host "`t` `t`No se instalaran programas!" -ForegroundColor $errorColor
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
}

# Terminal-Icons install
Start-Process powershell -ArgumentList '-NoProfile -NoExit -Command "Install-Module -Name Terminal-Icons -Repository PSGallery -Force; exit"'
# Lanzar una nueva terminal para ejecutar comandos específicos
Start-Process "powershell" "-NoProfile", "oh-my-posh font install JetBrainsMono" -Wait

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

Write-Host "`t`----------------------------------------------------" -ForegroundColor $promptColor
Write-Host "`t` `t`Configuracion Finalizada!" -ForegroundColor $infoColor
Write-Host "`t`----------------------------------------------------" -ForegroundColor $promptColor