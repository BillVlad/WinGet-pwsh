<#
2021 BillVLad
#>

# Global var #
$title = 'WinGet Auto-Install'
$question = 'You Have already installed WinGet?'
$choices = '&Yes', '&No'
# End var #

function InstallSoftware {
    foreach($line in [System.IO.File]::ReadLines("soft.txt")) {
           winget install -h $line
    }
}

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    echo 'Installing software...'
    Start-Sleep -s 2
    InstallSoftware
    Host-clear
} else {
    # Source file location
    $source = 'https://github.com/microsoft/winget-cli/releases/download/v1.0.11451/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle'
    # Destination to save the file
    $destination = 'c:\winget.appxbundle'
    Invoke-WebRequest -Uri $source -OutFile $destination
    echo 'We download WinGet'
    Start-Sleep -Seconds 3
    Add-AppxPackage $destination
    clear | echo 'Installing software...'
    InstallSoftware
    Host-clear
}