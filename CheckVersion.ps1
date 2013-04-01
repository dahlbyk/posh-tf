$Global:TFMissing = $false

if (!(Get-Command tf -ErrorAction SilentlyContinue)) {
    $tfPath = Get-ChildItem "HKLM:SOFTWARE$(if([IntPtr]::Size -eq 8) { '\Wow6432Node' })\Microsoft\VisualStudio\1*.0" |
        sort Name -desc | select -First 1 | Get-ItemProperty | Select -Exp InstallDir | Join-Path -ChildPath tf.exe

    if ($tfPath) {
        Set-Alias tf $tfPath
    } else {
        Write-Warning "tf command could not be found. Please create an alias or add it to your PATH."
        $Global:TFMissing = $true
    }
}
