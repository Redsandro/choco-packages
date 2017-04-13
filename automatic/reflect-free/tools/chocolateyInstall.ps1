$toolsDir  = Split-Path $MyInvocation.MyCommand.Definition

$url  = 'http://updates.macrium.com/reflect/v6/ReflectDL.exe'
$agentfileName  = $url -split '/' | select -Last 1
$downloadDir = "$(Get-ToolsLocation)\reflect-free"
rm $downloadDir -Recurse -ea 0

Get-WebFile $url "$downloadDir\$agentfileName"

Write-Host "Running Macrium download agent via Autohotkey"
Autohotkey.exe $toolsDir\download.ahk "$downloadDir\$agentfileName" $downloadDir
$installer = gi $downloadDir\Macrium\*.exe -ea 0
if (!$installer) { Write-Host "Can't automate Macrium download agent, please run manually $downloadDir" }

Write-Host "Running Macrium installer via Autohotkey: $installer"
Autohotkey.exe $toolsDir\install.ahk $installer

Write-Host "Installation completed"
Write-Host "Downloaded files are left in: $downloadDir"