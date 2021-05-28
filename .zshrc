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

# Update utility functions
alias upduni='cd ~/Documents/Uni && git add -A && git commit -a -m "Updated" && git push'
pipupd(){
    echo 'pip : checking updates'

    check=`pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1`
    count=`echo $check | wc | awk '{print $2}'`

    if [ $count -gt 0 ]; then
        echo $check | xargs -n1 python -m pip install -U
    else
        echo 'No updates available'
    fi
}
opamupd(){
    opam update
    opam upgrade --check
    if [ $? -eq 0 ]; then
        opam upgrade
    else
        echo 'No updates available'
    fi
}
fullupd(){
    echo '|> Full update <|'
    echo '===Updating Pacman/AUR==='
    paru

    echo; echo '===Updating Uni repository==='
    upduni; cd

    echo; echo '===Updating Rust packages==='
    rustup update

    echo; echo '===Updating Python packages==='
    pipupd

    echo; echo '===Updating JVM SDK packages==='
    sdk selfupdate; sdk update; sdk upgrade

    echo; echo '===Updating OCaml packages==='
    opamupd

    echo; echo '===Checking updates from global NPM packages==='
    ncu -gu

    echo; echo '|> Full update finished <|'
}


mkcd(){
    mkdir $1
    cd $1
}

alias h="history"
alias p="pwd -P"
alias s="sudo -s"
alias hc='herbstclient'
alias ff='firefox'

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
alias rc.lua="nvim ~/.config/awesome/rc.lua"

# nvidia optimus -> prime select
alias nvidia="sudo prime-select nvidia"
alias intel="sudo prime-select intel"
# cpu governor
alias gameoff="sudo cpufreq-set -g powersave"
alias gameon="sudo cpufreq-set -g performance"

# other
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

alias icat="kitty +kitten icat"
alias ls="ls --color=auto -a"
alias lart="ls --color=auto -lart"
alias rm="rm -f"
alias yeet="rm -rf"
# alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias p10kupd="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

eval $(thefuck --alias)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#compdef _gh gh

# zsh completion for gh                                   -*- shell-script -*-

__gh_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_gh()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive compCount comp lastComp
    local -a completions

    __gh_debug "\n========= starting completion logic =========="
    __gh_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __gh_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __gh_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., gh -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __gh_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __gh_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __gh_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __gh_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __gh_debug "No directive found.  Setting do default"
        directive=0
    fi

    __gh_debug "directive: ${directive}"
    __gh_debug "completions: ${out}"
    __gh_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __gh_debug "Completion received error. Ignoring completions."
        return
    fi

    compCount=0
    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab=$(printf '\t')
            comp=${comp//$tab/:}

            ((compCount++))
            __gh_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __gh_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subDir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __gh_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __gh_debug "Listing directories in ."
        fi

        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
    elif [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ] && [ ${compCount} -eq 1 ]; then
        __gh_debug "Activating nospace."
        # We can use compadd here as there is no description when
        # there is only one completion.
        compadd -S '' "${lastComp}"
    elif [ ${compCount} -eq 0 ]; then
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            __gh_debug "deactivating file completion"
        else
            # Perform file completion
            __gh_debug "activating file completion"
            _arguments '*:filename:_files'" ${flagPrefix}"
        fi
    else
        _describe "completions" completions $(echo $flagPrefix)
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_gh" ]; then
	_gh
fi

# opam configuration
test -r /home/notkamui/.opam/opam-init/init.zsh && . /home/notkamui/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/notkamui/.sdkman"
[[ -s "/home/notkamui/.sdkman/bin/sdkman-init.sh" ]] && source "/home/notkamui/.sdkman/bin/sdkman-init.sh"
