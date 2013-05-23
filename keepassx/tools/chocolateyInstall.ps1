$name = 'KeePass Classic'
$url = 'http://downloads.sourceforge.net/keepass/KeePass-1.25-Setup.exe'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}