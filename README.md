# Kali OSCP Workstation

A minimal, fast, and reproducible Kali Linux environment designed for PEN-200 training and the OSCP exam.

The configuration prioritizes:

- Performance and stability
- Keyboard-driven navigation
- Persistent terminal sessions
- Minimal background services
- No animations, transparency, or unnecessary visual effects
- Easy restoration through Git and symbolic links

---

## Components

- **i3** — lightweight tiling window manager
- **Kitty** — fast terminal emulator
- **Rofi** — application launcher and power menu
- **i3blocks** — lightweight status bar
- **NetworkManager Applet** — graphical network and VPN management
- **tmux** — persistent terminal sessions and panes
- **Zsh** — interactive shell
- **batcat** — syntax-highlighted replacement for interactive `cat`
- **fzf** — interactive command-history search
- **zoxide** — faster directory navigation
- **JetBrainsMono Nerd Font** — terminal font and icon support

---

## Installation

Clone the repository:

```bash
git clone <REPOSITORY_URL> ~/.dotfiles
cd ~/.dotfiles
```

Install the required packages and apply the configuration:

```bash
./bootstrap.sh
```

After installation:

1. Log out.
2. Select the `i3` session from the login screen.
3. Log back in.

---

## Apply Configuration Only

Use this when the required packages are already installed:

```bash
cd ~/.dotfiles
./install.sh
```

The script creates symbolic links from the home directory to the files stored in this repository.

Existing configuration files are backed up automatically before being replaced.

---

## Repository Structure

```text
~/.dotfiles/
├── bin/
│   └── powermenu
├── i3/
│   └── config
├── i3blocks/
│   └── config
├── kitty/
│   └── kitty.conf
├── rofi/
│   ├── config.rasi
│   └── theme.rasi
├── tmux/
│   └── tmux.conf
├── zsh/
│   └── .zshrc
├── bootstrap.sh
├── install.sh
├── .gitignore
└── README.md
```

---

# Keyboard Shortcuts

## i3

The `Mod` key is the **Super/Windows key**.

### Applications

| Shortcut | Action |
|---|---|
| `Super + Enter` | Open Kitty |
| `Super + D` | Open Rofi application launcher |
| `Super + Shift + F` | Open Firefox |
| `Super + Shift + B` | Open Burp Suite |
| `Super + Shift + X` | Open the Rofi power menu |

### Window Focus

| Shortcut | Action |
|---|---|
| `Super + Left` | Focus the window on the left |
| `Super + Right` | Focus the window on the right |
| `Super + Up` | Focus the window above |
| `Super + Down` | Focus the window below |

### Move Windows

| Shortcut | Action |
|---|---|
| `Super + Shift + Left` | Move the current window left |
| `Super + Shift + Right` | Move the current window right |
| `Super + Shift + Up` | Move the current window up |
| `Super + Shift + Down` | Move the current window down |

### Workspaces

| Shortcut | Action |
|---|---|
| `Super + 1–9` | Switch to workspace 1–9 |
| `Super + Shift + 1–9` | Move the current window to workspace 1–9 |

Workspaces are intentionally not assigned fixed names or applications. They can be organized as needed while working.

### Window Management

| Shortcut | Action |
|---|---|
| `Super + Shift + Q` | Close the focused window |
| `Super + H` | Set the next split to horizontal |
| `Super + V` | Set the next split to vertical |
| `Super + R` | Enter resize mode |
| `Escape` | Exit resize mode |

### i3 Session

| Shortcut | Action |
|---|---|
| `Super + Shift + R` | Restart i3 in place |
| `Super + Shift + E` | Exit the i3 session |

Validate the i3 configuration before reloading it:

```bash
i3 -C -c ~/.config/i3/config
```

Reload it from a terminal:

```bash
export I3SOCK="$(i3 --get-socketpath)"
i3-msg reload
```

---

## tmux

The tmux prefix is:

```text
Ctrl + A
```

Press `Ctrl + A`, release it, and then press the second key.

### Panes

| Shortcut | Action |
|---|---|
| `Ctrl + A`, then `/` | Split into left and right panes |
| `Ctrl + A`, then `-` | Split into top and bottom panes |
| `Ctrl + A`, then `Left` | Focus the pane on the left |
| `Ctrl + A`, then `Right` | Focus the pane on the right |
| `Ctrl + A`, then `Up` | Focus the pane above |
| `Ctrl + A`, then `Down` | Focus the pane below |
| `exit` | Close the current pane |

### Sessions and Windows

| Shortcut | Action |
|---|---|
| `Ctrl + A`, then `C` | Create a new tmux window |
| `Ctrl + A`, then `N` | Move to the next tmux window |
| `Ctrl + A`, then `P` | Move to the previous tmux window |
| `Ctrl + A`, then `D` | Detach from the current session |
| `Ctrl + A`, then `R` | Reload `~/.tmux.conf` |
| `Ctrl + A`, then `?` | Display all tmux shortcuts |

List active sessions:

```bash
tmux ls
```

Attach to the persistent session:

```bash
tmux attach-session -t main
```

Display the current session name:

```bash
tmux display-message -p '#S'
```

Reload the configuration manually:

```bash
tmux source-file ~/.tmux.conf
```

The status bar is disabled to keep the terminal clean. The `main` session is automatically created or restored when Kitty starts.

The tmux session survives closing Kitty, but not rebooting Kali.

---

## Kitty

| Shortcut | Action |
|---|---|
| `Ctrl + Shift + C` | Copy selected text |
| `Ctrl + Shift + V` | Paste text |
| `Ctrl + Shift + F` | Search terminal output |
| `Shift + mouse selection` | Select text through tmux mouse capture |

Kitty is configured with:

- JetBrainsMono Nerd Font
- Large scrollback history
- No transparency
- No audio bell
- No cursor blinking
- No close confirmation
- Minimal window padding

After editing the configuration, close and reopen Kitty.

---

## Rofi

| Shortcut | Action |
|---|---|
| `Super + D` | Open the application launcher |
| `Super + Shift + X` | Open the power menu |
| `Arrow keys` | Move through results |
| `Enter` | Select an item |
| `Escape` | Close Rofi |

The power menu provides:

- Shutdown
- Reboot
- Logout
- Lock

Run it manually with:

```bash
~/.local/bin/powermenu
```

---

## Zsh

### History Search

| Shortcut | Action |
|---|---|
| `Ctrl + R` | Search command history interactively with fzf |
| `Right Arrow` | Accept an autosuggestion |

### Aliases

```bash
alias ll='ls -lah --color=auto'
alias la='ls -A'
alias l='ls -CF'

alias cat='batcat --paging=never'
alias grep='grep --color=auto'

alias cls='clear'
alias c='clear'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
```

Use the original `cat` explicitly when required:

```bash
/usr/bin/cat filename
```

Reload Zsh after changing `~/.zshrc`:

```bash
source ~/.zshrc
```

Validate its syntax:

```bash
zsh -n ~/.zshrc
```

---

## Network Management

The NetworkManager applet starts automatically with i3.

Click the network icon in the system tray to manage:

- Ethernet connections
- Wi-Fi connections
- VPN profiles
- Connection settings
- Network status

Restart the applet manually:

```bash
pkill nm-applet
nm-applet &
```

A full logout and login may be required if the i3 system tray does not reappear after restarting i3.

---

## VMware Integration

VMware guest integration is provided by:

```text
open-vm-tools
open-vm-tools-desktop
```

Check the service:

```bash
systemctl status open-vm-tools
```

Clipboard sharing should work between the Windows host and Kali.

File transfers are handled through SSH and WinSCP instead of VMware shared folders.

Start SSH when needed:

```bash
sudo systemctl start ssh
```

Display the Kali IP address:

```bash
ip -br address
```

Stop SSH when it is no longer needed:

```bash
sudo systemctl stop ssh
```

---

## Wordlists

SecLists is installed under:

```text
/usr/share/seclists/
```

Main directories include:

```text
Discovery/
Fuzzing/
Miscellaneous/
Passwords/
Pattern-Matching/
Payloads/
Usernames/
Web-Shells/
```

Example:

```bash
ls /usr/share/seclists/Discovery/Web-Content/
```

---

## Updating the Repository

Review local changes:

```bash
cd ~/.dotfiles
git status
git diff
```

Commit changes:

```bash
git add .
git commit -m "Describe the configuration change"
```

Push changes:

```bash
git push
```

Restore a tracked file to its last committed version:

```bash
git restore path/to/file
```

---

## Validation

Validate all important configurations:

```bash
i3 -C -c ~/.config/i3/config
zsh -n ~/.zshrc
tmux source-file ~/.tmux.conf
bash -n ~/.dotfiles/install.sh
bash -n ~/.dotfiles/bootstrap.sh
```

No output from the Zsh, tmux, or Bash validation commands normally means that no syntax errors were found.

---

## Security

This repository must not contain:

- SSH private keys
- VPN configuration files
- Passwords
- API tokens
- Browser profiles
- Cookies or active sessions
- Burp project files
- Shell history
- Exam files or target information

Search for possible secrets before committing:

```bash
grep -RniE \
'password|passwd|token|secret|api[_-]?key|BEGIN .*PRIVATE KEY' \
~/.dotfiles \
--exclude-dir=.git
```

---

## Design Philosophy

This environment intentionally avoids:

- Desktop animations
- Transparency
- Blur effects
- Heavy compositors
- Large collections of unused plugins
- Fixed workspace layouts
- Unnecessary background services

Every component should improve speed, stability, or usability during penetration-testing work.

---

## tmux Pane Titles

Each tmux pane can display a custom title in its upper border. This is useful for identifying terminals used for tasks such as:

- Nmap scans
- Web enumeration
- Reverse shells
- Listeners
- File transfers
- Local servers

Pane titles are displayed using:

```tmux
set-option -g pane-border-status top
set-option -g pane-border-format " #{pane_title} "
```

### Rename the Current Pane

Press:

```text
Ctrl + A, then T
```

Enter a title such as:

```text
Nmap
Listener
Web Enum
Reverse Shell
HTTP Server
```

Then press `Enter`.

The configured binding is:

```tmux
bind-key t command-prompt -p "Pane title:" "select-pane -T '%%'"
```

A pane can also be renamed directly from the terminal:

```bash
tmux select-pane -T "Nmap"
```

The title is displayed when the tmux window contains multiple panes.

Example layout:

```text
 Nmap                              Listener
────────────────────────────────────────────
 nmap -sC -sV target              nc -lvnp 4444
```

