$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tomboy'
  fileType       = 'msi'
  url            = 'http://download.gnome.org/binaries/win32/tomboy/1.15/Tomboy-1.15.7.msi'
  checksum       = 'b59de7f2eae36c4761aeb90c02dfe91399f0a648c28ca378a5554f6dfb0291a1'
  checksumType   = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010)
  softwareName   = 'Tomboy Notes'
}

Install-ChocolateyPackage @packageArgs
