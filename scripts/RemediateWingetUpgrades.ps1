#Script upgrades all available winget packages

try{
    winget upgrade --all
    
    }
    catch{
        Write-Error "Error Upgrading apps"
    }