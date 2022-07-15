# Enable colors and change prompt:
colorscript random
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
WORDCHARS="*?[]~=&;!#$%^(){}<>"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

#bindkey -e

bindkey "^[[1;3C" forward-word                      # alt + arrow right
bindkey "^[[1;3D" backward-word                     # alt + arrow left
bindkey '^[[1;2A' history-substring-search-up       # shift + arrow up
bindkey '^[[1;2B' history-substring-search-down     # shift + arrow down
bindkey '^[[3~' delete-char                         # del
bindkey '^[[H' beginning-of-line                    # home
bindkey '^[[F' end-of-line                          # end
bindkey '^[[4~' end-of-line                         # end

bindkey '^[h' backward-kill-word                    # alt + backspace
bindkey '^[[3;3~' kill-word                         # alt + del
bindkey '^[[A' up-history                           # arrow up
bindkey '^[[B' down-history                         # arrow down

bindkey -s '^o' '^ulfcd\n'                          # open lf
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'      # open fuzzy search

# bindkey -v
# export KEYTIMEOUT=1


echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#eval "$(starship init zsh)"С

#autoload -Uz select-word-style
#select-word-style bash