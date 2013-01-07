$packageName = 'reshack'
$installerType = 'exe' 
$url = 'http://www.angusj.com/resourcehacker/reshack_setup.exe'
$url64 = $url
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

try {
	Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

	# I need to add an 'open with resource hacker' context menu item for .exe only
	# "C:\Program Files (x86)\Resource Hacker\ResHacker.exe"
	# if 32 bit
	# %ProgramFiles%\Resource Hacker\ResHacker.exe
	# if 64 bit
	# %ProgramFiles(x86)%\Resource Hacker\ResHacker.exe
	
	
} catch {
	Write-ChocolateyFailure 'reshack' "$($_.Exception.Message)"
	throw 
}
