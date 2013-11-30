$name = 'OpenHardwareMonitor'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://openhardwaremonitor.org/files/openhardwaremonitor-v0.6.0-beta.zip'


try { 
	# Redsandro - I will just include the required modules with the package as long as they are not merged with mainline Chocolatey yet
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
	Import-Module "$($pwd)\Get-BinRoot.ps1"
		
	$binRoot = Get-BinRoot

	# Extract archive to binRoot
	Install-ChocolateyZipPackage $name "$url" "$binRoot"
	
	# Pin 'OpenHardwareMonitor' to Start
	Install-ChocolateyPinnedItem "$binRoot\OpenHardwareMonitor\OpenHardwareMonitor.exe"

	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name "$($_.Exception.Message)"
	throw 
}

