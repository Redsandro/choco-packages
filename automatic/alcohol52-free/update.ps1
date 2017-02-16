import-module au
import-module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

$softwareName = 'Alcohol 52% Free Edition'
$releases = 'http://www.filefacts.com/alcohol-52-free-edition-download'
$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246'

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $toolsDir = "$PSScriptRoot\tools"
  $Latest.FileName32 = "$($Latest.PackageName).installer.exe"
  Get-WebFile "$($Latest.URL32)" "$toolsDir\$($Latest.FileName32)" "$userAgent"
  $Latest.Checksum32 = Get-FileHash "$toolsDir\$($Latest.FileName32)" -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash
}

function global:au_SearchReplace {
  @{
    "tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
	  "(?i)(^[$]filePath32\s*=\s*`"[$]toolsPath\\)[^`"]*`"" = "`${1}$($Latest.FileName32)`""
	  "(?i)(^\s*packageName\s*=\s*)'.*'"      = "`$1'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'"     = "`$1'$($Latest.SoftwareName)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $version = $download_page.Content -replace '(?s).+?Free Edition ([0-9\.]+) FE.+', '$1'

  @{
    Version      = $version
    URL32        = 'http://www.filefacts.com/alcohol-52-free-edition-quickdownload'
	SoftwareName = $softwareName
  }
}

update -ChecksumFor none
