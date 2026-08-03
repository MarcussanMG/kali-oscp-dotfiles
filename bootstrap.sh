#!/usr/bin/env bash

set -euo pipefail

sudo apt update

sudo apt install -y \
    i3 \
    i3status \
    i3blocks \
    i3lock \
    suckless-tools \
    feh \
    rofi \
    kitty \
    lxappearance \
    fonts-font-awesome \
    tmux \
    bat \
    eza \
    fd-find \
    ripgrep \
    fzf \
    zoxide \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    btop \
    network-manager-gnome \
    open-vm-tools \
    open-vm-tools-desktop \
    seclists \
    git \
    curl \
    wget \
    unzip

"$HOME/.dotfiles/install.sh"

echo
echo "Bootstrap complete."
echo "Log out and select the i3 session."
