#Script checks for Winget Upgrades on Windows 11.

if ((winget upgrade) -eq ("No installed package found matching input criteria.")) {
	Write-Host "Nothing needs upgrading"
	exit 0
} Else {
	Write-Host "Upgrades available"
	Exit 1

}