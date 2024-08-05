default: wayland emacs
	stow alacritty git fontconfig dunst lf nvim

all: defualt
	stow alacritty bspwm dunst emacs fontconfig git i3 lf

wayland:
	stow wayland

# xorg:

emacs:
	mkdir ~/.config/emacs
	stow emacs

# zsh:

check-requirements:
	for cmd in make stow; do \
	command -v "$${cmd}" >/dev/null 2>&1 || echo "$${cmd} not found" ; done
