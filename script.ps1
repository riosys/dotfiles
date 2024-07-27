# Función para instalar programas
function Install-Program {
    param (
        [string]$programName
    )
    winget install --id $programName
}

# Instalar programas necesarios
Install-Program "Google.Chrome"
Install-Program "Microsoft.VisualStudioCode"
Install-Program "Brave.Brave"
Install-Program "Microsoft.PowerShell"
Install-Program "Neovim.Neovim"
Install-Program "JanDeDobbeleer.OhMyPosh"

# Lanzar una nueva terminal para ejecutar comandos específicos
Start-Process "powershell" -ArgumentList "-NoExit" -Command `"& {
    oh-my-posh font install JetBrainsMono;
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force;

    $terminalConfigPath = `"$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState`";
    if (-Not (Test-Path -Path $terminalConfigPath)) {
        New-Item -ItemType Directory -Force -Path $terminalConfigPath;
    }
    Copy-Item -Path `"C:\Users\rios\.dotfiles\terminal\settings.json`" -Destination `"$terminalConfigPath\settings.json`" -Force;

    $profileDirectory = Split-Path -Path $PROFILE -Parent;
    if (-Not (Test-Path -Path $profileDirectory)) {
        New-Item -ItemType Directory -Force -Path $profileDirectory;
    }
    Copy-Item -Path `"C:\Users\rios\.dotfiles\terminal\Microsoft.PowerShell_profile.ps1`" -Destination $PROFILE -Force;
    Start-Process `"powershell`" -ArgumentList `"-NoExit`";
    exit
}`"

exit
