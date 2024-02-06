$ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }
$Winget = $WingetPath + "\winget.exe"
$upgrades = &$winget upgrade
if ($upgrades -match "tailscale.tailscale") {
    Write-Host "Upgrade available for: Tailscale"
    exit 1
}
else {
        Write-Host "No Upgrade available"
        exit 0
}