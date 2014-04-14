$name = 'X2Go Client'
$url = 'http://code.x2go.org/releases/X2GoClient_latest_mswin32-setup.exe'
try {
	Install-ChocolateyPackage $name 'EXE' '/S' $url
	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}