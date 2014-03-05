$name = 'RenameMaster'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$url = "http://www.joejoesoft.com/cms/file.php?f=userupload%2f8%2ffiles%2frmv308.zip";


# Combatibility - merged in 0.9.8.23 but contains error up to 0.9.8.24, so skipping for now
#if (!(Get-Command Get-BinRoot -errorAction SilentlyContinue)) {
#	Import-Module "$($pwd)\Get-BinRoot.ps1"
#}
Import-Module "$($pwd)\Get-BinRoot.ps1"

# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
}


try { 
	## $url = Get-FilenameFromRegex "http://www.joejoesoft.com/vcms/hot/userupload/8/files/rmv303.zip" '/cms/file.php\?f=userupload/8/files/rmv303.zip&amp;c=([\w\d]+)' 'http://www.joejoesoft.com/sim/$1/userupload/8/files/rmv303.zip'

	# Resolve url
	$wc = new-object system.Net.WebClient;
	$html = $wc.DownloadString($url);
	$html -cmatch '/cms/file.php(.+?)"';
	$url = $matches[0];
	$url = "http://www.joejoesoft.com" + $url;
	
	# Calculate $binRoot, which should always be set in $env:ChocolateyBinRoot as a full path (not relative)
	$binRoot = Get-BinRoot;

	# Extract from zip, ignore setup.exe
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
