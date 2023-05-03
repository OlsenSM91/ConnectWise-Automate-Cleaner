# Get the current script path
$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders"

# Define the search string
$searchString = "C:\Windows\LTScv"

# Define the uninstaller and installer URLs
$uninstallerUrl = "https://github.com/OlsenSM91/ConnectWise-Automate-Cleaner/releases/download/Rev1/Agent_Uninstall.exe"
$installerUrl = "https://cns4u.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=779eb46901ab41039e9848e61f3b0a0f"

# Define the local file names
$uninstaller = Join-Path -Path $scriptPath -ChildPath "Agent_Uninstall.exe"
$installer = Join-Path -Path $scriptPath -ChildPath "Agent_Install.msi"

# Download the uninstaller and installer
Invoke-WebRequest -Uri $uninstallerUrl -OutFile $uninstaller
Invoke-WebRequest -Uri $installerUrl -OutFile $installer

# Check if the user has administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    return
}

# Check if the registry key exists and contains the search string
$registryKeys = Get-ItemProperty -Path $registryPath

$found = $false
foreach ($key in $registryKeys.PSObject.Properties) {
    if ($key.Value -eq $searchString) {
        $found = $true
        break
    }
}

if ($found) {
    # If found, run the uninstaller
    Start-Process -FilePath $uninstaller -Verb RunAs -Wait
}

# Then, run the installer (MSI)
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installer`" /qn" -Verb RunAs -Wait
