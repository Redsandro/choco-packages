$name = 'RenameMaster'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"

## write-host ''
## write-host "!!!ATTENTION!!!"
## write-host ''
## write-host "This is weird."
## write-host "This package fails the first time, but works the second time."
## write-host "Any thoughts? Let me know."
## write-host ''

try { 
	# Redsandro - I will just include the required modules with the package as long as they are not merged with Chocolatey yet
	## Import-Module "$($pwd)\Get-FilenameFromRegex.ps1"
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
	# Why does an import failure on this module not throw an error?
	
	## $url = Get-FilenameFromRegex "http://www.joejoesoft.com/vcms/hot/userupload/8/files/rmv303.zip" '/cms/file.php\?f=userupload/8/files/rmv303.zip&amp;c=([\w\d]+)' 'http://www.joejoesoft.com/sim/$1/userupload/8/files/rmv303.zip'
	$url = 'http://www.joejoesoft.com/snap.php?f=userupload/8/files/rmv304.zip'

	# Calculate $binRoot, which imo should always be set in $env:chocolatey_bin_root as a full path (not relative)
	if($env:chocolatey_bin_root -eq $null) {
		$binRoot = "$env:ChocolateyInstall\bin"
	}
	# My chocolatey_bin_root is C:\Common\bin, but looking at other packages, not everyone assumes chocolatey_bin_root is prepended with a drive letter.
	elseIf (-not($env:chocolatey_bin_root -imatch "^\w:")) {
		# Add drive letter
		$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root
	}
	else {
		$binRoot = $env:chocolatey_bin_root
	}

	Install-ChocolateyZipPackage $name "$url" "$binRoot"
	
	# Copy 'Rename Master' shortcut to start menu
	Install-ChocolateyPinnedItem "$binRoot\RenameMaster.exe"

	# Add 'Rename Master... to context menu for directories'
	Install-ChocolateyExplorerMenuItem 'openRenameMaster' 'Rename Master...' "$binRoot\RenameMaster.exe" directory

	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name "$($_.Exception.Message)"
	throw 
}

