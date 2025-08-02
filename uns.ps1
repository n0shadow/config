$tsk1 = "GerenciadorRecursos"
$tsk2 = "NodeJS"

schtasks.exe /end /tn $tsk1
schtasks.exe /end /tn $tsk2

Get-Process -Name "Gerenciador de Recursos do Sistema" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-CimInstance Win32_Process -Filter "Name = 'node.exe'" | Where-Object { $_.CommandLine -like "*server.js*" } | Stop-Process -Force

schtasks.exe /delete /tn $tsk1 /f
schtasks.exe /delete /tn $tsk2 /f

$path = Join-Path $PWD.Path "AppData\Local\Server"

rm -r -force "$path"

Clear-History
Remove-Item (Get-PSReadlineOption).HistorySavePath