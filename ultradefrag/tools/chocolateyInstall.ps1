$packageName = 'ultradefrag'
$installerType = 'exe' 
$url = 'http://switch.dl.sourceforge.net/project/ultradefrag/stable-release/5.1.2/ultradefrag-5.1.2.bin.i386.exe'
$url64 = 'http://freefr.dl.sourceforge.net/project/ultradefrag/stable-release/5.1.2/ultradefrag-5.1.2.bin.amd64.exe'
$silentArgs = '/S /FULL=1'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

# Now rename the ugly context-menuitem ------UltraDefrag--------- to Ultra Defragmenter

#Install-ChocolateyExplorerMenuItem udefrag '&Ultra Defragmenter' '\"C:\Program Files (x86)\Notepad++\notepad++.exe\" -with -some -arguments \"%1\"'
#"C:\Windows\system32\udefrag.exe" --shellex "%1"
