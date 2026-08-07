<div align="center">

# Kali OSCP Workstation

**A minimal, fast, and reproducible Kali Linux environment for PEN-200 and the OSCP exam.**

`i3` · `kitty` · `tmux` · `rofi` · `zsh` — themed with **nightgrid**

</div>

---

## What this is

A keyboard-driven Kali setup built around a single idea: nothing on screen should cost
you time. Windows tile, sessions persist, and the only numbers in the status bar are the
ones you actually need during an engagement — your tunnel address and your current target.

The theme is **nightgrid**, the same black-and-green palette as
[nightgrid.nvim](https://github.com/MarcussanMG/nightgrid.nvim), so the editor, the shell,
the launcher and the window manager all agree with each other.

### Palette

| Token | Hex | Used for |
| --- | --- | --- |
| `bg` | `#05070a` | Terminal and bar background |
| `bg-panel` | `#0d1410` | Input fields, inactive elements |
| `green` | `#22c55e` | Focus, prompts, active borders |
| `green-hi` | `#4ade80` | Selection, tunnel address |
| `green-dim` | `#166534` | Rails, separators, icons |
| `fg` | `#d1fae5` | Body text |
| `fg-dim` | `#86efac` | Secondary text |
| `gray` | `#4b5e54` | Disabled, comments, autosuggestions |
| `yellow` | `#fbbf24` | Current target, warnings |
| `red` | `#f87171` | Errors, urgent windows, root prompt |

---

## Components

| Piece | What it does |
| --- | --- |
| **i3** | Tiling window manager. Gaps, rounded focus borders, no title bars. |
| **picom** | Compositor. Fast fades and soft shadows — killable with one key. |
| **kitty** | Terminal. GPU-accelerated, 50k lines of scrollback. |
| **i3blocks** | Status bar. tun0, target, local IP, CPU, RAM, volume, clock. |
| **rofi** | Launcher and power menu. |
| **tmux** | Persistent sessions and named panes. |
| **zsh** | Shell, with a two-line prompt that carries your tunnel IP. |
| **NetworkManager applet** | Wi-Fi and VPN from the tray. |
| **batcat / fzf / zoxide / eza** | Syntax-highlighted `cat`, fuzzy history, faster `cd`, better `ls`. |
| **JetBrainsMono Nerd Font** | Terminal font and every icon in the bar. |

---

## Installation

Clone the repository:

```bash
git clone <REPOSITORY_URL> ~/.dotfiles
cd ~/.dotfiles
```

Install packages and apply the configuration:

```bash
./bootstrap.sh
```

Then:

1. Log out.
2. Select the **i3** session at the login screen.
3. Log back in.

### Apply the configuration only

When the packages are already installed:

```bash
cd ~/.dotfiles
./install.sh
```

`install.sh` symlinks everything from this repository into your home directory. It is
idempotent — re-running it is harmless. Any real file it would overwrite is renamed to
`<file>.backup.<timestamp>` first.

---

## Changing the wallpaper

Both the desktop background (`i3/config`) and the lock screen (`bin/lockscreen`) read the
same file:

```
~/.dotfiles/wallpapers/nightgrid.png
```

To swap it, replace that file — keep the exact filename `nightgrid.png` so nothing else
needs editing:

```bash
cp /path/to/your-image.jpg ~/.dotfiles/wallpapers/nightgrid.png
```

If your image isn't already a PNG, convert it first:

```bash
convert /path/to/your-image.jpg ~/.dotfiles/wallpapers/nightgrid.png
```

Then apply it:

```bash
feh --bg-fill ~/.dotfiles/wallpapers/nightgrid.png   # desktop, immediately
rm -f ~/.cache/i3lock/blurred.png                    # force the lock screen to re-render
```

Re-running `./install.sh` also re-renders the cached lock screen automatically, since it
regenerates `~/.cache/i3lock/blurred.png` whenever the source wallpaper is newer than the
cached copy.

A higher-resolution source (matching or exceeding your monitor's resolution) looks best —
`feh --bg-fill` crops to fit rather than stretching, and the lock screen blur is generated
at your screen's native resolution.

---

## Repository structure

```
~/.dotfiles/
├── bin/
│   ├── lockscreen          i3lock with a blurred wallpaper
│   ├── powermenu           rofi power menu
│   ├── screenshot          region capture to ~/screenshots and the clipboard
│   ├── set-target          prompt for the target shown in the bar
│   ├── start-picom         compositor launcher with an xrender fallback
│   └── toggle-effects      exam mode on/off
├── i3/
│   └── config
├── i3blocks/
│   ├── config
│   └── scripts/            clock  cpu  mem  net  target  volume  vpn
├── kitty/
│   ├── kitty.conf
│   └── nightgrid.conf      colour scheme, included by kitty.conf
├── picom/
│   └── picom.conf
├── rofi/
│   ├── config.rasi
│   ├── theme.rasi
│   └── powermenu.rasi
├── tmux/
│   └── tmux.conf
├── zsh/
│   └── .zshrc
├── wallpapers/
│   └── nightgrid.png
├── firefox/
│   └── policies.json       force-installs FoxyProxy and Wappalyzer
├── bootstrap.sh
├── install.sh
├── .gitignore
└── README.md
```

---

# Keyboard shortcuts

> Every binding from the previous configuration works exactly as it did.
> The three additions are listed separately at the end of the i3 section.

## i3

The `Mod` key is the **Super/Windows key**.

### Applications

| Shortcut | Action |
| --- | --- |
| `Super + Enter` | Open Kitty |
| `Super + D` | Open the Rofi application launcher |
| `Super + Shift + F` | Open Firefox |
| `Super + Shift + B` | Open Burp Suite |
| `Super + Shift + X` | Open the Rofi power menu |
| `Super + Shift + L` | Lock the screen |

### Window focus

| Shortcut | Action |
| --- | --- |
| `Super + Left` | Focus the window on the left |
| `Super + Right` | Focus the window on the right |
| `Super + Up` | Focus the window above |
| `Super + Down` | Focus the window below |
| `Super + A` | Focus the parent container |
| `Super + Space` | Switch focus between tiling and floating |

### Move windows

| Shortcut | Action |
| --- | --- |
| `Super + Shift + Left` | Move the current window left |
| `Super + Shift + Right` | Move the current window right |
| `Super + Shift + Up` | Move the current window up |
| `Super + Shift + Down` | Move the current window down |
| `Super + Shift + Space` | Toggle floating |

### Workspaces

| Shortcut | Action |
| --- | --- |
| `Super + 1–9` | Switch to workspace 1–9 |
| `Super + Shift + 1–9` | Move the current window to workspace 1–9 |

Workspaces are intentionally not assigned fixed names or applications. If you want icons
in the bar, uncomment the second `$ws` block in `i3/config`.

### Window management

| Shortcut | Action |
| --- | --- |
| `Super + Shift + Q` | Close the focused window |
| `Super + H` | Set the next split to horizontal |
| `Super + V` | Set the next split to vertical |
| `Super + F` | Toggle fullscreen |
| `Super + S` | Stacking layout |
| `Super + W` | Tabbed layout |
| `Super + E` | Toggle split layout |
| `Super + R` | Enter resize mode |
| `Escape` | Exit resize mode |
| `Super + Ctrl + Shift + arrows` | Resize without entering resize mode |

In resize mode: `j` `k` `l` `;` or the arrow keys resize; `Enter`, `Escape` or
`Super + R` leaves.

### i3 session

| Shortcut | Action |
| --- | --- |
| `Super + Shift + C` | Reload the configuration |
| `Super + Shift + R` | Restart i3 in place |
| `Super + Shift + E` | Exit the i3 session |

Validate the configuration before reloading it:

```bash
i3 -C -c ~/.config/i3/config
```

Reload it from a terminal:

```bash
export I3SOCK="$(i3 --get-socketpath)"
i3-msg reload
```

### New in this version

| Shortcut | Action |
| --- | --- |
| `Super + Shift + P` | Toggle **exam mode** — kills the compositor and makes kitty fully opaque |
| `Super + Shift + S` | Region screenshot to `~/screenshots`, also copied to the clipboard |
| `Super + Shift + T` | Set the engagement target shown in the bar |

Exam mode is sticky: once enabled, the compositor stays off across i3 restarts and
reboots until you press `Super + Shift + P` again.

---

## tmux

The prefix is:

```
Ctrl + A
```

Press `Ctrl + A`, release it, then press the second key.

### Panes

| Shortcut | Action |
| --- | --- |
| `Ctrl + A`, then `/` | Split into left and right panes |
| `Ctrl + A`, then `-` | Split into top and bottom panes |
| `Ctrl + A`, then `Left` | Focus the pane on the left |
| `Ctrl + A`, then `Right` | Focus the pane on the right |
| `Ctrl + A`, then `Up` | Focus the pane above |
| `Ctrl + A`, then `Down` | Focus the pane below |
| `Ctrl + A`, then `T` | Rename the current pane |
| `exit` | Close the current pane |

New splits open in the current pane's directory.

### Sessions and windows

| Shortcut | Action |
| --- | --- |
| `Ctrl + A`, then `C` | Create a new tmux window |
| `Ctrl + A`, then `N` | Move to the next tmux window |
| `Ctrl + A`, then `P` | Move to the previous tmux window |
| `Ctrl + A`, then `D` | Detach from the current session |
| `Ctrl + A`, then `R` | Reload `~/.tmux.conf` |
| `Ctrl + A`, then `?` | Display all tmux shortcuts |
| `Ctrl + A`, then `S` | **New** — show or hide the status line |

Useful commands:

```bash
tmux ls                              # list sessions
tmux attach-session -t main          # attach to the persistent session
tmux display-message -p '#S'         # current session name
tmux source-file ~/.tmux.conf        # reload manually
```

The status line is off by default to keep the terminal clean. The `main` session is
created or restored automatically when Kitty starts. It survives closing Kitty, but not
rebooting Kali.

### Pane titles

Each pane shows its title in the border, which is how you keep track of what is running
where:

```
 1 Nmap                             2 Listener
──────────────────────────────────────────────────
 nmap -sC -sV target                nc -lvnp 4444
```

Press `Ctrl + A`, then `T`, type a title, press `Enter`. Or from the shell:

```bash
tmux select-pane -T "Nmap"
```

The active pane's title is highlighted in green.

---

## Kitty

| Shortcut | Action |
| --- | --- |
| `Ctrl + Shift + C` | Copy selected text |
| `Ctrl + Shift + V` | Paste text |
| `Ctrl + Shift + F` | Search terminal output |
| `Shift + mouse selection` | Select text through tmux mouse capture |

Kitty is configured with the nightgrid palette, JetBrainsMono Nerd Font, 50 000 lines of
scrollback, no audio bell, no cursor blink, no close confirmation, and 95 % opacity.
`Super + Shift + P` sets opacity back to 100 % for exam conditions. To make that
permanent, set `background_opacity 1.0` in `kitty/kitty.conf`.

After editing the configuration, close and reopen Kitty.

---

## Rofi

| Shortcut | Action |
| --- | --- |
| `Super + D` | Open the application launcher |
| `Super + Shift + X` | Open the power menu |
| `Arrow keys` | Move through results |
| `Enter` | Select an item |
| `Escape` | Close Rofi |

Matching is fuzzy and case-smart. The power menu offers shutdown, reboot, logout and
lock as four icons. Run it manually with:

```bash
~/.local/bin/powermenu
```

---

## Zsh

### History and completion

| Shortcut | Action |
| --- | --- |
| `Ctrl + R` | Search command history interactively with fzf |
| `Right Arrow` | Accept an autosuggestion |
| `Ctrl + P` | Toggle between the one-line and two-line prompt |
| `Ctrl + U` | Delete to the start of the line |
| `Shift + Tab` | Undo the last edit |

History is shared across panes and holds 100 000 entries.

### The prompt

```
┌─[marc㉿kali]─[~/engagements/box]─[󰘬 main]─[󰦝 10.10.14.7]─[ 10.10.11.42]
└─❯
```

Segments appear only when they apply: the git branch when you are in a repository, the
tunnel address when `tun0` is up, the target when you have set one. The tunnel lookup is
cached for ten seconds, so the prompt never costs you a subprocess per keystroke.

### Aliases

```bash
ls        eza --icons --group-directories-first
ll        eza -lah --icons --git
la        eza -a --icons
tree      eza --tree --level=2
cat       batcat --paging=never
grep      grep --color=auto
cls / c   clear
.. ... ....   cd up one, two, three levels
```

Engagement helpers:

```bash
tun       show the tun0 address
myip      show every non-loopback address
ports     ss -tulpn
serve     python3 -m http.server 80
```

Use the real `cat` when you need it:

```bash
/usr/bin/cat filename
```

### Target tracking

Set the box you are working on once and it shows up in the status bar, in the prompt, and
in `$T`:

```bash
target 10.10.11.42     # set it
target                 # print it
ping -c1 $T            # use it
```

`Super + Shift + T` does the same thing through a Rofi prompt.

### Scaffolding a box

```bash
mkt oscp-box
```

Creates and enters `~/engagements/oscp-box/` with `nmap/`, `web/`, `loot/`, `exploits/`
and a `notes.md` skeleton.

### Reloading

```bash
source ~/.zshrc        # apply changes
zsh -n ~/.zshrc        # check syntax
```

---

## Status bar

Left to right:

| Block | Shows |
| --- | --- |
|  | Current target — hidden until you set one |
|  | `tun0` address, or `vpn down` |
| 󰈀 | Address of the first physical interface |
|  | CPU usage — amber above 60 %, red above 90 % |
|  | Memory in use |
|  | Volume, or `muted` |
|  | Date and time |

The tray sits at the right end and holds `nm-applet`.

To add a block, drop an executable in `i3blocks/scripts/` and add a matching section to
`i3blocks/config` — the `command` line resolves `$BLOCK_NAME` to the filename.

---

## Network management

The NetworkManager applet starts with i3. Click the tray icon to manage Ethernet, Wi-Fi,
VPN profiles and connection settings.

Restart it manually:

```bash
pkill nm-applet
nm-applet &
```

If the tray does not reappear after restarting i3, log out and back in.

---

## VMware integration

Guest integration comes from:

```
open-vm-tools
open-vm-tools-desktop
```

Check the service:

```bash
systemctl status open-vm-tools
```

Clipboard sharing works between the Windows host and Kali. File transfers go through SSH
and WinSCP rather than shared folders:

```bash
sudo systemctl start ssh     # start it when you need it
ip -br address               # find your address
sudo systemctl stop ssh      # stop it when you are done
```

### If picom will not start

The compositor defaults to the `glx` backend, which needs 3D acceleration enabled in the
VM's display settings. Without it, picom exits silently and `start-picom` falls back to
`xrender` automatically. To force the fallback permanently, set `backend = "xrender"` in
`picom/picom.conf`.

If the VM feels sluggish at all, press `Super + Shift + P`. Nothing else depends on the
compositor.

---

## Wordlists

SecLists installs under:

```
/usr/share/seclists/
```

```
Discovery/  Fuzzing/  Miscellaneous/  Passwords/
Pattern-Matching/  Payloads/  Usernames/  Web-Shells/
```

```bash
ls /usr/share/seclists/Discovery/Web-Content/
```

---

## Updating the repository

```bash
cd ~/.dotfiles
git status
git diff

git add .
git commit -m "Describe the configuration change"
git push
```

Restore a tracked file to its last committed version:

```bash
git restore path/to/file
```

Because everything in `~/.config` is a symlink into this repository, editing the live
config *is* editing the repository. There is no copy step.

---

## Validation

```bash
i3 -C -c ~/.config/i3/config
zsh -n ~/.zshrc
tmux source-file ~/.tmux.conf
bash -n ~/.dotfiles/install.sh
bash -n ~/.dotfiles/bootstrap.sh
for f in ~/.dotfiles/bin/* ~/.dotfiles/i3blocks/scripts/*; do bash -n "$f"; done
```

No output from the zsh, tmux or bash checks means no syntax errors.

---

## Security

This repository must never contain:

- SSH private keys
- VPN configuration files
- Passwords or API tokens
- Browser profiles, cookies or active sessions
- Burp project files
- Shell history
- Exam files or target information

`.gitignore` already blocks the obvious extensions. Check anyway before every commit:

```bash
grep -RniE \
  'password|passwd|token|secret|api[_-]?key|BEGIN .*PRIVATE KEY' \
  ~/.dotfiles --exclude-dir=.git
```

Note that the target you set with `target` is stored in `~/.cache/oscp-target`, outside
this repository, so it is never committed.

---

## Design philosophy

Every component earns its place by improving speed, stability or usability during
penetration-testing work. What that rules out:

- Blur, animation frameworks and heavyweight compositors
- Plugin collections you do not use
- Workspaces tied to fixed applications
- Background services that are not doing anything

What it allows, and why:

- **A compositor.** Rounded corners and a 110 ms fade cost a few milliseconds and make
  the whole thing legible at a glance. One keystroke removes them entirely.
- **95 % terminal opacity.** Enough to see the grid behind, not enough to hurt a
  screenshot. Also one keystroke away from opaque.
- **A slightly dimmed inactive window.** Firefox, Burp, Wireshark and anything fullscreen
  are excluded, so nothing you read output from is ever dimmed.

---

## Changes from the previous version

| Area | Change |
| --- | --- |
| Theme | nightgrid black/green everywhere, replacing the Tokyo Night / Catppuccin mix |
| Bar | Six new blocks: target, tun0, local IP, CPU, memory, volume |
| Compositor | picom added, with `Super + Shift + P` to remove it instantly |
| Prompt | Two-line prompt carrying git branch, tun0 address and current target |
| tmux | Pane borders and titles themed; optional status line on `Ctrl + A`, `S` |
| kitty | nightgrid palette split into its own file; remote control enabled for the opacity toggle |
| rofi | Fuzzy matching, icons, rounded theme, four-icon power menu |
| Scripts | `screenshot`, `set-target`, `toggle-effects`, `start-picom` added |
| `bootstrap.sh` | Fixed a line-continuation bug that silently skipped the package list; packages now install individually so one missing package cannot abort the run; Nerd Font install added |
| `install.sh` | Idempotent, backs up only real files, pre-renders the lock screen |
| Wallpaper | Generated `nightgrid.png` at 2560×1440 |

**No existing keyboard shortcut changed.** The only behavioural change outside the
additions above is `focus_follows_mouse no`, so the mouse passing over a window no longer
steals focus from the one you are typing in.
