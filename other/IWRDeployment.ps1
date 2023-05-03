# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Get the current script path
$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Define the uninstaller and installer URLs
$uninstallerUrl = "https://github.com/OlsenSM91/ConnectWise-Automate-Cleaner/releases/download/Rev1/Agent_Uninstall.exe"
$installerUrl = "INSERT_CUSTOM_AGENT_MSI_DOWNLOAD_LINK_HERE"

# Define the local file names
$uninstaller = Join-Path -Path $scriptPath -ChildPath "Agent_Uninstall.exe"
$installer = Join-Path -Path $scriptPath -ChildPath "Agent_Install.msi"

try {
    # Download the uninstaller and installer
    Invoke-WebRequest -Uri $uninstallerUrl -OutFile $uninstaller
    Invoke-WebRequest -Uri $installerUrl -OutFile $installer

    # Check if the user has administrator privileges
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        throw "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    }

    # Run the uninstaller
    Start-Process -FilePath $uninstaller -Verb RunAs -Wait

    # Then, run the installer (MSI)
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installer`" /qn" -Verb RunAs -Wait

    Write-Output "Script executed successfully!"
} catch {
    Write-Output "Error: $_"
}
