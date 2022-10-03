# Manage Conditional Access as code.

<#
You first need to register a new application in your Azure AD according to this article:
https://danielchronlund.com/2018/11/19/fetch-data-from-microsoft-graph-with-powershell-paging-support/

The following Microsoft Graph API permissions are required for this to work:
    Policy.ReadWrite.ConditionalAccess
    Policy.Read.All
    Directory.Read.All
    Agreement.Read.All
    Application.Read.All

Also, the user running this (the one who signs in when the authentication pops up) must have the appropriate permissions in Azure AD (Global Admin, Security Admin, Conditional Access Admin, etc).
#>


# Export your Conditional Access policies to a JSON file for backup.
$Parameters = @{
    ClientID = ''
    ClientSecret = ''
    FilePath = 'C:\Temp\Conditional Access Backup.json'
}

Export-DCConditionalAccessPolicyDesign @Parameters


# Import Conditional Access policies from a JSON file exported by Export-DCConditionalAccessPolicyDesign.
$Parameters = @{
    ClientID = ''
    ClientSecret = ''
    FilePath = 'C:\Temp\Conditional Access Backup.json'
    SkipReportOnlyMode = $false
    DeleteAllExistingPolicies = $false
}

Import-DCConditionalAccessPolicyDesign @Parameters


# Export Conditional Access policy design report to Excel.
$Parameters = @{
    ClientID = ''
    ClientSecret = ''
}

New-DCConditionalAccessPolicyDesignReport @Parameters


# Export Conditional Access Assignment Report to Excel.
$Parameters = @{
    ClientID = ''
    ClientSecret = ''
    IncludeGroupMembers = $false
}

New-DCConditionalAccessAssignmentReport @Parameters


# Learn more about the different Conditional Access commands in DCToolbox.
help Export-DCConditionalAccessPolicyDesign -Full
help Import-DCConditionalAccessPolicyDesign -Full
help New-DCConditionalAccessPolicyDesignReport -Full
help New-DCConditionalAccessAssignmentReport -Full
