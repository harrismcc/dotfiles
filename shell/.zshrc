source_if_exists() {
  [[ -s "$1" ]] && source "$1"
}

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.opencode/bin"
  "$HOME/.pulumi/bin"
  "$HOME/.lmstudio/bin"
  "$HOME/.git-ai/bin"
  "$HOME/Library/pnpm"
  "/usr/local/bin"
  "/opt/homebrew/anaconda3/bin"
  "/opt/homebrew/opt/postgresql@15/bin"
  "/Applications/Docker.app/Contents/Resources/bin"
  $path
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source_if_exists "$ZSH/oh-my-zsh.sh"

##############
# Git Prompt #
##############

if [[ -n "$ZSH_VERSION" ]]; then
  source_if_exists "$HOME/zsh-git-prompt/zshrc.sh"
  if (( $+functions[git_super_status] )); then
    PROMPT='%B%m%~%b$(git_super_status) %# '
  else
    PROMPT='%B%m%~%b %# '
  fi
fi

export GITHUB_USERNAME=harrismcc
export GITHUB_EMAIL="${GITHUB_EMAIL:-}"

# Set node ram options
export NODE_OPTIONS="--max_old_space_size=8192"
alias s="NODE_OPTIONS=\"--max_old_space_size=8192\" yarn node local_dev/start.js"

# Alias to kill all zellij sessions
alias zclean='zellij kill-all-sessions -y && zellij delete-all-sessions -y'
alias wz='wt switch -x "WT_ZELLIJ_REPO={{ repo | sanitize }} WT_ZELLIJ_BRANCH={{ branch | sanitize }} WT_ZELLIJ_PATH={{ worktree_path }} $HOME/bin/wt-zellij-attach"'

# Strange fix needed to get pre-commit checks to work
export YARN_IGNORE_NODE=1

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
# pnpm end

# Disable docker hints
export DOCKER_CLI_HINTS=false

# bun completions
source_if_exists "$HOME/.bun/_bun"

# Enable prompt caching for claude code
export DISABLE_PROMPT_CACHING=0

# Alias for git branches that are gone from remote
alias gone="!c() { git branch -vv | grep ': gone]' | awk '{print $1}'; }; c"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

export EDITOR=nvim

# nvm
export NVM_DIR="$HOME/.nvm"
for nvm_script in "$NVM_DIR/nvm.sh" "/opt/homebrew/opt/nvm/nvm.sh" "/usr/local/opt/nvm/nvm.sh"; do
  if [[ -s "$nvm_script" ]]; then
    source "$nvm_script"
    break
  fi
done
for nvm_completion in "$NVM_DIR/bash_completion" "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" "/usr/local/opt/nvm/etc/bash_completion.d/nvm"; do
  if [[ -s "$nvm_completion" ]]; then
    source "$nvm_completion"
    break
  fi
done

source_if_exists "$HOME/.daytona.completion_script.zsh"

# Be able to use :q to quit so my vim-coded brain can work
alias :q=exit
alias :wq=exit

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# Init starship
eval "$(starship init zsh)"

# Added by git-ai installer on Sun May 24 22:49:15 PDT 2026
export PATH="/Users/harris/.git-ai/bin:$PATH"

## Pi needs to use a later node version than we sometime use
pi() {
  nvm exec lts/krypton -- pi "$@"
}
