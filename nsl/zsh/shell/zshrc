[[ $- != *i* ]] && return
autoload -U colors && colors
HISTSIZE=1000
SAVEHIST=1000
setopt append_history
setopt extended_history
# HISTCONTROL=ignorespace:ignoredups:erasedups
setopt hist_ignore_dups
setopt hist_ignore_space
unsetopt beep
# Vim or Emacs
bindkey -e

# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)		# Include hidden files.

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# # bindkey -v
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# # different cursor shapes for modes
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '

bindkey "^?" backward-delete-char #To fix deletion bug
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/aliases
source $ZDOTDIR/functions
PS1='%F{red}%(?..%?)%f%F{cyan}%2~%f%F{yellow}${vcs_info_msg_0_}%f%F{green}%B%(!.#.>)%b%f'
# 
# RPS1='%^ %F{yellow}${vcs_info_msg_0_}%f %F{red}%(?..%?)%f'
zstyle ':vcs_info:git:*' formats ' %b'

bindkey -s '^o' 'lfcd\n'  # lfcd
# bindkey -s '^t' 'tmux a\n'  # lfcd

setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# Set up zoxide(z)
eval "$(zoxide init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
