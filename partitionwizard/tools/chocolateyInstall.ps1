$name = 'Partition Wizard Home Edition'
$url  = 'http://files7.majorgeeks.com/files/07c3f887cc69caf06f342a367cfe6304/drives/pwhe78.exe'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}
