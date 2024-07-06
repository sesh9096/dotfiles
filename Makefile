default:
	stow emacs alacritty git fontconfig dunst lf

# wayland:

# xorg:

emacs:
	mkdir ~/.config/emacs
	stow emacs

# zsh:

check-requirements:
	for cmd in make stow; do \
	command -v "$${cmd}" >/dev/null 2>&1 || echo "$${cmd} not found" ; done
