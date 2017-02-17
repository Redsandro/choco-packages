import-module au
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$releases = 'http://download.drp.su/'
$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246'

#function global:au_BeforeUpdate {
#  $toolsDir = "$PSScriptRoot\tools"
#  Get-WebFile "$($Latest.URL32)" "$toolsDir\$($Latest.FileName32)" "$userAgent"
#  $Latest.Checksum32 = Get-FileHash "$toolsDir\$($Latest.FileName32)" -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash
#}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
#     "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
#     "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^[$]fileName32\s*=\s*)('.*')"     = "`$1'$($Latest.FileName32)'"
      "(?i)(^\s*packageName\s*=\s*)'.*'"      = "`$1'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'"     = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $file = $download_page.Links | ? href -match 'DriverPack-[0-9\.]+-Online.exe' | % href | select -Last 1
  $major = $file -replace '^.+?([0-9\.]+)-Online.exe$', '$1'
  $date = $download_page.Content -split "\n" | ? {$_ -match $file} | % {$_ -replace '^.+</a>\s+([^\s]+).+', '$1'}
  $version = "$major.$(([DateTime]$date).Year).$(([DateTime]$date).Month).$(([DateTime]$date).Day)"
  $url = "http://download.drp.su/$file"

  @{
    SoftwareName    = 'Driver Pack Solution'
    Version	        = $version
    URL32  	        = $url
    FileName32      = $file
    ChecksumType32  = 'sha256'
  }
}

update -ChecksumFor none
