# Enable colors and change prompt:
colorscript random
autoload -U colors && colors	# Load colors
autoload -Uz compinit && compinit
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
#WORDCHARS="*?[]~=&;!#$%^()<>"
WORDCHARS="${WORDCHARS/\//|}"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"


#clean up dots
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# Basic auto/tab complete:
#autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-preview 'eza --icons --color=always -a --group-directories-first $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --color=always -a --group-directories-first $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons -a --group-directories-first $realpath'
zmodload zsh/complist
#compinit
_comp_options+=(globdots)		# Include hidden files.

echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key
#show KEYBIND $ showkey -a !!!!!!!


key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
#key[Control-Left]="${terminfo[kLFT5]}"
#key[Control-Right]="${terminfo[kRIT5]}"


key[F1]="^[[[A"
key[F2]='^[[[B'
key[F3]='^[[[C'
key[F4]='^[[[D'
key[F5]='^[[[E'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]='^[[19~'
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]='^[[23~'
key[F12]='^[[24~'
key[Shift-F1]='^[[25~'
key[Shift-F2]='^[[26~'
key[Shift-F3]='^[[28~'
key[Shift-F4]='^[[29~'
key[Shift-F5]='^[[31~'
key[Shift-F6]='^[[32~'
key[Shift-F7]='^[[33~'
key[Shift-F8]='^[[34~'

key[Insert]='^[[4h'
key[Delete]='^[[P'
key[Home]='^[[1~'
key[End]='^[[4~'
key[PageUp]='^[[5~'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Down]='^[[B'
key[Right]='^[[C'
key[Left]='^[[D'


key[Enter]='^M'
key[Enter-Alt]='^[^M'

key[Esc]='^['
key[Esc-Alt]='^[^['

key[Tab]='\t'
key[Tab-Alt]='^[\t'

# jump words
key[Alt-Right]='^[[1;3C'
key[Alt-Left]='^[[1;3D'
key[Shift-Right]='^[[1;2C'
key[Shift-Left]='^[[1;2D'
key[Ctrl-Right]='^[[1;5C'
key[Ctrl-Left]='^[[1;5D'

# delete words
key[Backspace]='^?'
key[Shift-Del]='^[[3;2~'
key[Shift-Back]='^[[127;2u'
key[Alt-Del]='^[[255;3u'
key[Alt-Back]='^[^?'
key[Ctrl-Del]='^[[M'
key[Ctrl-Back]='^[[127;5u'

#weird keys
key[Shift-Return]='^[[13;2u'
key[Ctrl-Return]='^[[13;5u'
key[Alt-Return]='^[^M'
key[Shift-Space]='^[[32;2u'
key[Ctrl-Space]='^@'
# key[Alt-Space]=''

#substring search
key[Shift-Up]='^[[1;2A'
key[Shift-Down]='^[[1;2B'
key[Ctrl-Up]='^[[1;5A'
key[Ctrl-Down]='^[[1;5B'
key[Alt-Up]='^[[1;3A'
key[Alt-Down]='^[[1;3B'

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char

[[ -n "${key[Shift-Back]}" ]] && bindkey -- "${key[Shift-Back]}"  backward-delete-word
[[ -n "${key[Ctrl-Back]}" ]] && bindkey -- "${key[Ctrl-Back]}"  backward-delete-word
[[ -n "${key[Alt-Back]}" ]] && bindkey -- "${key[Alt-Back]}"  backward-delete-word

[[ -n "${key[Shift-Del]}" ]] && bindkey -- "${key[Shift-Del]}"  delete-word
[[ -n "${key[Ctrl-Del]}" ]] && bindkey -- "${key[Ctrl-Del]}"  delete-word
[[ -n "${key[Alt-Del]}" ]] && bindkey -- "${key[Alt-Del]}"  delete-word

[[ -n "${key[Shift-Up]}" ]] && bindkey -- "${key[Shift-Up]}"  history-substring-search-up
[[ -n "${key[Ctrl-Up]}" ]] && bindkey -- "${key[Ctrl-Up]}"  history-substring-search-up
[[ -n "${key[Alt-Up]}" ]] && bindkey -- "${key[Alt-Up]}"  history-substring-search-up

[[ -n "${key[Shift-Down]}" ]] && bindkey -- "${key[Shift-Down]}"  history-substring-search-down
[[ -n "${key[Ctrl-Down]}" ]] && bindkey -- "${key[Ctrl-Down]}"  history-substring-search-down
[[ -n "${key[Alt-Down]}" ]] && bindkey -- "${key[Alt-Down]}"  history-substring-search-down

[[ -n "${key[Shift-Return]}" ]] && bindkey -- "${key[Shift-Return]}"  accept-line
[[ -n "${key[Ctrl-Return]}" ]] && bindkey -- "${key[Ctrl-Return]}"  accept-line
[[ -n "${key[Alt-Return]}" ]] && bindkey -- "${key[Alt-Return]}"  accept-line

[[ -n "${key[Shift-Space]}" ]] && bindkey -- "${key[Shift-Space]}"  magic-space
[[ -n "${key[Ctrl-Space]}" ]] && bindkey -- "${key[Ctrl-Space]}"  magic-space
[[ -n "${key[Alt-Space]}" ]] && bindkey -- "${key[Alt-Space]}"  magic-space


[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Ctrl-Left]}"  ]] && bindkey -- "${key[Ctrl-Left]}"  backward-word
[[ -n "${key[Ctrl-Right]}" ]] && bindkey -- "${key[Ctrl-Right]}" forward-word
[[ -n "${key[Alt-Left]}"  ]] && bindkey -- "${key[Alt-Left]}"  backward-word
[[ -n "${key[Alt-Right]}" ]] && bindkey -- "${key[Alt-Right]}" forward-word
[[ -n "${key[Shift-Left]}"  ]] && bindkey -- "${key[Shift-Left]}"  backward-word
[[ -n "${key[Shift-Right]}" ]] && bindkey -- "${key[Shift-Right]}" forward-word


# if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
# 	autoload -Uz add-zle-hook-widget
# 	function zle_application_mode_start { echoti smkx }
# 	function zle_application_mode_stop { echoti rmkx }
# 	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
# 	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
# fi

####################3

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

export PATH=$PATH:/home/lzhecz/.millennium/ext/bin
