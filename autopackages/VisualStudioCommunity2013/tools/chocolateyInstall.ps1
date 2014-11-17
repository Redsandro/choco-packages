$packageName	= '{{PackageName}}'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$silentArgs		= '/silent /passive' # Self-Extracting Microsoft CAB archive
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"



Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
