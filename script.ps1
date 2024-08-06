# Define colors using the Catppuccin Mocha theme
$promptColor = "DarkGreen"  # F9E2AF
$defaultColor = "Red"  # CDD6F4
$successColor = "yellow"  # A6E3A1
$errorColor = "DarkMagenta"  # F38BA8
$infoColor = "DarkCyan"  # 89DCEB

# Function to display the prompt with colors
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

$response = ColoredRead-Host "Do you want to install the programs? (y/n)"

if ($response -eq '' -or $response -eq 'y') {
    function Install-Program {
        param (
            [string]$programName
        )
        Write-Host " "
        $response = ColoredRead-Host "Do you want to install? $programName (y/n)"
        Write-Host " "
        if ($response -eq '' -or $response -eq 'y') {
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            Write-Host "`t` `t`Installing $programName" -ForegroundColor $infoColor
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            winget install --id $programName
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            Write-Host "`t` `t` $programName has been installed." -ForegroundColor $successColor
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
        } else {
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
            Write-Host "`t` `t` $programName will not be installed." -ForegroundColor $errorColor
            Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
        }
    }

    # Install basic programs
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
    Write-Host "`t` `t`Program installation has finished!" -ForegroundColor $successColor
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
} else {
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
    Write-Host "`t` `t`No programs will be installed!" -ForegroundColor $errorColor
    Write-Host "`t`----------------------------------------------------" -ForegroundColor $infoColor
}

Write-Host "`t`----------------------------------------------------" -ForegroundColor $defaultColor
Write-Host "`t` `t`Installing Terminal Icons..." -ForegroundColor $promptColor
Write-Host "`t`----------------------------------------------------" -ForegroundColor $defaultColor
# Terminal-Icons install
Start-Process pwsh -ArgumentList '-NoProfile -Command "Install-Module -Name Terminal-Icons -Repository PSGallery -Force"' -Wait

Write-Host "`t`----------------------------------------------------" -ForegroundColor $defaultColor
Write-Host "`t` `t`Installing JetBrainsMono NerdFont..." -ForegroundColor $promptColor
Write-Host "`t`----------------------------------------------------" -ForegroundColor $defaultColor
# oh-my-posh font install
Start-Process pwsh -ArgumentList "-NoProfile -Command `"$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe font install JetBrainsMono`"" -Wait

Write-Host "`t`----------------------------------------------------" -ForegroundColor $defaultColor
Write-Host "`t` `t`Configuring files..." -ForegroundColor $promptColor
Write-Host "`t`----------------------------------------------------" -ForegroundColor $defaultColor

# Copy Windows Terminal configuration
$terminalConfigPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (-Not (Test-Path -Path $terminalConfigPath)) {
    New-Item -ItemType Directory -Force -Path $terminalConfigPath
}

Copy-Item -Path "$env:USERPROFILE\.dotfiles\terminal\settings.json" -Destination "$terminalConfigPath\settings.json" -Force

# Copy PowerShell configuration
$profileDirectory = Split-Path -Path $PROFILE -Parent
if (-Not (Test-Path -Path $profileDirectory)) {
    New-Item -ItemType Directory -Force -Path $profileDirectory
}

Copy-Item -Path "$env:USERPROFILE\.dotfiles\terminal\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force

Write-Host "`t`----------------------------------------------------" -ForegroundColor $promptColor
Write-Host "`t` `t`Configuration Finished!" -ForegroundColor $infoColor
Write-Host "`t`----------------------------------------------------" -ForegroundColor $promptColor

# Open a new terminal and close the current one
Start-Process pwsh
exit