# OhMyPosh prompt init
oh-my-posh init pwsh --config ~/.dotfiles/Terminal/themes/r105.omp.json | Invoke-Expression

# Terminal icons init
Import-Module Terminal-Icons

#Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig "C:\Program Files\Git\usr\bin\tig.exe"
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"

function dev {
    param (
        [string]$project = ""
    )
    $workDir = "D:\Dev"
    if($project -ne "") {
        $targetDir = Join-Path $workDir $project
    } else {
        $targetDir = $workDir
    }
    if(Test-Path $targetDir) {
        Set-Location $targetDir
    } else {
        Write-Host "El proyecto '$project' no existe en '$workDir'" - ForegroundColor Red
    }
}
