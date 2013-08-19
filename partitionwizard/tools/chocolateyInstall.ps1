$name = 'Partition Wizard Home Edition'
$url  = 'http://www.partitionwizard.com/download/pwhe8.exe'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}
