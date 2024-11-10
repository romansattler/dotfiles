$env:POSH_SESSION_DEFAULT_USER = [System.Environment]::UserName

Import-Module posh-git
Import-Module Terminal-Icons

if ($IsWindows) {
   $documentsDir = [Environment]::GetFolderPath("MyDocuments")
   $configDir = "$documentsDir/powershell"
}
elseif ($IsLinux) {
   $configDir = "~/.powershell"
}
else {
   throw "Platform not supported."
}
$themePath = "$configDir/theme.omp.json"

oh-my-posh init pwsh --config $themePath | Invoke-Expression

Import-Module z

Set-PSReadLineOption -PredictionSource History

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -Colors @{ InlinePrediction = '#999999' }

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
   param($wordToComplete, $commandAst, $cursorPosition)
   [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
   $Local:word = $wordToComplete.Replace('"', '""')
   $Local:ast = $commandAst.ToString().Replace('"', '""')
   winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
   }
}

function Manage-Config {
   git --git-dir "$HOME/.config/" --work-tree $HOME $args
}

Set-Alias -Name config -Value Manage-Config