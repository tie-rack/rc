autoload -U compinit; compinit
autoload -U colors; colors
autoload zmv

alias ls="ls -lGA"
export LSCOLORS=dxfxcxdxbxegedabagacad

# === Bundler ===
alias be="bundle exec"

# === Rails ===
alias ss="./script/server"
alias sc="./script/console"

# === History ===
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# === .cms ===
cms_dir() {
    if [ -d .cms ]; then
        if [ $INSIDE_EMACS ]; then
            echo ' (◟ᅇ)◜'
        else
            echo ' 👻'
        fi
    fi
}

# === Git ===
parse_git_branch() {
    BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ $BRANCH ]; then
        echo "%{$fg[cyan]%} $BRANCH%{$reset_color%}"
    fi
}

alias git-no-whitespace="git diff -w --no-color | git apply --cached --ignore-whitespace"

# === PROMPT ===
setopt prompt_subst
PROMPT_1='%{$terminfo[bold]$fg[green]%}%~%{$reset_color%}%{$reset_color%}$(parse_git_branch)$(cms_dir)'
PROMPT_2='%{$terminfo[bold]$fg[yellow]%}%#%{$reset_color%} '
RPROMPT='%{$fg[yellow]%}%?%{$reset_color%}'
if [[ -n "$INSIDE_EMACS" ]]; then
    PROMPT_1="$PROMPT_1 $RPROMPT"
    RPROMPT=""
fi
PROMPT="$PROMPT_1
$PROMPT_2"

# === TITLE ===
case $TERM in
    *xterm*|ansi)
        function settab { print -Pn "\e]1;%c\a" }
        function settitle { print -Pn "\e]2;%c\a" }
        function chpwd { settab;settitle }
        function precmd { settab;settitle }
        settab;settitle
        ;;
esac

# === EMACS ===
[[ $TERM == eterm-color ]] && export TERM=xterm

alias e="emacsclient -n"

export EDITOR=emacsclient

if [ $INSIDE_EMACS ]; then
    export PAGER="emacs-pager"
fi

# === LOCAL SETTINGS ===
if [[ -r ~/.zshrclocal ]]; then
  source ~/.zshrclocal
fi
