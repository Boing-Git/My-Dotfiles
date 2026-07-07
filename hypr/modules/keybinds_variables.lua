----------------------------------------------------------------------------------------
--- These variables define keybinds and modifiers to be used in the hypr config --------
----------------------------------------------------------------------------------------

local kvars = {
    MM = "SUPER", -- Set the Main modifier --
    SM = "ALT", -- Set the Second modifier --
    TM = "SHIFT", -- Set the Thirth modifier --
    QM = "CTRL", -- Set the Fourth modifier --

    TermKey = "T", -- Set the key to open Terminal --
    BrowserKey = "W", -- Set the key to open browser --
    EditorKey = "X", -- Set the key to open code editor -
    FilesKey = "E", -- Set the key to open file explorer --
    QuickLauncherKey = "D", -- Set the key to open launcher --

    vimkeys = true, -- Enable vim keys for navigation --

    --Set Wallpaper switch keys--
    WallSwitch = "W",

    -- Window Actions --
    CloseKey = "Q", -- Set the key to close active window --
    FloatKey = "Space", -- Set the key to float active window --
    FullscreenKey = "F", -- Set the key to toggle fullscreen --
    CenterWindowKey = "Backslash", -- Set the key to center active window --
    PinKey = "P", -- Set the key to pin active window --
    PipKey = "P", -- Set the key to toggle picture-in-picture --

    -- Group Actions --
    GroupToggleKey = "G", -- Set the key to toggle window group --
    GroupTabKey = "Tab", -- Set the key to cycle group tabs --

    -- Special Workspaces --
    MusicWorkspaceKey = "M", -- Set the key to open music workspace --
    ScratchboardKey = "S", -- Set the key to open scratchboard --
    SysInfoWorkspaceKey = "Escape", -- Set the key to open sysinfo workspace --

    -- Utilities --
    ColorPickerKey = "C", -- Set the key to open color picker --
    ScreenshotKey = "S", -- Set the key to take a screenshot --

    -- Quickshell Binds --
    QsScreenshotKey = "S", -- Set the key to open Quickshell screenshot --
    QsWallpaperKey = "W", -- Set the key to open Quickshell wallpaper menu --
    QsColorSchemeKey = "T", -- Set the key to open Quickshell color scheme menu --
    QsControlCenterKey = "C", -- Set the key to open Quickshell control center --
    QsPowerMenuKey = "P", -- Set the key to open Quickshell power menu --
    QsOverviewKey = "TAB", -- Set the key to open Quickshell overview --
    QsEmojiPickerKey = "comma", -- Set the key to open Quickshell emoji picker --
    QsClipboardKey = "V", -- Set the key to open Quickshell clipboard --

    -- Media / System Controls --
    ShellRestartKey = "R", -- Set the key to restart the shell --
    SuspendKey = "L", -- Set the key to suspend system --
    ZoomResetKey = "Z", -- Set the key to reset zoom --
    MediaPlayPauseKey = "Space", -- Set the key to play/pause media --
    MediaNextKey = "Equal", -- Set the key to play next media --
    MediaPrevKey = "Minus", -- Set the key to play previous media --
    VolumeMuteKey = "M" -- Set the key to toggle volume mute --
}

------------------------------------------------------------
-- Dynamic Directional Key Selection And Dont Modify These--
------------------------------------------------------------

kvars.left  = kvars.vimkeys and "h" or "left"
kvars.right = kvars.vimkeys and "l" or "right"
kvars.up    = kvars.vimkeys and "k" or "up"
kvars.down  = kvars.vimkeys and "j" or "down"

return kvars
