$name = 'foobar2000.rs'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"



try {
	Import-Module "$($pwd)\Get-FilenameFromRegex.ps1"
	# Why does an import failure on this module not throw an error?
	$url = Get-FilenameFromRegex "http://www.foobar2000.org/download" '/getfile/([\w\d]+)/foobar2000_v1.2.exe' 'http://www.foobar2000.org/files/$1/foobar2000_v1.2.exe'
	Write-Host "Found URL: $url"
	Install-ChocolateyPackage "$name" "exe" "/S" "$url" "$url"
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}