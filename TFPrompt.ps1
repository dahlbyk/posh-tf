$global:TFPromptSettings = New-Object PSObject -Property @{
    DefaultForegroundColor    = $Host.UI.RawUI.ForegroundColor

    BeforeText                = ' ['
    BeforeForegroundColor     = [ConsoleColor]::Yellow
    BeforeBackgroundColor     = $Host.UI.RawUI.BackgroundColor

    AfterText                 = ']'
    AfterForegroundColor      = [ConsoleColor]::Yellow
    AfterBackgroundColor      = $Host.UI.RawUI.BackgroundColor

    BranchForegroundColor       = [ConsoleColor]::Cyan
    BranchBackgroundColor       = $Host.UI.RawUI.BackgroundColor

    EnablePromptStatus        = !$Global:TFMissing

    Debug                     = $false
}

function Write-Prompt($Object, $ForegroundColor, $BackgroundColor = -1) {
    if ($BackgroundColor -lt 0) {
        Write-Host $Object -NoNewLine -ForegroundColor $ForegroundColor
    } else {
        Write-Host $Object -NoNewLine -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor
    }
}

function Write-TFStatus($status) {
    $s = $global:TFPromptSettings
    if ($status -and $s) {
        Write-Prompt $s.BeforeText -BackgroundColor $s.BeforeBackgroundColor -ForegroundColor $s.BeforeForegroundColor

        # I accept Pull Requests

        Write-Prompt $s.AfterText -BackgroundColor $s.AfterBackgroundColor -ForegroundColor $s.AfterForegroundColor
    }
}

if((Get-Variable -Scope Global -Name VcsPromptStatuses -ErrorAction SilentlyContinue) -eq $null) {
    $Global:VcsPromptStatuses = @()
}
function Global:Write-VcsStatus { $Global:VcsPromptStatuses | foreach { & $_ } }

# Add scriptblock that will execute for Write-VcsStatus
$Global:VcsPromptStatuses += {
    $Global:TFStatus = Get-TFStatus
    Write-TFStatus $TFStatus
}
