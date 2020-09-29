bunnyfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Autojump
#. /usr/share/autojump/autojump.zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=3

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        git
        common-aliases
        history
        sublime
        sudo
        web-search
        colorize
        colored-man-pages
        z
        zsh-syntax-highlighting
        zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_STRATEGY=(history)

# User configuration
export HISTSIZE=500000
export SAVEHIST=500000
# export MANPATH="/usr/local/man:$MANPATH"

# Kitty
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin


# Cursor
#echo -e -n "\x1b[\x30 q" # changes to blinking block
#echo -e -n "\x1b[\x31 q" # changes to blinking block also
#echo -e -n "\x1b[\x32 q" # changes to steady block
#echo -e -n "\x1b[\x33 q" # changes to blinking underline
echo -e -n "\x1b[\x34 q" # changes to steady underline
#echo -e -n "\x1b[\x35 q" # changes to blinking bar
#echo -e -n "\x1b[\x36 q" # changes to steady bar

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


export EDITOR='nvim'
export BROWSER='firefox'

#This causes pasted URLs to be automatically escaped, without needing to disable globbing.
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Freeze and unfreeze processes (for example: stop firefox)
stop(){
  if [ $# -ne 1 ]; then
          echo 1>&2 Usage: stop process
  else
    PROCESS=$1
    echo "Stopping processes with the word ${tGreen}$1${tReset}"
    ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -STOP
  fi
}

cont(){
  if [ $# -ne 1 ]; then
          echo 1>&2 Usage: cont process
  else
    PROCESS=$1
    echo "Continuing processes with the word ${tGreen}$1${tReset}"
    ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -CONT
  fi
}

alias h="history"
alias p="pwd -P"
alias s="sudo -s"
alias hc='herbstclient'
alias ff='firefox'
alias c="while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &; clear"

alias netprocs="lsof -P -i -n"

# neovim
alias init.vim="nvim ~/.config/nvim/init.vim"

# Quick edit
# alias subl="subl3"
alias xr="nvim ~/.Xresources"
alias xrc="nvim ~/.wally/Xresources-clean"
alias zshrc="nvim ~/.zshrc"
# alias i3config="nvim ~/.config/i3/config"
# alias polyconf="nvim ~/.config/polybar/config"
alias dunstrc="nvim ~/.config/dunst/dunstrc"
alias tint2rc="nvim ~/.config/tint2/tint2rc"
alias userChrome.css="nvim ~/thm/Firefox/userChrome.css"
alias stconf="nvim ~/pro/xst/src/config.h"
alias playlists="nvim ~/.config/mpv/tubify_playlists"
alias airlinevim="nvim ~/.config/nvim/plugged/vim-airline/autoload/airline/themes/dark.vim"
alias rc.lua="nvim ~/.config/awesome/rc.lua"

# nvidia optimus -> prime select
alias nvidia="sudo prime-select nvidia"
alias intel="sudo prime-select intel"
# cpu governor
alias gameoff="sudo cpufreq-set -g powersave"
alias gameon="sudo cpufreq-set -g performance"

# translate-shell: brief
alias t='trans -brief'

# other
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

alias ls="ls --color=auto -a"
alias lart="ls --color=auto -lart"
alias rm="rm -f"
alias yeet="rm -rf"
# alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias p10kupd="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias upduni='cd ~/Documents/Uni && git add -A && git commit -a -m "Updated" && git push'
