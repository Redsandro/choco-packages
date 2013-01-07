try { 
	$packageName = 'RenameMaster'
	$zipUrl = Get-FilenameFromRegex "http://www.joejoesoft.com/vcms/hot/userupload/8/files/rmv303.zip" '/cms/file.php\?f=userupload/8/files/rmv303.zip&amp;c=([\w\d]+)' 'http://www.joejoesoft.com/sim/$1/userupload/8/files/rmv303.zip'


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

	Install-ChocolateyZipPackage $packageName "$zipUrl" "$binRoot"
	
	# Copy "$binRoot\renamemaster.exe" shortcut to start menu
	
	Install-ChocolateyExplorerMenuItem 'openRenameMaster' 'Rename Master...' "$binRoot\RenameMaster.exe" directory

	Write-ChocolateySuccess $packageName
} catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw 
}

#mklink \bin\target.exe \original\file.exe