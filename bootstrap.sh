#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════
#  bootstrap.sh — install every dependency, then link the configuration.
#  Safe to re-run.
# ═══════════════════════════════════════════════════════════════════════

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN=$'\e[1;32m'; DIM=$'\e[2;37m'; RESET=$'\e[0m'
step() { printf '\n%s▸ %s%s\n' "$GREEN" "$1" "$RESET"; }
info() { printf '%s  %s%s\n' "$DIM" "$1" "$RESET"; }

[[ $EUID -eq 0 ]] && { echo "Run as your normal user, not root." >&2; exit 1; }

PACKAGES=(
    # ── Window manager and desktop ──
    i3 i3lock i3blocks suckless-tools dex
    picom feh rofi lxappearance
    network-manager-gnome dunst libnotify-bin
    # ── Terminal ──
    kitty tmux zsh
    zsh-autosuggestions zsh-syntax-highlighting
    # ── Shell tooling ──
    bat eza fd-find ripgrep fzf zoxide btop
    # ── X utilities ──
    x11-utils xclip maim imagemagick xss-lock libnss3-tools
    # ── Fonts and icons ──
    fonts-font-awesome papirus-icon-theme
    # ── Offensive tooling ──
    seclists
    # ── VMware guest integration ──
    open-vm-tools open-vm-tools-desktop
    # ── Base ──
    git curl wget unzip
)

step "Updating package lists"
sudo apt-get update

step "Installing packages"
# Installed one at a time so a single unavailable package cannot abort the run.
missing=()
for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        info "already present  $pkg"
    elif sudo apt-get install -y --no-install-recommends "$pkg" >/dev/null 2>&1; then
        printf '  installed       %s\n' "$pkg"
    else
        missing+=("$pkg")
        printf '  UNAVAILABLE     %s\n' "$pkg"
    fi
done

step "Installing JetBrainsMono Nerd Font"
FONT_DIR="$HOME/.local/share/fonts"
if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd Font"; then
    info "already present"
else
    mkdir -p "$FONT_DIR"
    tmp="$(mktemp -d)"
    url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    if curl -fsSL "$url" -o "$tmp/JetBrainsMono.zip"; then
        unzip -qo "$tmp/JetBrainsMono.zip" -d "$FONT_DIR/JetBrainsMono" \
            -x "*.txt" "*.md" "LICENSE*"
        fc-cache -f "$FONT_DIR" >/dev/null
        printf '  installed       JetBrainsMono Nerd Font\n'
    else
        info "download failed — install it manually from nerdfonts.com"
    fi
    rm -rf "$tmp"
fi

step "Linking configuration"
"$DOTFILES/install.sh"

if ((${#missing[@]})); then
    step "Not available in your repositories"
    printf '  %s\n' "${missing[@]}"
    info "Everything else installed fine; these are optional."
fi

step "Bootstrap complete"
cat <<'MSG'

  1. Log out.
  2. Pick the i3 session at the login screen.
  3. Log back in.

  Set zsh as your login shell if it is not already:

      chsh -s "$(command -v zsh)"

MSG
