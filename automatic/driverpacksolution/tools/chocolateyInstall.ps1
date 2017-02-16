$name = 'DriverPack Solution Lite'
$url = 'http://download.drp.su/DRPSu13-Lite.exe'
$switch = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

try {
	Install-ChocolateyPackage $name 'EXE' $switch $url
	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}
