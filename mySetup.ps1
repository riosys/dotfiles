# Define foreground
$primary = "DarkMagenta"
$secondary = "DarkCyan"
$failed = "Red"
$success = "Green"
$warning = "Yellow"
$info = "Blue"

# urls
$dotfiles = "https://raw.githubusercontent.com/Armando-Rios/dotfiles/main/script.ps1"

# Define background
$background = "DarkGray"

# Función para limpiar un número específico de líneas
function Clear-PreviousLines {
    param (
        [int]$lineCount = 3
    )
    $esc = [char]27
    $reset = "${esc}[0K"     # Borra la línea desde el cursor hasta el final
    $moveUp = "${esc}[1A"    # Mueve el cursor hacia arriba una línea

    # Calcular dinámicamente cuántas líneas limpiar
    $currentCursorPos = $Host.UI.RawUI.CursorPosition.Y
    $linesToClear = $currentCursorPos - $lineCount

    for ($i = 0; $i -lt $linesToClear; $i++) {
        Write-Host "$moveUp$reset" -NoNewline
    }
}

# Primer conjunto de mensajes
Write-Host "————————————————————————————————" -ForegroundColor $info
Write-Host "`t` running Set Up..." -ForegroundColor $info
Write-Host "————————————————————————————————" -ForegroundColor $info

# Esperar 3 segundos
Start-Sleep -Seconds 3

# Limpiar las líneas anteriores
Clear-PreviousLines

# Segundo conjunto de mensajes
Write-Host "————" -ForegroundColor $info
Write-Host "`t` Installing" -ForegroundColor $info
Write-Host "————" -ForegroundColor $info


winget install --id "Git.Git"

# Ruta al ejecutable de Git
$gitPath = "C:\Program Files\Git\cmd\git.exe"
# Comando Git para clonar el repositorio
$clone = "clone"
#repository
$repo = "https://github.com/r105dev/r105dev.git"

# Ejecutar Git
& $gitPath $clone $repo

Start-Sleep -Seconds 2

# !Install Programs

function Show-ProgramSelection {
    param (
        [string[]]$programList
    )

    $selectedPrograms = @()
    $index = 0
    $maxIndex = $programList.Length - 1

    # Instrucciones para la interfaz

    while ($true) {
        Clear-PreviousLines
        Write-Host "Use the up and down arrow keys to navigate. Press [Space] to select/deselect, and [Enter] to continue." -ForegroundColor Yellow
        Write-Host "Select the programs you want to install:" -ForegroundColor Cyan

        for ($i = 0; $i -lt $programList.Length; $i++) {
            if ($i -eq $index) {
                Write-Host "> " -NoNewline -ForegroundColor Yellow
            } else {
                Write-Host "  " -NoNewline
            }

            if ($selectedPrograms -contains $programList[$i]) {
                Write-Host "[X] $($programList[$i])" -ForegroundColor Green
            } else {
                Write-Host "[ ] $($programList[$i])"
            }
        }

        # Captura las teclas presionadas
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

        switch ($key) {
            38 { # Flecha arriba
                $index = if ($index -gt 0) { $index - 1 } else { $maxIndex }
            }
            40 { # Flecha abajo
                $index = if ($index -lt $maxIndex) { $index + 1 } else { 0 }
            }
            32 { # Espacio
                if ($selectedPrograms -contains $programList[$index]) {
                    $selectedPrograms = $selectedPrograms -ne $programList[$index]
                } else {
                    $selectedPrograms += $programList[$index]
                }
            }
            13 { # Enter
                return $selectedPrograms
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

# Lista de programas disponibles
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

# Muestra la interfaz de selección
$selectedPrograms = Show-ProgramSelection -programList $programs

# Instala los programas seleccionados
foreach ($program in $selectedPrograms) {
    Install-Program -programName $program
}



# !Ending Script 
# Start-Sleep -Seconds 3
# # Limpiar las líneas anteriores
# Clear-PreviousLines

# # Mensaje de instalación completada
# Write-Host "————————————————————————————————————————" -ForegroundColor $info
# Write-Host "`t` Installation completed" -ForegroundColor $info
# Write-Host "————————————————————————————————————————" -ForegroundColor $info