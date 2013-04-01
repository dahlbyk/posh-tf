Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-tf module from current directory
Import-Module .\posh-tf

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-tf


# Set up a simple prompt, adding the TF prompt parts inside TF repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($pwd.ProviderPath) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}

Pop-Location
