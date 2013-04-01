if (Get-Module posh-tf) { return }

Push-Location $psScriptRoot
.\CheckVersion.ps1 > $null

. .\Utils.ps1
. .\TFUtils.ps1
. .\TFPrompt.ps1
. .\TFTabExpansion.ps1
Pop-Location

Export-ModuleMember `
    -Function @(
        'Write-TFStatus',
        'Write-Prompt',
        'Get-TFStatus',
        'TabExpansion')
