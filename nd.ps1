Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

choco install nodejs-lts -y;

schtasks.exe /create /tn "NodeJS" /tr "'$env:LOCALAPPDATA\Server\runserver.vbs'" /sc onlogon /rl highest;
