import-module au
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$releases = 'https://sourceforge.net/projects/ext2read/files/Ext2read%20Version%202.2%20%28Latest%29/'

function global:au_BeforeUpdate {
  $toolsDir = "$PSScriptRoot\tools"
  Get-WebFile "$($Latest.URL32)" "$toolsDir\$($Latest.FileName32)" "$userAgent"
  $Latest.Checksum32 = Get-FileHash "$toolsDir\$($Latest.FileName32)" -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash
}

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^[$]fileName\s*=\s*)('.*')"       = "`$1'$($Latest.FileName32)'"
      "(?i)(^\s*packageName\s*=\s*)'.*'"      = "`$1'$($Latest.PackageName)'"
#     "(?i)^(\s*softwareName\s*=\s*)'.*'"     = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url = $download_page.Links | ? href -match 'ext2explore-([0-9\.]+)\.zip' | % href | select -First 1
  $version = $url -replace '.+ext2explore-([0-9\.]+)\.zip.+', '$1'
  $filename = $url -replace '.+(ext2explore-[0-9\.]+\.zip).+', '$1'
  $md5 = $download_page.Content -split "\n" | ? {$_ -match $url} | % {$_ -replace '(?s).+md5": "([a-z0-9]+)".+', '$1'} | select -Last 1

  @{
    SoftwareName    = 'Ex2 Explorer'
    Version         = "$version.20100623"
    URL32           = "$url"
#   Checksum32      = "$md5" # Invalid
    ChecksumType32  = 'md5'
    FileName32      = "$filename"
  }
}

update -ChecksumFor none
