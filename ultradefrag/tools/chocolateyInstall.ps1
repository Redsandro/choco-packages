$packageName = 'ultradefrag'
$installerType = 'exe' 
$url = 'http://switch.dl.sourceforge.net/project/ultradefrag/stable-release/5.1.2/ultradefrag-5.1.2.bin.i386.exe'
$url64 = 'http://freefr.dl.sourceforge.net/project/ultradefrag/stable-release/5.1.2/ultradefrag-5.1.2.bin.amd64.exe'
$silentArgs = '/S /FULL=1'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
