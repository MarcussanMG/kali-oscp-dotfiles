#!/usr/bin/env bash
# One-time setup: launches Burp, pulls its CA cert, trusts it in Firefox,
# and prepares the FoxyProxy import string on the clipboard.
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
CERT_DIR="$DOTFILES/burp"
CERT_FILE="$CERT_DIR/burp-ca.der"
GREEN=$'\e[1;32m'; YELLOW=$'\e[1;33m'; RESET=$'\e[0m'
ok()   { printf '%s  %s%s\n' "$GREEN" "$RESET$1" ""; }
warn() { printf '%s  %s%s\n' "$YELLOW" "$1" "$RESET"; }

mkdir -p "$CERT_DIR"

if ! command -v burpsuite >/dev/null; then
    echo "burpsuite not found in PATH" >&2
    exit 1
fi

if ! curl -s --max-time 1 http://127.0.0.1:8080 >/dev/null 2>&1; then
    warn "Starting Burp Suite — click through to 'Temporary project' → 'Use Burp defaults' → Start Burp"
    nohup burpsuite >/dev/null 2>&1 &
    printf "  waiting for the proxy listener on 127.0.0.1:8080"
    for _ in $(seq 1 90); do
        curl -s --max-time 1 http://127.0.0.1:8080 >/dev/null 2>&1 && break
        printf '.'; sleep 2
    done
    echo
fi

if ! curl -s --max-time 3 http://127.0.0.1:8080 >/dev/null 2>&1; then
    echo "Burp's proxy listener never came up on :8080 — open Burp manually and re-run this script." >&2
    exit 1
fi

curl -s http://127.0.0.1:8080/cert -o "$CERT_FILE"
ok "cert downloaded  $CERT_FILE"

INI="$HOME/.mozilla/firefox/profiles.ini"
PROFILE_REL="$(awk -F= '/^\[Install/{f=1} f&&/^Default=/{print $2; exit}' "$INI")"
PROFILE_DIR="$HOME/.mozilla/firefox/${PROFILE_REL:-}"
[[ -d "$PROFILE_DIR" ]] || PROFILE_DIR=""
if [[ -n "$PROFILE_DIR" ]] && command -v certutil >/dev/null; then
    certutil -A -n "PortSwigger CA" -t "C,," -i "$CERT_FILE" -d "sql:$PROFILE_DIR"
    ok "trusted in Firefox  $PROFILE_DIR"
else
    warn "certutil or Firefox profile not found — install libnss3-tools and re-run"
fi

IMPORT_LINE="http://127.0.0.1:8080?color=ff6633&title=Burp+Suite&proxyDns=false&enabled=false"
if command -v xclip >/dev/null; then
    printf '%s' "$IMPORT_LINE" | xclip -selection clipboard
    ok "copied to clipboard — paste into FoxyProxy → Options → Import Proxy List"
else
    echo "  paste this into FoxyProxy → Options → Import Proxy List:"
    echo "  $IMPORT_LINE"
fi
