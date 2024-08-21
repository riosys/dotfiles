# Define foreground colors
$primary = "DarkMagenta"
$secondary = "DarkCyan"
$failed = "Red"
$success = "Green"
$warning = "Yellow"
# Define Background
$textWhite = "White"
$textBlack = "Black"

Clear-Host
# Primer conjunto de mensajes
Write-Host " STARTING ARMANDO-RIOS SETUP SCRIPT... " -ForegroundColor $textBlack -Background $primary

# Esperar 3 segundos
Start-Sleep -Seconds 3

Clear-Host

# Ruta al ejecutable de Git
$gitPath = "C:\Program Files\Git\cmd\git.exe"
# Comando Git para clonar el repositorio
$clone = "clone"
#repository
$repo = "https://github.com/armando-rios/dotfiles.git"

$ruteClone = ".dotfiles"
# Ejecutar Git
# & $gitPath $clone $repo

# Start-Sleep -Seconds 2

function Is-GitInstalled {
    try {
        git --version > $null 2>&1
        return $true
    } catch {
        return $false
    }
}


function Install-Git {
    Write-Host "Git no está instalado. ¿Deseas instalarlo ahora? (S/N)" -ForegroundColor $textWhite -Background $Yellow
    $input = Read-Host

    if ($input -eq 'S' -or $input -eq 's') {
        winget install --id Git.Git -e
        Write-Host "Git se ha instalado correctamente." -ForegroundColor $textBlack -Background $success
    } else {
        Write-Host "Git no se instalará. Algunas configuraciones pueden fallar si este no esta instalado." -ForegroundColor $textBlack -Background $Yellow
    }
}


function Show-SelectionMenu {
    param (
        [string[]]$optionList,
        [string]$prompt
    )
    
    $selectedOptions = @()
    $index = 0
    $maxIndex = $optionList.Length - 1

    Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host $prompt -ForegroundColor Blue
    Write-Host " Use the up and down arrow keys to navigate. Press [Space] to select/deselect, and [Enter] to continue. " -ForegroundColor $textBlack -Background $secondary

    while ($true) {
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host "Use the up and down arrow keys to navigate. Press [Space] to select/deselect, and [Enter] to continue." -ForegroundColor $textBlack -Background $secondary
        Write-Host " "
        Write-Host $prompt -ForegroundColor Blue

        for ($i = 0; $i -lt $optionList.Length; $i++) {
            if ($i -eq $index) {
                Write-Host "> " -NoNewline -ForegroundColor Yellow
            } else {
                Write-Host "  " -NoNewline
            }

            if ($selectedOptions -contains $optionList[$i]) {
                Write-Host "[X] $($optionList[$i])" -ForegroundColor Green
            } else {
                Write-Host "[ ] $($optionList[$i])" 
            }
        }

        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        switch ($key) {
            38 { # Flecha arriba
                $index = if ($index -gt 0) { $index - 1 } else { $maxIndex }
            }
            40 { # Flecha abajo
                $index = if ($index -lt $maxIndex) { $index + 1 } else { 0 }
            }
            32 { # Espacio
                if ($selectedOptions -contains $optionList[$index]) {
                    $selectedOptions = $selectedOptions -ne $optionList[$index]
                } else {
                    $selectedOptions += $optionList[$index]
                }
            }
            13 { # Enter
                return $selectedOptions
            }
        }
    }
}

function Install-Program {
    param (
        [string]$programName
    )
    winget install --id $programName
}

# Verifica si Git está instalado
if (-not (Is-GitInstalled)) {
    Install-Git
}

# Primera sección: Selección de tareas
$tareas = @(
    "Instalación completa",
    "Instalar programas",
    "Configurar e instalar terminal"
)

$selectedTareas = Show-SelectionMenu -optionList $tareas -prompt "Selecciona las tareas que deseas realizar:"

# Si se selecciona "Instalación completa", automáticamente selecciona todas las opciones
if ($selectedTareas -contains "Instalación completa") {
    $selectedTareas = @("Instalar programas", "Configurar e instalar terminal")
}

# Segunda sección: Selección de programas si "Instalar programas" está seleccionado
if ($selectedTareas -contains "Instalar programas") {
    $programs = @(
        "Microsoft.VisualStudioCode",
        "CoreyButler.NVMforWindows",
        "Microsoft.WindowsTerminal",
        "JanDeDobbeleer.OhMyPosh",
        "Microsoft.Powershell",
        "Python.Python.3.12",
        "Discord.Discord",
        "Neovim.Neovim",
        "Google.Chrome",
        "Valve.Steam",
        "Brave.Brave",
        "Chocolatey"
    )

    $selectedPrograms = Show-SelectionMenu -optionList $programs -prompt "Selecciona los programas que deseas instalar:"

    foreach ($program in $selectedPrograms) {
        Clear-Host
        Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
        Write-Host " "
        Write-Host "`t` ■ Instalando $program " -ForegroundColor $textWhite -Background Blue
        Install-Program -programName $program
    }
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " ● Programas Instalados " -ForegroundColor $textBlack -Background $success
}

# Ejemplo de configuración e instalación de terminal si está seleccionado
if ($selectedTareas -contains "Configurar e instalar terminal") {

    & $gitPath $clone $repo $ruteClone

    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " ● Programas Instalados " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Installing Terminal Icons... " -ForegroundColor $textBlack -Background $secondary

    # Terminal-Icons install
    Start-Process pwsh -ArgumentList '-NoProfile -Command "Install-Module -Name Terminal-Icons -Repository PSGallery -Force"' -Wait

    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " ● Programas Instalados " -ForegroundColor $textBlack -Background $success
    Write-Host " ● Terminal Icons Installed " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Installing JetBrainsMono NerdFont... " -ForegroundColor $textBlack -Background $secondary

    # oh-my-posh font install
    Start-Process pwsh -ArgumentList "-NoProfile -Command `"$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe font install JetBrainsMono`"" -Wait

    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " ● Programas Instalados " -ForegroundColor $textBlack -Background $success
    Write-Host " ● Terminal Icons Installed " -ForegroundColor $textBlack -Background $success
    Write-Host " ● Oh-my-posh installed and configured fonts " -ForegroundColor $textBlack -Background $success
    Write-Host " "
    Write-Host "`t` Configuring files... " -ForegroundColor $textBlack -Background $secondary

    Start-Sleep -Seconds 2
    Clear-Host
    Write-Host " RUNNING CONFIGURATION SCRIPT R105 " -ForegroundColor $textBlack -Background $primary
    Write-Host " "
    Write-Host " ● Programas Instalados " -ForegroundColor $textBlack -Background $success
    Write-Host " ● Terminal Icons Installed " -ForegroundColor $textBlack -Background $success
    Write-Host " ● Oh-my-posh installed and configured fonts " -ForegroundColor $textBlack -Background $success
    Write-Host " ● File configs required configured " -ForegroundColor $textBlack -Background $success
    # Copy Windows Terminal configuration
    $terminalConfigPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    if (-Not (Test-Path -Path $terminalConfigPath)) {
        New-Item -ItemType Directory -Force -Path $terminalConfigPath
    }

    Copy-Item -Path "$env:USERPROFILE\.dotfiles\terminal\settings.json" -Destination "$terminalConfigPath\settings.json" -Force

    # Copy PowerShell configuration
    # Asigna manualmente la ruta correcta a la variable $PROFILE
    $PROFILE = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

    # Obtiene el directorio del perfil
        $profileDirectory = Split-Path -Path $PROFILE -Parent
    
    # Verifica si el directorio del perfil no existe y lo crea si es necesario
    if (-Not (Test-Path -Path $profileDirectory)) {
        New-Item -ItemType Directory -Force -Path $profileDirectory
    }
    
    # Copia el archivo de perfil de PowerShell al destino especificado en $PROFILE
    Copy-Item -Path "$env:USERPROFILE\.dotfiles\terminal\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
    
}

Write-Host " "
Write-Host " Tareas completadas cierra esta terminal e inicia otra. " -ForegroundColor $textBlack -Background $warning