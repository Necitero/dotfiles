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

# init nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

short_pwd() {
  local dirs=("${(s:/:)PWD}")
  local count=${#dirs[@]}
  (( count > 1 )) && echo "${dirs[-2]}/${dirs[-1]}" || echo "${dirs[-1]}"
}

precmd() {
  vcs_info
  local pathinfo="$(short_pwd)"
  local gitinfo="${vcs_info_msg_0_}"
  local end_segment

  if [[ -n $gitinfo ]]; then
    end_segment="%k%F{yellow}◗%f"
  else
    end_segment="%k%F{blue}◗%f"
  fi

  PROMPT="
%F{black}◖%K{black}%F{white} %* %f%k%K{blue}%F{black} ${pathinfo} ${gitinfo}${end_segment}
> "
}

# zsh-history 
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

