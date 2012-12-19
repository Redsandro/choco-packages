$packageName = 'freeotfe'
$installerType = 'exe' 
$url = 'http://www.freeotfe.org/downloads/FreeOTFE_5_21.exe'
$url64 = $url # 64bit URL here or just use the same as $url
$silentArgs = '/S'

# main helpers - these have error handling tucked into them already
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
