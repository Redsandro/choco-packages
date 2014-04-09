$name = 'Copy.com Agent'
$url = 'http://copy.com/install/windows/Copy.exe'
try {
	Install-ChocolateyPackage $name 'EXE' '/exenoui /quiet /qn /norestart' $url
	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}