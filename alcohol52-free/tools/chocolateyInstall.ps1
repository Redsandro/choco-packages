$name = 'Alcohol 52%'
$url = 'http://www.filefacts.com/alcohol-52-free-edition-quickdownload'
$switch = ''

try {
	Install-ChocolateyPackage "$name" 'EXE' "$switch" "$url"
	Write-ChocolateySuccess "$name"
} catch {
	Write-ChocolateyFailure "$name" $($_.Exception.Message)
	throw
}
