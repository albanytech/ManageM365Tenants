#Script checks for Winget Upgrades on Windows 11.

##Find Winget Path

$ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

$config

##Navigate to the Winget Path
Set-Location $wingetpath

if ((.\winget.exe upgrade) -eq ("No installed package found matching input criteria."))
{
	Write-Host "Nothing needs upgrading"
	exit 0
} Else {
	Write-Host "Upgrades available"
	Exit 1

}