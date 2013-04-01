function script:TFCommands($filter, $includeAliases) {
    tf | where { $_ -match '^tf (\w+)' } |
        foreach { $Matches[1] } |
        where { $_ -like "$filter*" } |
        sort
}

function TFTabExpansion($lastBlock) {
    switch -regex ($lastBlock -replace "^tf\s+","") {
        # Handles tf <cmd>
        "^(?<cmd>\S*)$" {
            TFCommands $matches['cmd'] $TRUE
        }

        # Handles tf help <cmd>
        "^help (?<cmd>\S*)$" {
            TFCommands $matches['cmd'] $FALSE
        }
    }
}

$PowerTab_RegisterTabExpansion = Get-Command Register-TabExpansion -Module powertab -ErrorAction SilentlyContinue
if ($PowerTab_RegisterTabExpansion)
{
    & $PowerTab_RegisterTabExpansion "tf.exe" -Type Command {
        param($Context, [ref]$TabExpansionHasOutput, [ref]$QuoteSpaces)  # 1:

        $line = $Context.Line
        $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
        $TabExpansionHasOutput.Value = $true
        TFTabExpansion $lastBlock
    }
    return
}

if (Test-Path Function:\TabExpansion) {
    Rename-Item Function:\TabExpansion TabExpansionBackup
}

function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()

    switch -regex ($lastBlock) {
        # Execute tf tab completion for all tf-related commands
        "^tf (.*)" { TFTabExpansion $lastBlock }

        # Fall back on existing tab expansion
        default { if (Test-Path Function:\TabExpansionBackup) { TabExpansionBackup $line $lastWord } }
    }
}
