$name = 'ext2explore'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://downloads.sourceforge.net/project/ext2read/Ext2read%20Version%202.2%20%28Latest%29/ext2explore-2.2.71.zip'

try { 
	#Install-ChocolateyZipPackage '$name' "$zipUrl" "$pwd"
	
	# Redsandro - I will just include the required modules with the package as long as they are not merged with Chocolatey yet
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
	
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
	Install-ChocolateyPinnedItem "$binRoot\ext2explore.exe"

	Write-ChocolateySuccess '$name'
} catch {
	Write-ChocolateyFailure '$name' "$($_.Exception.Message)"
	throw 
}

#mklink \bin\target.exe \original\file.exe
