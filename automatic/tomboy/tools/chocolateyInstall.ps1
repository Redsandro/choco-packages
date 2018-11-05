$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tomboy'
  fileType       = 'msi'
  url            = 'https://download.gnome.org/binaries/win32/tomboy/1.15/Tomboy-1.15.9.msi'
  checksum       = 'd31dfff589a61d92e5364bf3227c5da59651c6ad0a01d69ba32077cc58ebb254'
  checksumType   = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010)
  softwareName   = 'Tomboy Notes'
}

Install-ChocolateyPackage @packageArgs
