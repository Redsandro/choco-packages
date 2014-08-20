$name = 'Windows Tweaker'
$url = 'http://tweaker.blob.core.windows.net/downloads/Windows_Tweaker_5.2-Setup.exe'
$switch = '/S /v/qn'

try {
	Install-ChocolateyPackage $name 'EXE' $switch $url
	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}
