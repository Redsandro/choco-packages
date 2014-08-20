$name = 'Alcohol 52%'
$id = "Alcohol52FE"
$url = 'http://www.filefacts.com/alcohol-52-free-edition-quickdownload'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3 = 'alcohol52-free.au3'
$fName = "Alcohol52FE_downloader.exe"

try {

	# Debug
	# autoit3 alcohol52-free.au3 c:\Users\IEUser\AppData\Local\Temp\Alcohol52FE\Alcohol52FE_downloader.exe

	$tempDir = Join-Path $env:TEMP $id


	if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
	
	$file = Join-Path $tempDir $fName
	$au3 = Join-Path $pwd 'alcohol52-free.au3'
	
	Get-ChocolateyWebFile $id "$file" "$url"

	Write-Host "Running `'$fName`' with AutoIt3 using `'$au3`'"
	$args = "/c AutoIt3.exe `"$au3`" `"$file`""
	Start-ChocolateyProcessAsAdmin "$args" 'cmd.exe'
	
	Write-ChocolateySuccess "$name"
} catch {
	Write-ChocolateyFailure "$name" $($_.Exception.Message)
	throw
}
