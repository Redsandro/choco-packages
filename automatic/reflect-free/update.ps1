import-module au

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
    }
  }
}

function global:au_GetLatest {
  $releases       = 'http://www.macrium.com/reflectfree.aspx'
  $download_page  = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version        = $download_page.Content -split '\n' | ? {$_ -match 'Current Version:'} | % {$_ -replace '.+Current Version:.+;([0-9\.]+).+', '$1'}

  @{
    Version  = "$version"
    URL32    = 'http://updates.macrium.com/reflect/v6/ReflectDL.exe'
  }
}

update -ChecksumFor none
