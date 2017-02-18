import-module au

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*[$]?url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)^(\s*[$]?url64bit\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
      #"(?i)^(\s*[$]?checksum\s*=\s*)('.*')"       = "`$1'e216f4536503393cb38f5ba6e02420a098f6696f109d3b16ecde02feaf00d37b'"
      #"(?i)^(\s*[$]?checksum64\s*=\s*)('.*')"     = "`$1'5927eb66795735d7f675d992207e45063b1883c5c5a862a9a69bd12fa189ca63'"
      "(?i)^(\s*[$]?checksum\s*=\s*)('.*')"       = "`$1'$(Get-RemoteChecksum $Latest.URL32)'"
      "(?i)^(\s*[$]?checksum64\s*=\s*)('.*')"     = "`$1'$(Get-RemoteChecksum $Latest.URL64)'"
      "(?i)^(\s*[$]?packageName\s*=\s*)'.*'"      = "`$1'$($Latest.PackageName)'"
      "(?i)^(\s*[$]?softwareName\s*=\s*)'.*'"     = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_GetLatest {
  $releases = 'https://www.derivative.ca/088/Downloads/'
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32 = $download_page.Links | ? href -match 'TouchDesigner088.[0-9]+\.32-Bit\.exe' | % href | select -First 1
  $url64 = $download_page.Links | ? href -match 'TouchDesigner088.[0-9]+\.64-Bit\.exe' | % href | select -First 1
  $version32 = $url32 -replace '.*TouchDesigner088.([0-9]+)\.32-Bit\.exe.*', '$1'
  $version64 = $url64 -replace '.*TouchDesigner088.([0-9]+)\.64-Bit\.exe.*', '$1'

  @{
    SoftwareName = 'TouchDesigner 088'
    Version      = "88.$version64"
    URL32        = "https://www.derivative.ca$url32"
    URL64        = "https://www.derivative.ca$url64"
  }
}

update -ChecksumFor none
