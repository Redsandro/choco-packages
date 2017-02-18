$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'touchdesigner'
  fileType               = 'exe'
  url                    = 'https://www.derivative.ca/Builds/TouchDesigner088.62160.32-Bit.exe'
  url64bit               = 'https://www.derivative.ca/Builds/TouchDesigner088.62160.64-Bit.exe'
  checksum               = 'e216f4536503393cb38f5ba6e02420a098f6696f109d3b16ecde02feaf00d37b'
  checksum64             = '5927eb66795735d7f675d992207e45063b1883c5c5a862a9a69bd12fa189ca63'
  checksumType           = ''
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'TouchDesigner 088'
}

Write-Host
Write-Host "For commercial use of TouchDesigner, you need a commercial or pro license." -ForegroundColor "White"
Write-Host "See: https://www.derivative.ca/shop/" -ForegroundColor "White"
Write-Host

Install-ChocolateyPackage @packageArgs
