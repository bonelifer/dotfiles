#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"

echo "Collecting dotfiles from $HOME_DIR to $DOTFILES_DIR"

safe_cp() {
    local src="$1" dst="$2"
    if [ -e "$src" ]; then
        cp "$src" "$dst"
    else
        echo "Skipping (not found): $src"
    fi
}

safe_cp_dir() {
    local src="$1" dst="$2"
    if [ -d "$src" ]; then
        mkdir -p "$dst"
        cp -r "$src/." "$dst/"
    else
        echo "Skipping (not found): $src"
    fi
}

# ~/ -> rc/
safe_cp "$HOME_DIR/.bashrc"       "$DOTFILES_DIR/rc/.bashrc"
safe_cp "$HOME_DIR/.bash_aliases" "$DOTFILES_DIR/rc/.bash_aliases"
#safe_cp "$HOME_DIR/.zshrc"        "$DOTFILES_DIR/rc/.zshrc"
#safe_cp "$HOME_DIR/.zsh_aliases"  "$DOTFILES_DIR/rc/.zsh_aliases"
safe_cp "$HOME_DIR/.vimrc"        "$DOTFILES_DIR/rc/.vimrc"
safe_cp "$HOME_DIR/.xbindkeysrc"  "$DOTFILES_DIR/rc/.xbindkeysrc"

# ~/ -> config/ individual files
safe_cp "$HOME_DIR/.tmux.conf"   "$DOTFILES_DIR/config/.tmux.conf"
safe_cp "$HOME_DIR/.gitmux.conf" "$DOTFILES_DIR/config/.gitmux.conf"

# ~/.config/ -> config/ individual files
safe_cp "$HOME_DIR/.config/picom.conf"   "$DOTFILES_DIR/config/picom.conf"
safe_cp "$HOME_DIR/.config/compton.conf" "$DOTFILES_DIR/config/compton.conf"
safe_cp "$HOME_DIR/.config/terminalrc"   "$DOTFILES_DIR/config/terminalrc"

# ~/.config/ directories -> config/
for dir in nvim i3 i3status polybar espanso neofetch; do
    safe_cp_dir "$HOME_DIR/.config/$dir" "$DOTFILES_DIR/config/$dir"
done

# ~/scripts/ -> scripts/
safe_cp_dir "$HOME_DIR/scripts" "$DOTFILES_DIR/scripts"

echo "Done."
