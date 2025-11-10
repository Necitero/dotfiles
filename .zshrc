export EDITOR=/usr/local/bin/nano
export VISUAL="$EDITOR"

# Project folder
export PROJECT_PATH="~/Documents/Projects"
export LATEST_NVM="23.5.0"

# Switch project folders
alias to_hme="cd ${PROJECT_PATH}/hme-design-system"
alias to_hme-one="cd ${PROJECT_PATH}/hme-one-web-design-system"
alias to_hme-td="cd ${PROJECT_PATH}/hme-test-drive"

alias to_mazda="cd ${PROJECT_PATH}/mazda"
alias to_mme-con="cd ${PROJECT_PATH}/mme-configuration-consultant-data"
alias to_mme-ai="cd ${PROJECT_PATH}/mme-ai-prototype"

alias to_bmw="cd ${PROJECT_PATH}/bmw-pattern-library"
alias to_wppraiin="cd ${PROJECT_PATH}/wppopen-raiin-comfy"
alias to_wppraiin-data="cd ${PROJECT_PATH}/wppopen-raiin-comfy-data"
alias to_syntion="cd ${PROJECT_PATH}/Syntion"
alias to_hornbach="cd ${PROJECT_PATH}/Hornbach"

alias lora_training="cd ~/Documents/ai-toolkit && echo \"Setting up venv...\" && pyenv local toolkitvenv"

# Switch projects and prepare
alias hme="to_hme && nvm use ${LATEST_NVM} && zed ./"
alias hme-one="to_hme-one && nvm use ${LATEST_NVM} && zed ./"
alias hme-td="to_hme-td && nvm use ${LATEST_NVM} && zed ./"

alias mazda="to_mazda && nvm use ${LATEST_NVM} && zed ./"
alias mme-con="to_mme-con && nvm use ${LATEST_NVM} && zed ./"
alias mme-ai="to_mme-ai && nvm use ${LATEST_NVM} && zed ./"

alias bmw="to_bmw && nvm use 20.16.0 && zed ./"
alias wppraiin="to_wppraiin && nvm use ${LATEST_NVM} && zed ./"
alias syntion="to_syntion && nvm use ${LATEST_NVM} && zed ./"
alias hornbach="to_hornbach && nvm use ${LATEST_NVM} && zed ./"

# Start various services
alias wppraiin-data="to_wppraiin-data && pnpm dev"

# Further aliases
alias weather="print \"Frankfurt, `curl -s 'https://api.open-meteo.com/v1/forecast?latitude=50.1155&longitude=8.6842&current=temperature_2m,rain' | jq -r '\"\(.current.temperature_2m)°C, \(.current.rain * 100)% Rain\"'`\""
alias please="sudo"
alias weather_full="curl 'https://wttr.in/Frankfurt?1qF/'"
alias history="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias clean_yarn="echo \"Cleaning cache...\" && yarn cache clean --all && echo \"Removing yarn version...\" && rm -rf ~/.yarn/berry && echo \"Setting yarn version...\" && yarn set version berry"
alias fuzzy="zed \$(fzf --preview 'fzf-preview.sh {}')"

# Auto suggestions
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - /Users/nico.borst/.zshrc)"
eval "$(pyenv init -)"
# pyenv end

# pnpm
export PNPM_HOME="/Users/nico.borst/Library/pnpm"
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
