# A powershell Script to create a mailflow rule to copy in the NSCS to all phishing reports
#
# Author: Tom Coleman github.com/albanytech
#
# This is wrong https://www.ncsc.gov.uk/guidance/configuring-o365-outlook-report-phishing-for-sers#include
#
# So dont follow this https://learn.microsoft.com/en-us/exchange/security-and-compliance/mail-flow-rules/manage-mail-flow-rules
#
# https://learn.microsoft.com/en-us/powershell/module/exchange/new-transportrule?view=exchange-ps
#
# Set up a reported submissions mailbox

#Install Modules
Install-Module -Name ExchangeOnlineManagement
Install-Module -Name AzureAD

# Get the primary domain
$PrimaryDomain = Get-AcceptedDomain | Where {$_.DomainType -eq "Authoritative"} | Select -ExpandProperty Name

# Get all global admin users
$GlobalAdmins = Get-AzureADDirectoryRole | Where {$_.DisplayName -eq "Global Administrator"} | Get-AzureADDirectoryRoleMember | Get-AzureADUser

# Create the shared mailbox for reporting spam
New-Mailbox -Shared -Name "SpamReports" -DisplayName "Spam Reports" -PrimarySmtpAddress ("spamreports@" + $PrimaryDomain)

# Assign permissions to each global admin for the shared mailbox and test that it has worked
foreach ($Admin in $GlobalAdmins) {
    Add-MailboxPermission -Identity "SpamReports" -User $Admin.ObjectId -AccessRights FullAccess -Confirm:$false
    Add-RecipientPermission -Identity "SpamReports" -Trustee $Admin.ObjectId -AccessRights SendAs -Confirm:$false
}

# Assign permissions to each global admin for the shared mailbox
foreach ($Admin in $GlobalAdmins) {
    try {
        Add-MailboxPermission -Identity "SpamReports" -User $Admin.ObjectId -AccessRights FullAccess -Confirm:$false -ErrorAction Stop
        Add-RecipientPermission -Identity "SpamReports" -Trustee $Admin.ObjectId -AccessRights SendAs -Confirm:$false -ErrorAction Stop
    }
    catch {
        Write-Host "Error: Unable to set permissions for $($Admin.DisplayName)" -ForegroundColor Red
        continue
    }
}

# Verify the permissions have been set up
$Permissions = Get-MailboxPermission -Identity "SpamReports" | Where {$_.IsInherited -eq $false}
if ($Permissions.Count -ne $GlobalAdmins.Count) {
    throw "Error: Not all permissions have been successfully assigned."
} else {
    Write-Host "All permissions have been successfully assigned." -ForegroundColor Green
}

# Configure the SpamReports mailbox to receive user submissions

# Set the mailbox to be used for security operations

Set-Mailbox -Identity "SpamReports" -Type "Shared" -AcceptMessagesOnlyFromSendersOrMembers ("AllUsers@" + $PrimaryDomain) -RequireSenderAuthenticationEnabled $false -Type "SecurityOps"

# Verify the configuration
Get-Mailbox -Identity "SpamReports" | Format-List Name,DisplayName,AcceptMessagesOnlyFromSendersOrMembers,RequireSenderAuthenticationEnabled



# Create a New Transport Rule that blind copies reports to NCSC

New-TransportRule -Name "Report Phishing to SERS" -SentTo ("spamreports"+ $PrimaryDomain)  -BlindCopyTo "report@phishing.gov.uk"

