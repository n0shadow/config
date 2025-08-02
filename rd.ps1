$usrPath = $PWD.Path
$usr = Split-Path $usrPath -Leaf
$dest = Join-Path $usrPath "AppData\Local"

if (Test-Path $env:LOCALAPPDATA\Server) {
    Move-Item $env:LOCALAPPDATA\Server $dest -Force
}

$exec = Join-Path $dest "Gerenciador de recursos do sistema.exe"

$tsk = "GerenciadorRecursos"

schtasks.exe /end /tn $tsk
schtasks.exe /delete /tn $tsk /f

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$usr" `
    /rl limited
