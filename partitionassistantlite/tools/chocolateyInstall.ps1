$name = 'AOMEI Partition Assistant Lite Server'
$url  = 'http://software-files-a.cnet.com/s/software/13/11/33/11/PAssist_Lite.exe?lop=link&ptype=3001&ontid=18512&siteId=4&edId=3&spi=559baa463be0feb3ddb69ea467186fdc&pid=13113311&psid=75629288&token=1382958668_535692e525632c4f8dee4c2581a29253&fileName=PAssist_Lite.exe'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}
