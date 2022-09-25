#Script upgrades all available winget packages

try{
    $Winget = Get-ChildItem -Path (Join-Path -Path (Join-Path -Path $env:ProgramFiles -ChildPath "WindowsApps") -ChildPath "Microsoft.DesktopAppInstaller*_x64*\winget.exe")

    # upgrade command for ALL
    &$winget upgrade --all
    exit 0

}catch{
    Write-Error "Error while installing upgrade for: $app_2upgrade"
    exit 1
}