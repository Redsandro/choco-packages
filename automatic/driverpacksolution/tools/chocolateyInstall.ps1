$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'DriverPack-17-Online.exe'
$filePath32 = "$toolsPath\$fileName32"
$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246'
$packageArgs = @{
	packageName            = 'driverpacksolution'
	fileType               = 'exe'
	url                    = 'http://download.drp.su/DriverPack-17-Online.exe'
	softwareName           = 'Driver Pack Solution'
}

Get-WebFile "$($packageArgs.url)" "$filePath32" "$userAgent"

$desktop = [System.Environment]::GetFolderPath('Desktop')
$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
$fileName = $fileName32 -split '.exe' | select -First 1
Install-ChocolateyShortcut -ShortcutFilePath "$desktop\$fileName.lnk" -TargetPath "$filePath32"
Install-ChocolateyShortcut -ShortcutFilePath "$startMenu\Programs\$fileName.lnk" -TargetPath "$filePath32"
