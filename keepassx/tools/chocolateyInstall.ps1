$name = 'KeePass Classic'
$url  = 'http://downloads.sourceforge.net/project/keepass/KeePass%201.x/1.24/KeePass-1.24-Setup.exe?r=&ts=1353364762&use_mirror=netcologne'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}
