if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -U path
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ANDROID_HOME="$HOME/Library/Android/sdk"
export BUN_INSTALL="$HOME/.bun"
export EDITOR="code --wait"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

alias ls="lsd --no-symlink"
alias ll="lsd -l --no-symlink"
alias la="lsd -la --no-symlink"
alias lt="lsd --tree --no-symlink"
alias cat="bat --paging=never"

eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
