posh-tf
========

A set of PowerShell scripts which provide TF/PowerShell integration

### Prompt for TF workspaces
   The prompt within TF workspaces would show something useful,
   if I could figure out how to get something useful out of `tf`.

### Tab completion
   Provides tab completion for common commands when using `tf`.
   E.g. `tf ch<tab>` --> `tf checkout`

Usage
-----

See `profile.example.ps1` as to how you can integrate the tab completion and/or TF prompt into your own profile.
Prompt formatting, among other things, can be customized using `$TFPromptSettings`.

Installing
----------

0. Verify you have PowerShell 2.0 or better with $PSVersionTable.PSVersion

1. Verify execution of scripts is allowed with `Get-ExecutionPolicy` (should be `RemoteSigned` or `Unrestricted`). If scripts are not enabled, run PowerShell as Administrator and call `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`.

2. Clone the posh-tf repository to your local machine.

3. From the posh-tf repository directory, run `.\install.ps1`.

4. Enjoy!
