#Script detects the Tailscale app and detects status.

$SrvName = Tailscale
$Service = Get-Service -display $SrvName -ErrorAction SilentlyContinue
$Status = $SrvName + " status --json"
$NeedsLogin = NeedsLogin
$Running = Running


if ($SrvName + " is not installed on this computer." -eq ($Service)){
    Write-Host "$SrvName not found"
    exit 0
}
elseif ($Running -eq ($Status.BackendState)) {
    Write-Host "$Service Running"
    exit 0
}

{$NeedsLogin -eq ($Status.BackendState)
	Write-Host "$Service installed but needs logging in"
	exit 1

}
