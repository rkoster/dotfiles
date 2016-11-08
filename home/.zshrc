# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pure"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Fix force tmux to use 256 colors
export TERM=xterm-256color

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm rails gem bundler brew knife vagrant tmux docker cf)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Set editor
export EDITOR="emacs"

# Fix emacs colors
alias emacs='TERM=xterm-16color emacs -nw'

# Fix tmux hidden caracter issues
alias tmux='tmux -u'

# json-prettify
alias json-prettify="ruby -e \"require 'json'; puts (JSON.pretty_generate JSON.parse(STDIN.read))\""

# Setup homebrew
export PATH=/usr/local/bin:$PATH

# Setup Go
export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH

# Direnv
eval "$(direnv hook zsh)"

# Setup jenv
eval "$(jenv init -)"

# Set default vagrant provider
export VAGRANT_DEFAULT_PROVIDER=virtualbox

# Setup Python paths
export PYTHONPATH=/usr/local/lib/python3.5/site-packages

# Disable autocorrect form some commands
alias cf='nocorrect cf'
alias bosh='nocorrect bosh'

function bosh() {
    case $* in
        -n* ) shift 1; command bosh -n "$@" && tput bel || tput bel;;
        * ) command bosh "$@" ;;
    esac
}

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# Set bosh-lite size
export VM_MEMORY=10240
export VM_CORES=4


start_docker() {
    docker-machine start
    eval $(docker-machine env)
}

# Fix locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# jq templates
jq_templates() {
    find -L templates -name \*.yml -exec \
         echo "echo '\x1B[33m{}\x1B[39m'; cat {} | yaml2json | jq '$1'" \; | \
        sh 2>&1 | sed '$!N;/null/d;P;D'
}

# jq deployments
jq_deployments() {
    find -L deployments -name \*.yml -exec \
         echo "echo '\x1B[33m{}\x1B[39m'; cat {} | yaml2json | jq '$1'" \; | \
        sh 2>&1 | sed '$!N;/null/d;P;D'
}

# current bosh deployment
bosh_deployment() {
    cat ~/.bosh_config | yaml2json | jq -r 'getpath(["deployment", .target])'
}

# jq deployment
jq_deployment() {
    d=`cat ~/.bosh_config | yaml2json | jq -r 'getpath(["deployment", .target])'`
    cat $d | yaml2json | jq "$1"
}
