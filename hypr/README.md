# Boing's Hyprland Lua Dotfiles

Welcome to my highly modular and dynamic Hyprland configuration, written entirely in Lua! 

This repository leverages Lua to provide a programmable, modular, and deeply customizable window manager experience. It includes a dynamic configuration manager, rich animation profiles, custom keybinds, and integrated theming support.

## 🌟 Key Features

### 🛠️ Lua-Based Configuration
Instead of a traditional `hyprland.conf`, this setup is built entirely using Lua (`hyprland.lua`). It splits the configuration into clean, reusable modules located in the `modules/` directory:
- **`variables.lua`**: The central hub for all configuration variables (modifiers, layouts, animations, and apps).
- **`animations.lua`**: Extensive, dynamic animation profiles.
- **`binds.lua`**: Deeply programmable keybindings with directional variables, workspace loops, and system gestures.
- **`autostart.lua`, `winrules.lua`, `input.lua`**: Modular management of startup apps, window rules, and inputs.
- **Layouts**: Modular layout definitions (`dwindle.lua`, `master.lua`, `scrolling.lua`).

### 🎨 Integrated Theming & Color Schemes
A dedicated `scheme/` directory provides pre-configured color schemes as Lua tables. Supported schemes include:
- Material You
- Catppuccin (Mocha)
- Dracula
- Gruvbox (Dark & Light)
- Nord
- OneDark
- Rosé Pine
- Solarized (Dark & Light)
- Tokyo Night

A built-in `utils.lua` handles hex to RGBA conversion, ensuring smooth integrations with Hyprland's internal color handling.

### ⚙️ Dynamic Configuration Manager (`manager.py`)
This repository comes with a Python-based configuration manager (`manager.py`) that parses and updates `variables.lua` dynamically on the fly. 

**Features:**
- Safely update variables like layouts, animation styles, or color schemes directly from the command line.
- Automatically triggers color syncing for Quickshell (`~/.config/quickshell/sync_colors.py`) whenever changes are made.

**Usage Example:**
```bash
./manager.py --ColorScheme dracula --AnimateStyle snappy --groupBar false
```

### ✨ Advanced Animations
Switch between 15 meticulously tuned animation styles simply by changing the `AnimateStyle` variable.
Styles include: `Expressive` (Material 3 default), `Springy`, `Jelly`, `FlyingCards`, `Snappy`, `Cinematic`, `Fluid`, `Playful`, `Elegant`, `Minimal`, `Aggressive`, `Elastic`, `Swift`, `Relaxed`, and `None`.

### ⌨️ Powerful Keybindings
Keybindings are configured dynamically based on modifier variables (`MM`, `SM`, `TM`, `QM`). Highlights include:
- Native Vim-style directional bindings (`h`, `j`, `k`, `l`) mapped to a `vimkeys` boolean.
- Complex scripting for workspace loops and special window actions executed seamlessly via pure Lua.
- Advanced zooming and resizing macros.
- Media controls, brightness, and native application execution scripts (e.g., `app2unit`).

## 📁 Repository Structure

```text
~/.config/hypr/
├── .luarc.json          # Lua LSP configuration
├── hyprland.lua         # Main entry point for the Hyprland configuration
├── manager.py           # CLI tool to dynamically modify settings
├── utils.lua            # Lua utilities (e.g., hex-to-rgba converter)
├── modules/             # Configuration modules
│   ├── variables.lua    # Global customizable settings
│   ├── animations/      # Animation profiles
│   ├── animations.lua   # Animation loader
│   ├── autostart.lua    # Startup execution logic
│   ├── binds.lua        # Keybinding logic
│   ├── deco.lua         # Window decorations
│   ├── dwindle.lua      # Layout: Dwindle
│   ├── master.lua       # Layout: Master
│   ├── scrolling.lua    # Layout: Scrolling
│   ├── winrules.lua     # Window Rules
│   ├── input.lua        # Input devices
│   ├── env.lua          # Environment variables
│   ├── general.lua      # General settings
│   ├── misc.lua         # Miscellaneous tweaks
│   └── quickshellBinds.lua # Quickshell interactions
└── scheme/              # Color Scheme lua tables
    ├── material-you.lua
    ├── dracula.lua
    ├── catppuccin-mocha.lua
    └── ...
```

## 🚀 Getting Started

1. **Clone the repository** to `~/.config/hypr`.
2. **Review `modules/variables.lua`**: Set your preferred terminal (`Term`), browser (`Browser`), modifier keys (`MM`, `SM`), and apps.
3. **Change Themes and Animations** either manually in `variables.lua` or by running `./manager.py --help` to see available configuration flags.
4. Restart or launch Hyprland!

## 📜 License
See `LICENSE` for more information.
