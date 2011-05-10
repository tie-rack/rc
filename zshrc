autoload -U compinit; compinit
autoload -U colors; colors
autoload zmv

alias ls="ls -lGA"
export LSCOLORS=dxfxcxdxbxegedabagacad

# === Rails ===
alias ss="./script/server"
alias sc="./script/console"

# === History ===
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt append_history
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# === SVN ===
alias svn-add-all='svn add * --force' # 'svn st | grep "^?" | tr -d "?" | xargs svn add'
alias st='svn status --ignore-externals | egrep -v "^X"'

parse_svn_revision() {
  svn info 2> /dev/null | grep Revision | cut -d ' ' -f 2
}

parse_svn_status() {
  svn st --ignore-externals 2> /dev/null | grep '^[^X] ' | cut -c 1 | sort | uniq | tr -d "\n"
}

# === Git ===
parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\(\1\)/'
}

# === PROMPT ===
setopt prompt_subst
PROMPT='%{$fg[green]%}[%{$terminfo[bold]$fg[green]%}%~%{$reset_color%}%{$fg[green]%}]%{$reset_color%} %{$reset_color%}%{$fg[cyan]%}$(parse_git_branch)%{$reset_color%}
%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%m%{$reset_color%} '
RPROMPT='%{$fg[red]%}$(parse_svn_status)%{$reset_color%} %{$bg[blue]%}%{$fg[cyan]%}$(parse_svn_revision)%{$reset_color%} %{$fg[cyan]%}[%*]%{$reset_color%}'

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

# === LOCAL SETTINGS ===
if [[ -r ~/.zshrclocal ]]; then
  source ~/.zshrclocal
fi
