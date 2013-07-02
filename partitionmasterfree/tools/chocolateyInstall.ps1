$packageName = 'PartitionMasterFree'
$installerType = 'exe' 
$url = 'http://download.easeus.com/free/epm.exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
