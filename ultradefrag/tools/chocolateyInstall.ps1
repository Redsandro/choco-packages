$packageName = 'ultradefrag'
$installerType = 'exe' 
#$url = 'http://switch.dl.sourceforge.net/project/ultradefrag/stable-release/5.1.2/ultradefrag-6.0.2.bin.i386.exe'
#$url = 'http://garr.dl.sourceforge.net/project/ultradefrag/stable-release/6.0.2/ultradefrag-6.0.2.bin.i386.exe'
$url = 'http://garr.dl.sourceforge.net/project/ultradefrag/latest-release-candidates/7.0.0%20beta1/ultradefrag-7.0.0-beta1.bin.i386.exe'
#$url64 = 'http://freefr.dl.sourceforge.net/project/ultradefrag/stable-release/5.1.2/ultradefrag-5.1.2.bin.amd64.exe'
#$url64 = 'http://heanet.dl.sourceforge.net/project/ultradefrag/stable-release/6.0.2/ultradefrag-6.0.2.bin.amd64.exe'
$url64 = 'http://heanet.dl.sourceforge.net/project/ultradefrag/latest-release-candidates/7.0.0%20beta1/ultradefrag-7.0.0-beta1.bin.amd64.exe'
$silentArgs = '/S /FULL=1'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"


