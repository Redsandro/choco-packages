$packageName = 'ultradefrag'
$installerType = 'exe' 
$silentArgs = '/S /FULL=1'
$url = 'https://sourceforge.net/projects/ultradefrag/files/stable-release/6.1.0/ultradefrag-6.1.0.bin.i386.exe/download'
$url64 = 'https://sourceforge.net/projects/ultradefrag/files/stable-release/6.1.0/ultradefrag-6.1.0.bin.amd64.exe/download'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"


