$packageName = 'imagemagick'
$installerType = 'exe' 
$url = 'http://www.imagemagick.org/download/binaries/ImageMagick-6.8.0-10-Q16-windows-dll.exe'
$url64 = 'http://www.imagemagick.org/download/binaries/ImageMagick-6.8.0-10-Q16-windows-x64-dll.exe'
# http://unattended.sourceforge.net/InnoSetup_Switches_ExitCodes.html
$silentArgs = '/SILENT /SUPPRESSMSGBOXES /LOG /NOCANCEL /NORESTART'
# $silentArgs = '/VERYSILENT' # See nothing

#/DIR="x:\dirname"
#/GROUP="folder name"

# main helpers - these have error handling tucked into them already
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

# I need to move a link from the install path to the BIN folder