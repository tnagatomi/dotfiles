# Emacs-style key bindings
bindkey -e

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# fzf
## Use fd for traversing files
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
## Output with colors
export FZF_DEFAULT_OPTS="--ansi"
## Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fgh - cd to ghq repository
fgh() {
  local repository=$(ghq list | fzf) &&
  cd "$(ghq root)/${repository}"
}

# nci - notify GitHub Actions workflows completion
nci() {
  gh run watch -i10 && osascript -e 'display notification "run is done!" with title "Terminal"'
}

# Zellij functions
function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function zri () { zellij run --name "$*" --in-place -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}
function zei () { zellij edit --in-place "$*";}
function zpipe () { 
  if [ -z "$1" ]; then
    zellij pipe;
  else 
    zellij pipe -p $1;
  fi
}

# Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

# Zellij completion
zinit ice as"completion"
zinit snippet ~/.local/share/zinit/completions/_zellij

# Enable advanced completion
autoload -U compinit && compinit

if [ -e ~/.zshrc.company ]; then
  source ~/.zshrc.company
fi

# History
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

# PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/opt/libpq/bin:$PATH
export PATH=${HOME}/go/bin:$PATH

# Default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Activate mise
eval "$(mise activate zsh)"

# Initializa Starship
eval "$(starship init zsh)"
