$packageName	= 'Tixati'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$url64			= '{{DownloadUrlx64}}'
$silentArgs		= 'SILENT_ARGS_HERE' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'tixati.au3'

# Calculate $binRoot, which should always be set in $env:ChocolateyBinRoot as a full path (not relative)
$binRoot		= Get-BinRoot;
# Override. I thought Get-BinRoot was supposed to do this but guess not: https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/chocolatey/5R7OtVM9RUI/ERcFFKZcFnQJ
$binRoot		= Join-Path $env:ChocolateyInstall "bin"

try {

	$chocTempDir	= Join-Path $env:TEMP "chocolatey"
	$tempDir		= Join-Path $chocTempDir "$packageName"
		if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
	$tempFile		= Join-Path $tempDir "$packageName.installer.exe"


	Get-ChocolateyWebFile "$packageName" "$tempFile" "$url" "$url64"
	
	Write-Host "Running `'upx.exe -d `"$tempFile`"`'"
	upx.exe -d "$tempFile"
	
	Write-Host "Running AutoIt3 using `'$au3`'"
	Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'


	Write-ChocolateySuccess "$packageName"
} catch {
	Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
	throw
}
