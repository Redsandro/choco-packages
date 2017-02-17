import-module au

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*[$]?url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)^(\s*[$]?checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)^(\s*[$]?packageName\s*=\s*)'.*'"      = "`$1'$($Latest.PackageName)'"
      "(?i)^(\s*[$]?softwareName\s*=\s*)'.*'"     = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_GetLatest {
  $releases       = 'https://wiki.gnome.org/Apps/Tomboy/Download'
  $download_page  = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url            = $download_page.Links | ? href -match 'Tomboy-[0-9\.]+\.msi' | % href | select -First 1
  $version        = $url -replace '.+Tomboy-([0-9\.]+)\.msi', '$1'

  @{
    SoftwareName    = 'Tomboy Notes'
    Version         = $version
    URL32           = $url
  }
}

update -ChecksumFor 32
