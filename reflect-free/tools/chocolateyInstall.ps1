$name = 'Macrium-Reflect'
$id = 'reflect-free'
$url = 'http://www.macrium.com/reflectfree.aspx'
$regex = '(?ms).*href="(http://download.cnet.com/.+?)".*'
$switch = '/quiet /norestart'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"



# This should have been merged centuries ago.
if (!(Get-Command Get-UrlFromCnet -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Get-UrlFromCnet.ps1"
}



try {

	# Let's get the link from CNET first.
	$newUrl = Get-UrlFromCnet $url $regex

	# I truely do not understand why the $%@! this turned into an array, and where the true comes from
	# [0] = ' ' (space)
	# [1] = True
	# [2] = url
	$url = $newUrl[2]

	Write-Host "Found $url"

	# Installer
	Install-ChocolateyPackage $id 'EXE' $switch "$url"

	Write-ChocolateySuccess $name

} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}
