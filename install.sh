#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

mkdir -p \
    "$HOME/.config/i3" \
    "$HOME/.config/kitty" \
    "$HOME/.config/rofi" \
    "$HOME/.config/i3blocks" \
    "$HOME/.local/bin"

link_file() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mv "$target" "${target}.backup.${TIMESTAMP}"
        printf 'Backup: %s\n' "${target}.backup.${TIMESTAMP}"
    fi

    ln -sfn "$source" "$target"
    printf 'Linked: %s -> %s\n' "$target" "$source"
}

link_file "$DOTFILES/i3/config" "$HOME/.config/i3/config"
link_file "$DOTFILES/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
link_file "$DOTFILES/i3blocks/config" "$HOME/.config/i3blocks/config"
link_file "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

for file in "$DOTFILES"/rofi/*; do
    [ -e "$file" ] || continue
    link_file "$file" "$HOME/.config/rofi/$(basename "$file")"
done

for file in "$DOTFILES"/bin/*; do
    [ -e "$file" ] || continue
    chmod +x "$file"
    link_file "$file" "$HOME/.local/bin/$(basename "$file")"
done

echo
echo "Dotfiles installed successfully."
