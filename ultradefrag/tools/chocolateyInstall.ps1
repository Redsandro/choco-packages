$packageName = 'ultradefrag'
$installerType = 'exe' 
$url = 'https://sourceforge.net/projects/ultradefrag/files/stable-release/6.1.0/ultradefrag-6.1.0.bin.i386.exe/download'
$url64 = 'https://sourceforge.net/projects/ultradefrag/files/stable-release/6.1.0/ultradefrag-6.1.0.bin.amd64.exe/download'
$silentArgs = $('/S /FULL=1')

$arguments = @{};
# /NoShellExtension /DisableUsageTracking /NoBootInterface
$packageParameters = $env:chocolateyPackageParameters;

# Default the values
$noShellExtension = $false
$disableUsageTracking = $false
$noBootInterface = $false

# Now parse the packageParameters using good old regular expression
if ($packageParameters) {
    $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
    #"
    $option_name = 'option'
    $value_name = 'value'

    if ($packageParameters -match $match_pattern ){
        $results = $packageParameters | Select-String $match_pattern -AllMatches
        $results.matches | % {
          $arguments.Add(
              $_.Groups[$option_name].Value.Trim(),
              $_.Groups[$value_name].Value.Trim())
      }
    }
    else
    {
      throw "Package Parameters were found but were invalid (REGEX Failure)"
    }

    if ($arguments.ContainsKey("NoShellExtension")) {
        #Write-Host "You want Git on the command line"
        $noShellExtension = $true
    }

    if ($arguments.ContainsKey("DisableUsageTracking")) {
        #Write-Host "You want Git and Unix Tools on the command line"
        $disableUsageTracking = $true
    }

    if ($arguments.ContainsKey("NoBootInterface")) {
        #Write-Host "Ensuring core.autocrlf is false on first time install only"
        #Write-Host " This setting will not adjust an already existing .gitconfig setting."
        $noBootInterface = $true
    }
} else {
    Write-Debug "No Package Parameters Passed in";
}

if ($noShellExtension) { $silentArgs += " /SHELLEXTENSION=0" }
if ($disableUsageTracking) { $silentArgs += " /DISABLE_USAGE_TRACKING=1" }
if ($noBootInterface) { $silentArgs += " /BOOT=0" }

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
