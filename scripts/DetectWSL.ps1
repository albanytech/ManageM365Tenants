IF ( Get-WmiObject -Class Win32_OptionalFeature | Where-Object {($_.Name -Match "Microsoft-Windows-Subsystem-Linux") -and ($_.InstallState -eq 1)} ){
  $True
}
ELSE {
  $False
}