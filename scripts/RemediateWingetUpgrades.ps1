#Script upgrades all available winget packages

##Find Winget Path

$ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

$config

##Navigate to the Winget Path
Set-Location $wingetpath

try{
    ./winget.exe upgrade --all
    
    }
    catch{
        Write-Error "Error Upgrading apps"
    }