$toolsPath    = "$env:systemdrive\tools"
$fileName     = 'ext2explore-2.2.71.zip'
$filePath     = "$toolsPath\$fileName"
$packageArgs  = @{
  packageName             = 'ext2explore'
  url                     = 'https://sourceforge.net/projects/ext2read/files/Ext2read%20Version%202.2%20%28Latest%29/ext2explore-2.2.71.zip/download'
  checksum                = '727204919F92766B733F519DBF28C01B'
  checksumType            = 'md5'
  unzipLocation           = "$toolsPath"
}

#Install-ChocolateyZipPackage $packageArgs # Doesn't work, get unzipLocation empty
Install-ChocolateyZipPackage $($packageArgs.packageName) $($packageArgs.url) $toolsPath -Checksum $($packageArgs.checksum) -ChecksumType $($packageArgs.checksumType)

# Shortcut
$desktop = [System.Environment]::GetFolderPath('Desktop')
$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))
$target = "$toolsPath\ext2explore.exe"
Install-ChocolateyShortcut -ShortcutFilePath "$desktop\$($packageArgs.packageName).lnk" -TargetPath "$target"
Install-ChocolateyShortcut -ShortcutFilePath "$startMenu\Programs\$($packageArgs.packageName).lnk" -TargetPath "$target"
