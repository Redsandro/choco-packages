try { 
  $installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  
  ### Let's take BinRoot instead.
#  $binRoot = "$env:systemdrive\"
  ### Using an environment variable to to define the bin root until we implement configuration ###
#  if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
  
  ### We do not add additional dirs to the path sysenv for a simple binary
#  $installDir = "$binRoot"
  #$installDir = Join-Path $binRoot 'coretemp'
  #Write-Host "Adding `'$installDir`' to the path and the current shell path"
  #Install-ChocolateyPath "$installDir"
  #$env:Path = "$($env:Path);$installDir"
  
  $zipUrl = 'http://www.alcpu.com/CoreTemp/CoreTemp32.zip'
  $zipUrl64 = 'http://www.alcpu.com/CoreTemp/CoreTemp64.zip'

  Install-ChocolateyZipPackage 'coretemp' "$zipUrl" "$installDir" "$zipUrl64"

  Write-ChocolateySuccess 'coretemp'
} catch {
  Write-ChocolateyFailure 'coretemp' "$($_.Exception.Message)"
  throw 
}

#mklink \bin\target.exe \original\file.exe