#!/usr/bin/zsh
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
autoload -Uz add-zsh-hook
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}
precmd() {print -Pn "\e]133;A\e\\"}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}

add-zsh-hook -Uz chpwd chpwd-osc7-pwd

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
# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")
  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi
  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}
compdef _dotnet_zsh_complete dotnet
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
