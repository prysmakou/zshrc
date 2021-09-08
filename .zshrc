export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go
ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# Standard plugins can be found in $ZSH/plugins/
plugins=(git docker vi-mode kubectl)
# see https://github.com/softmoth/zsh-vim-mode
source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/opt/php@8.0/bin:$PATH"
export PATH="/usr/local/opt/php@8.0/sbin:$PATH"
# For compilers to find php@7.4 you may need to set:
export LDFLAGS="-L/usr/local/opt/php@8.0/lib"
export CPPFLAGS="-I/usr/local/opt/php@8.0/include"
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

alias cat="bat"
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
#alias aws="docker run --rm -it \
#   -e AWS_PROFILE -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION -e AWS_SESSION_TOKEN \
#   -v "~/.aws:/root/.aws" -v "$(pwd):/aws:rw" \
#   amazon/aws-cli"
# alias kops="docker run --rm -it -e NAME -e KOPS_STATE_STORE -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION \
#   -v "$HOME"/.ssh:/root/.ssh:ro \
#   -v "$HOME"/.aws:/root/.aws:ro \
#   -v "$HOME"/.kube:/root/.kube:rw \
#   -v "$(pwd)":/workdir \
#   -w /workdir \
#   kops:1.18.2"
# alias kubectl="docker run --rm -it \
#   -v "$HOME"/.ssh:/root/.ssh:ro \
#   -v "$HOME"/.aws:/root/.aws:ro \
#   -v "$HOME"/.kube:/root/.kube:rw \
#   -v "$(pwd)":/workdir \
#   -w /workdir \
#   kubectl:1.19.3"
# alias k="docker run --rm -it \
#   -v "$HOME"/.ssh:/root/.ssh:ro \
#   -v "$HOME"/.aws:/root/.aws:ro \
#   -v "$HOME"/.kube:/root/.kube:rw \
#   -v "$(pwd)":/workdir \
#   -w /workdir \
#   kubectl:1.19.3"
# alias helm="docker run --rm -it \
#   -v "$HOME"/.ssh:/root/.ssh:ro \
#   -v "$HOME"/.aws:/root/.aws:ro \
#   -v "$HOME"/.kube:/root/.kube:rw \
#   -v "$(pwd)":/workdir \
#   -w /workdir \
#   helm:3.4.2"
#alias helm="docker run -it --rm \
#  -v "$HOME"/.ssh:/root/.ssh:ro \
#  -v "$HOME"/.aws:/root/.aws:ro \
#  -v "$HOME"/.kube:/root/.kube:rw \
#  -v "$(pwd)":/workdir \
#  -w /workdir \
#  mytools:0.0.1 /usr/local/bin/helm"
#alias k="docker run -it --rm \
#  -v "$HOME"/.ssh:/root/.ssh:ro \
#  -v "$HOME"/.aws:/root/.aws:ro \
#  -v "$HOME"/.kube:/root/.kube:rw \
#  -v "$(pwd)":/workdir \
#  -w /workdir \
#  mytools:0.0.1 /usr/local/bin/kubectl"
#alias kops="docker run -it --rm \
#  -v "$HOME"/.ssh:/root/.ssh:ro \
#  -v "$HOME"/.aws:/root/.aws:ro \
#  -v "$HOME"/.kube:/root/.kube:rw \
#  -v "$(pwd)":/workdir \
#  -w /workdir \
#  mytools:0.0.1 /usr/local/bin/kops"
alias da="direnv allow"
alias zshrc="vi ~/.zshrc"
alias vimrc="vi ~/.vimrc"
eval "$(direnv hook zsh)"

export DOCKER_BUILDKIT=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. $HOME/.asdf/asdf.sh
# Autocompletion
source <(kubectl completion zsh)
source <(helm completion zsh)
source <(stern --completion=zsh)
source <(minikube completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source $HOME/.kube_ps1/kube-ps1.sh
PROMPT='$(kube_ps1)'$PROMPT
# VI mode
#bindkey -v
function zle-keymap-select zle-line-init
{
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
