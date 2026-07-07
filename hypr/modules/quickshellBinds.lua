local vars = require("modules.keybinds_variables")
local QuickLauncherKey = vars.QuickLauncherKey
local MM = vars.MM
local SM = vars.SM
local TM = vars.TM

local QsScreenshotKey = vars.QsScreenshotKey
local QsWallpaperKey = vars.QsWallpaperKey
local QsColorSchemeKey = vars.QsColorSchemeKey
local QsControlCenterKey = vars.QsControlCenterKey
local QsPowerMenuKey = vars.QsPowerMenuKey
local QsOverviewKey = vars.QsOverviewKey
local QsEmojiPickerKey = vars.QsEmojiPickerKey
local QsClipboardKey = vars.QsClipboardKey

-- Bind the key to the specific global identifier
hl.bind(MM .. " + " .. (QuickLauncherKey or "D"), hl.dsp.global("quickshell:launcher"), { description = "Launcher" })
hl.bind(MM .. " + " .. TM .. " + " .. QsScreenshotKey, hl.dsp.global("quickshell:screenshot"), { description = "Screenshot" })
hl.bind(MM .. " + " .. SM .. " + " .. QsWallpaperKey, hl.dsp.global("quickshell:wallpaper"), { description = "Wallpaper" })
hl.bind(MM .. " + " .. SM .. " + " .. QsColorSchemeKey, hl.dsp.global("quickshell:color_scheme"), { description = "Color Scheme" })
hl.bind(MM .. " + " .. QsControlCenterKey, hl.dsp.global("quickshell:control_center"), { description = "Control Center" })
hl.bind(MM .. " + " .. TM .. " + " .. QsPowerMenuKey, hl.dsp.global("quickshell:power_menu"), { description = "Power Menu" })
hl.bind(MM .. " + " .. QsOverviewKey, hl.dsp.global("quickshell:overview"), { description = "Overview" })
hl.bind(MM .. " + " .. QsEmojiPickerKey, hl.dsp.global("quickshell:emoji_picker"), { description = "Emoji Picker" })
hl.bind(MM .. " + " .. QsClipboardKey, hl.dsp.global("quickshell:clipboard"), { description = "Clipboard" })