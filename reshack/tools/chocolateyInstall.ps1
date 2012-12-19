$packageName = 'reshack'
$installerType = 'exe' 
$url = 'http://www.angusj.com/resourcehacker/reshack_setup.exe'
$url64 = $url
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

try {
	Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

	# I need to add an 'open with resource hacker' context menu item for .exe only
} catch {
	Write-ChocolateyFailure 'reshack' "$($_.Exception.Message)"
	throw 
}
