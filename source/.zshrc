# Get environment
if [ -f ~/.zsh.private ]; then
    source ~/.zsh.private
fi
if [ -f ~/.zsh.work ]; then
    source ~/.zsh.work
fi

# Generals
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias please="sudo"
alias weather_full="curl 'https://wttr.in/Frankfurt?1qF/'"
alias history="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias vi="nvim"

# pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Custom prompt colors
fpath+=~/.zfunc; autoload -Uz compinit; compinit
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "%K{yellow}%F{black} ⎇ %b "
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

short_pwd() {
  local dirs=("${(s:/:)PWD}")
  local count=${#dirs[@]}
  (( count > 1 )) && echo "${dirs[-2]}/${dirs[-1]}" || echo "${dirs[-1]}"
}

precmd() {
  vcs_info
  local pathinfo="$(short_pwd)"
  local gitinfo="${vcs_info_msg_0_}"

  prompt_end(){
    print -P "%f%k%F{yellow}%f"
  }
  PROMPT="
%K{black}%F{white} %* %f%k%K{blue}%F{black} ${pathinfo}  ${gitinfo}$(prompt_end)
> "
}

# zsh-history and zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

