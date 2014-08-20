$name = 'Patch my PC'
$id = 'patch-my-pc'
$url = 'http://patchmypc.net/PatchMyPC.exe'

try {
    Write-Debug "Downloading $name from '$url'";

    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "$id"

    if (![System.IO.Directory]::Exists($tempDir)) { [System.IO.Directory]::CreateDirectory($tempDir) | Out-Null }
    $file = Join-Path $tempDir "$($id)Install.$fileType"

    Get-ChocolateyWebFile $id $file $url

    Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}
