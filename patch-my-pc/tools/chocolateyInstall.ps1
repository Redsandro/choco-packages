$name = 'Patch my PC'
$id = 'patch-my-pc'
$url = 'http://patchmypc.net/PatchMyPC.exe'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"

# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
}

try {

	$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "$id"

	# Calculate $binRoot, which should always be set in $env:ChocolateyBinRoot as a full path (not relative)
	$binRoot = Get-BinRoot;

    #if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
    #$file = Join-Path $tempDir "$($id)Install.$fileType"
    $file = "$binRoot\PatchMyPC.exe"
    $tempFile = "$pwd\PatchMyPC.exe"

    Write-Host "Did someone change the binRoot?";
    Write-Host "Old: $binRoot";
    Write-Host "New: $nugetExePath";

    Get-ChocolateyWebFile $id "$tempFile" "$url"

	# Copy shortcut to start menu
#	Install-ChocolateyPinnedItem "$file"
#	Install-ChocolateyPinnedItem "$tempFile"

	$meh = Join-Path $nugetExePath "PatchMyPC.exe"
	
	Install-ChocolateyPinnedItem $meh

    Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}
