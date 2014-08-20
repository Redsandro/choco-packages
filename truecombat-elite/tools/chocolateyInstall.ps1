$name	= 'TrueCombat:Elite'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$url	= "http://stealthzone.net/index.php?option=com_docman&task=doc_download&gid=1&Itemid=17";
$path	= "http://stealthzone.net/index.php?option=com_docman&task=doc_download&gid=2&Itemid=17"


# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
}

#
# DO NOT USE
# THIS PACKAGE IS INCOMPLETE
#
# DOES NOT WORK
# NEEDS WORK
#

try { 
	
	# Calculate $binRoot, which should always be set in $env:ChocolateyBinRoot as a full path (not relative)
	$binRoot = Get-BinRoot;

	# Extract from zip, ignore setup.exe
	Install-ChocolateyZipPackage $name "$url" "$binRoot"
	
	# Copy shortcut to start menu
	Install-ChocolateyPinnedItem "$binRoot\tce.exe"

	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name "$($_.Exception.Message)"
	throw 
}
