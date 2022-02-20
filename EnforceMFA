# Create the StrongAuthenticationRequirement Object
$sa = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$sa.RelyingParty = "*"
$sa.State = "Enabled"
$sar = @($sa)

# Enable MFA for the user
Set-MsolUser -UserPrincipalName $user -StrongAuthenticationRequirements $sar
