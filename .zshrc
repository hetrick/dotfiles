source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export WORKON_HOME=~/.ve
export PROJECT_HOME=~/workspace
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Created by `pipx` on 2022-05-05 12:56:46
export PATH="$PATH:/Users/noah.hetrick/.local/bin"
