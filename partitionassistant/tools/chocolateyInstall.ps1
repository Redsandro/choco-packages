$name = 'AOMEI Partition Assistant Standard'
$url  = 'http://www.disk-partition.com/download-home.html'
$regex = '(?ms).*href="(http://download.cnet.com/.+?)".*'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"

# Combatibility - This function has not been merged
if (!(Get-Command Get-UrlFromCnet -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Get-UrlFromCnet.ps1"
}

try {

	# Let's get the link from CNET first.
	$url = Get-UrlFromCnet $url $regex

	# Installer
	Install-ChocolateyPackage $name 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' $url

	Write-ChocolateySuccess $name

} catch {

	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
	
}
