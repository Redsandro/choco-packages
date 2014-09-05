$packageName	= 'Calibre'
$installerType	= 'MSI'
$url			= '{{DownloadUrl}}'
$silentArgs		= '/quiet'
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
