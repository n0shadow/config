Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

choco install nodejs-lts -y;

$usrPath = $PWD.Path
$usr = Split-Path $usrPath -Leaf
$dest = Join-Path $usrPath "AppData\Local"
$exec = Join-Path $dest "runserver.vbs"

$tsk = "NodeJS"

schtasks.exe /end /tn $tsk
schtasks.exe /delete /tn $tsk /f

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$usr" `
    /rl limited

assoc .vbs=VBSFile
ftype VBSFile="%SystemRoot%\System32\WScript.exe" "%1" %*