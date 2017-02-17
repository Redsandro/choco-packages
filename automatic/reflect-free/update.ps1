import-module au

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^[$]fileName\s*=\s*)('.*')"       = "`$1'$($Latest.FileName32)'"
      "(?i)(^\s*packageName\s*=\s*)'.*'"      = "`$1'$($Latest.PackageName)'"
      "(?i)^(\s*[$]?softwareName\s*=\s*)'.*'"     = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_GetLatest {
  $releases       = 'http://www.macrium.com/reflectfree.aspx'
  $download_page  = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version        = $download_page.Content -split '\n' | ? {$_ -match 'Current Version:'} | % {$_ -replace '.+Current Version:.+;([0-9\.]+).+', '$1'}

  @{
    SoftwareName    = 'Macrium Reflect Installer'
    Version         = "$version"
    URL32           = 'http://updates.macrium.com/reflect/v6/ReflectDL.exe'
    FileName32      = 'ReflectDL.exe'
  }
}

update -ChecksumFor none
