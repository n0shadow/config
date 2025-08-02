Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

choco install nodejs-lts -y;

$usrPath = $PWD.Path
$usr = Split-Path $usrPath -Leaf
$dest = Join-Path $usrPath "AppData\Local"
$exec = Join-Path $dest "runserver.ps1"

$tsk = "NodeJS"

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$usr" `
    /rl limited