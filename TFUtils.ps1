function Get-TFStatus() {
    $settings = $Global:TFPromptSettings
    $enabled = (-not $settings) -or $settings.EnablePromptStatus
    if ($enabled)
    {
        if($settings.Debug) {
            $sw = [Diagnostics.Stopwatch]::StartNew(); Write-Host ''
        } else {
            $sw = $null
        }

        # I accept Pull Requests
        $result = $null

        dbg 'Finished' $sw
        if($sw) { $sw.Stop() }
        return $result
    }
}
