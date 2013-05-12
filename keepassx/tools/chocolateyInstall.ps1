$name = 'KeePass Classic'
$url  = 'http://downloads.sourceforge.net/keepass/KeePass-1.25-Setup.exe'
try {
    Install-ChocolateyPackage $name 'EXE' '/VERYSILENT' $url
    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}

$langcode = (Get-Culture).Name # Get language and country code
$langcode = "$langcode" -replace '-[a-z]{2}', '' # Remove country code
#$langcode = "en" # Change language code for test purposes
$langurl1 = "http://downloads.sourceforge.net/keepass/"

$langfiles = @{
"ar" = "Arabic-1.11b.zip"
"ms" = "BahasaMelayu-1.05.zip"
"be" = "Belarusian-1.18.zip"
"bg" = "Bulgarian-1.10.zip"
"my" = "Burmese-1.23.zip"
"ca" = "Catalan-1.18.zip"
"zh" = "KeePass-1.25-Chinese_Simplified.zip"
#"zh" = "KeePass-1.25-Chinese_Traditional.zip"
"hr" = "Croatian-1.14.zip"
"cs" = "KeePass-1.25-Czech.zip"
"da" = "KeePass-1.25-Danish.zip"
"nl" = "KeePass-1.25-Dutch.zip"
"et" = "Estonian-1.14.zip"
"fi" = "Finnish-1.11.zip"
"fr" = "KeePass-1.25-French.zip"
"gl" = "Galician-1.10.zip"
"de" = "KeePass-1.25-German.zip"
"el" = "KeePass-1.25-Greek.zip"
"he" = "Hebrew-1.04.zip"
"hu" = "KeePass-1.25-Hungarian.zip"
"it" = "KeePass-1.25-Italian.zip"
"ja" = "KeePass-1.25-Japanese.zip"
"ko" = "Korean-1.04.zip"
"lt" = "KeePass-1.25-Lithuanian.zip"
"mk" = "Macedonian-1.04.zip"
"no" = "Norwegian_NB-1.19.zip"
"nn" = "KeePass-1.25-Norwegian_NN.zip"
"fa" = "Persian-1.16.zip"
"pl" = "KeePass-1.25-Polish.zip"
"pt" = "Portuguese_BR-1.17.zip"
#"pt" = "KeePass-1.25-Portuguese_PT.zip"
"pa" = "Punjabi_Indian-1.19.zip"
"ro" = "Romanian-1.18.zip"
"ru" = "KeePass-1.25-Russian.zip"
"sr" = "Serbian-1.23.zip"
"sk" = "KeePass-1.25-Slovak.zip"
"sl" = "Slovenian-1.09.zip"
"es" = "KeePass-1.25-Spanish.zip"
"sv" = "KeePass-1.25-Swedish.zip"
"th" = "Thai-1.11b.zip"
"tr" = "KeePass-1.25-Turkish.zip"
"uk" = "KeePass-1.25-Ukrainian.zip"
"vi" = "Vietnamese-1.15.zip"
}

$langurl2 = $langfiles[$langcode]
$langurl = "$langurl1$langurl2"

if ($langcode -ne "en") {

    $keepasspath = "$env:ProgramFiles\KeePass Password Safe"
    $keepasspathx86 = "${env:ProgramFiles(x86)}\KeePass Password Safe"
    if (Test-Path "$keepasspath") {$unzipLocation = "$keepasspath"}
    if (Test-Path "$keepasspathx86") {$unzipLocation = "$keepasspathx86"}

    Install-ChocolateyZipPackage 'keepass language file' $langurl "$unzipLocation"
}