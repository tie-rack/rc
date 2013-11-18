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
HISTSIZE=1000
SAVEHIST=1000
setopt append_history
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# === Git ===
parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

alias git-no-whitespace="git diff -w --no-color | git apply --cached --ignore-whitespace"

# === PROMPT ===
setopt prompt_subst
PROMPT='%{$terminfo[bold]$fg[green]%}%~%{$reset_color%}%{$reset_color%} %{$reset_color%}%{$fg[cyan]%}$(parse_git_branch)%{$reset_color%}
%{$terminfo[bold]$fg[yellow]%}%n%{$reset_color%} '
RPROMPT='%{$fg[yellow]%}%?%{$reset_color%}'

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

# === LOCAL SETTINGS ===
if [[ -r ~/.zshrclocal ]]; then
  source ~/.zshrclocal
fi
