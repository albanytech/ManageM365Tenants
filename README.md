# ManageM365Tenants
A repository for managing Office 365 Tenanats

# Set Up DAP 
# Source https://docs.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-tenants-with-windows-powershell-for-delegated-access-permissio?view=o365-worldwide

# Connect to Microsoft 365 with PowerShell
# Source https://docs.microsoft.com/en-us/microsoft-365/enterprise/connect-to-microsoft-365-powershell?view=o365-worldwide

# Install the AzureAD Module
Install-Module -Name AzureAD

# Install the MSOnline Module
Install-Module MSOnline

# Test

Get-MsolUser



# Setup Ubuntu
# Source https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2

# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
sudo apt-get install -y powershell
# Start PowerShell
pwsh