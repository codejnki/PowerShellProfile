# Remove curl alias
Remove-Item Alias:\curl -ErrorAction  SilentlyContinue

Import-Module pscolor
#Import-Module pscx

Import-Module PSBashCompletions
Register-BashArgumentCompleter "kubectl" c:\users\phstockton\completions\kubectl_completions.sh

# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Ensure oh-my-posh is loaded
Import-Module -Name oh-my-posh

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias ls Get-ChildItemColor -Option AllScope
Set-Alias l Get-ChildItemColorFormatWide -Option AllScope



# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Helper function to show Unicode character
function U
{
    param
    (
        [int] $Code
    )
 
    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }
 
    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }
 
    throw "Invalid character code $Code"
}

# Ensure posh-git is loaded
#-Module -Name posh-git

# Start SshAgent if not already
# Need this if you are using github as your remote git repository
if (! (ps | ? { $_.Name -eq 'pageant'})) {
    Start-SshAgent
}

Set-Theme Paradox
