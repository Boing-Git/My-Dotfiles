# 🐚 Quickshell Dotfiles

> A modular, hardware-accelerated desktop shell built on **Quickshell** (QtQuick / QML) featuring dynamic **Material 3 Expressive** theming and fluid animations.

![Quickshell](https://img.shields.io/badge/Shell-Quickshell-8B5CF6?style=flat-square)
![QML](https://img.shields.io/badge/UI-QML-41CD52?style=flat-square)
![Material You](https://img.shields.io/badge/Theming-Material_3-F59E0B?style=flat-square)

This repository contains my highly customized, modular shell configuration. Designed specifically for Hyprland and NixOS, it replaces traditional panels (like Waybar or Eww) with a cohesive, beautifully animated UI powered by QML.

---

## ✨ Features

- **Material 3 Expressive Aesthetics**: Fully unified design system with consistent corner radii, margins, layout padding, and tactile interaction states (hover and press overlays).
- **Dynamic Theming Pipeline**: Colors are extracted directly from your wallpaper and passed system-wide. The `sync_colors.py` script automatically generates QML singletons directly from the system theme engine on the fly.

- **Component Isolation**: Everything is cleanly modularized into separate QML files. No monoliths.
- **Full Shell Experience**: Includes top panels, volume OSDs, full notification daemons, interactive control centers, launcher, wallpaper switchers, and custom Hyprland workspace trackers.

---

## 📂 Architecture & Components

The UI is built leveraging QML for declarative, GPU-accelerated layouts, integrated with JavaScript and Python for dynamic state tracking and system interaction.

### Core Modules

| Component | Description |
|-----------|-------------|
| `shell.qml` | The root component orchestrating global contexts, layers, and module imports. |
| `StatusBar.qml` | The main top bar that hosts the status modules. |
| `TopPills.qml` | The grouped layout container managing the Clock and Workspace modules in distinct "pills". |
| `ControlCenter.qml` | A comprehensive, unified control center for quick settings toggles and media playback. |
| `HyprWorkspaces.qml` | Custom Hyprland workspace switcher with fluid transition states and special workspace support. |
| `Launcher.qml` | System application launcher. |
| `WallpaperSwitcher.qml` | Integrated wallpaper picker connected with the theming engine to shift the entire system palette dynamically. |

### System & Daemon UIs

| Component | Description |
|-----------|-------------|
| `NotificationDaemon.qml` | The main notification server daemon overlay. |
| `NotificationCard.qml` | Standardized UI cards representing individual system notifications. |
| `NotificationData.qml` / `NotificationService.qml` | Backend routing to map freedesktop notification events into QML data models. |
| `ScreenShot.qml` | Native shell interface for capturing desktop snippets. |
| `VolumeOsd.qml` | A minimalist, animated on-screen display for volume adjustments. |

### Utilities & Theming

| Component | Description |
|-----------|-------------|
| `sync_colors.py` | Python script that reads the active scheme and dynamically generates `Variables/Theme.qml`. |
| `unify.py` | Automation script for standardizing UI and geometry values across the codebase. |
| `Variables/` | Directory containing the single source of truth for design tokens, including `Theme.qml` which acts as the generated color singleton. |


---

## 🎨 Dynamic Theming & Customization

The aesthetics of this shell are governed by an overarching Material 3 Expressive design philosophy. 
Instead of hardcoding colors, the shell relies on the `sync_colors.py` script to map your system-wide color palette into QML properties. 

When you change your wallpaper, run the script to propagate changes directly into the shell:

```bash
python ~/.config/quickshell/sync_colors.py
```

This reads your currently active scheme from your Hyprland configuration (e.g. `material-you.lua` from `~/.config/hypr/scheme/`) and injects a live `Theme.qml` Singleton into Quickshell.

---

## 🛠️ Installation & Usage

This shell is intended to be used alongside my broader NixOS configuration, though it can be run standalone if dependencies are met.

**Prerequisites:**
- [Quickshell](https://outfoxxed.me/quickshell/)
- Qt6 (QtQml, QtQuick, QtWaylandClient) + Qt5Compat

1. **Clone the configuration** into your config directory:
   ```bash
   git clone https://github.com/Boing-Git/Quickshell-Dotfiles ~/.config/quickshell
   ```
2. **Sync your colors** using the Python script (assuming you have your color scheme configured properly in Hyprland).
   ```bash
   python ~/.config/quickshell/sync_colors.py
   ```
3. **Launch the shell:**
   ```bash
   quickshell -c ~/.config/quickshell/shell.qml
   ```

---
*Developed with a focus on cohesive design, performant transitions, and expressive UI/UX.*
