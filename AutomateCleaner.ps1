# Get the current script path
$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders"

# Define the search string
$searchString = "C:\Windows\LTScv"

# Define the uninstaller and installer file names
$uninstaller = Join-Path -Path $scriptPath -ChildPath "Agent_Uninstall.exe"
$installer = Join-Path -Path $scriptPath -ChildPath "Agent_Install.exe"

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

# Then, run the installer
Start-Process -FilePath $installer -Verb RunAs -Wait
