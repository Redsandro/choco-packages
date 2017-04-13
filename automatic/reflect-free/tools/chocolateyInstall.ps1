$toolsDir     = Split-Path $MyInvocation.MyCommand.Definition

$url  = 'http://updates.macrium.com/reflect/v6/ReflectDL.exe'
$toolsPath = Get-ToolsLocation
$fileName  = $url -split '/' | select -Last 1
$dwnAgentPath = "$toolsPath\$fileName"
Get-WebFile $url $dwnAgentPath

rm $Env:TEMP\MacriumInstall\Macrium\* -ea 0
Autohotkey.exe $toolsDir\install.ahk $dwnAgentPath
$installer = gi $Env:TEMP\MacriumInstall\Macrium\*.exe -ea 0
if (!$installer) { Write-Host "Can't automated Macrium install, please run manually $dwnAgentPath" }

$packageArgs = @{
  packageName    = 'reflect-free'
  fileType       = exe
  file           = $installer
  silentArgs     = '/passive'
  validExitCodes = @(0)
  sowftwareName  = 'Macrium Reflect*'
}
Install-ChocolateyInstallPackage @packageArgs
rm $Env:TEMP\MacriumInstall\Macrium\* -ea 0