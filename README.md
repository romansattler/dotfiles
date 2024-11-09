# dotfiles
Personal dot and config files.

## Setup

- Ensure `$HOME/.config/` does not exist

- Create `$HOME/.gitignore` and ignore `$HOME/.config/`

- Clone repo as bare into `$HOME/.config/`
  ```pwsh
  git clone --bare https://github.com/romansattler/dotfiles $HOME/.config
  ```

- Add alias

  Bash:
  ```bash
  alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'

  echo "alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'" >> $HOME/.bashrc
  ```

  PowerShell:
  ```pwsh
  function Manage-Config { git --git-dir "$HOME/.config/" --work-tree $HOME $args }
  Set-Alias -Name config -Value Manage-Config

  Add-Content -Path $PROFILE.CurrentUserAllHosts -Value 'function Manage-Config { git --git-dir "$HOME/.config/" --work-tree $HOME $args }'
  Add-Content -Path $PROFILE.CurrentUserAllHosts -Value 'Set-Alias -Name config -Value Manage-Config'
  ```
  
- Checkout dotfiles
  ```pwsh
  config checkout
  config config --local status.showUntrackedFiles no
  ```