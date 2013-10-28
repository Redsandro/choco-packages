$name = 'AOMEI Partition Assistant Standard'
$url  = 'http://software-files-a.cnet.com/s/software/13/11/23/15/PAssist_Std.exe?lop=link&ptype=3001&ontid=18512&siteId=4&edId=3&spi=5c9c5f6d8a265a09f84ed8ae617d7470&pid=13112315&psid=75118871&token=1382955914_ad11367304bad74e146b85e722537698&fileName=PAssist_Std.exe'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}
