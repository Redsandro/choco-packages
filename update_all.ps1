# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string] $Name, [string] $ForcedPackages, [string] $Root = "$PSScriptRoot\automatic")

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
    Timeout       = 100                                     #Connection timeout in seconds
    UpdateTimeout = 1200                                    #Update timeout in seconds
    Threads       = 10                                      #Number of background jobs to use
    #Push          = $Env:au_Push -eq 'true'                #Push to chocolatey
    Push          = $true                                   #Push to chocolatey
    PluginPath    = ''                                      #Path to user plugins

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Update-AUPackages.md"         #Path where to save the report
        Params= @{                                          #Report parameters:
            Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $false                            #  Markdown: do not show AppVeyor build shield
            UserMessage = "[History](#update-history) | [Force Test](https://gist.github.com/$Env:gist_id_test) | **USING AU NEXT VERSION**"       #  Markdown, Text: Custom user message to show
            NoIcons     = $false                            #  Markdown: don't show icon
            IconSize    = 32                                #  Markdown: icon size
            Title       = ''                                #  Markdown, Text: TItle of the report, by default 'Update-AUPackages'
        }
    }

#    History = @{
#        Lines = 30                                          #Number of lines to show
#        Github_UserRepo = $Env:github_user_repo             #User repo to be link to commits
#        Path = "$PSScriptRoot\Update-History.md"            #Path where to save history
#    }

#    Gist = @{
#        Id     = $Env:gist_id                               #Your gist id; leave empty for new private or anonymous gist
#        ApiKey = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
#        Path   = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md"       #List of files to add to the gist
#    }

    Git = @{
        User     = ''                                       #Git username, leave empty if github api key is used
        Password = $Env:github_api_key                      #Password if username is not empty, otherwise api key
    }
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:au_Root = $Root                                    #Path to the AU packages
$global:info = updateall -Name $Name -Options $Options
