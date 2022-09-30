#Script checks for Winget Upgrades on Windows 11.

#$Winget = Get-ChildItem -Path (Join-Path -Path (Join-Path -Path $env:ProgramFiles -ChildPath "WindowsApps") -ChildPath "Microsoft.DesktopAppInstaller*_x64*\winget.exe")

##Find Winget Path

$ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

$config

##Navigate to the Winget Path
cd $wingetPath

if ((./winget.exe upgrade) -gt 3) {
	Write-Host "Upgrade(s) available."
	exit 1 # upgrade available, remediation needed
}
else {
	Write-Host "No Upgrade available"
	exit 0 # no upgrade, no action needed
}