local vars = require("modules.keybinds_variables")

local MM = vars.MM
local SM = vars.SM
local TM = vars.TM
local QM = vars.QM

local left = vars.left 
local right = vars.right
local up = vars.up
local down = vars.down

hl.config({
    general = {
        layout = "master",
    },
    master = {
        allow_small_split = false,
        special_scale_factor = 1.0,
        mfact = 0.55,
        new_status = "slave",
        new_on_top = false,
        new_on_active = "none",
        orientation = "left",
        slave_count_for_center_master = 2,
        center_master_fallback = "left",
        smart_resizing = true,
        drop_at_cursor = true,
        always_keep_position = false,
    }
})
--------------------------------------------------------------------------------
-- ## Focus & Navigation (Vim: j/k)
--------------------------------------------------------------------------------
-- Cycle focus down/up the stack
hl.bind(MM .. " + " .. up, hl.dsp.layout("cycleprev loop"))
hl.bind(MM .. " + " .. down, hl.dsp.layout("cyclenext loop"))

-- Focus the master window directly
hl.bind(MM .. " + m", hl.dsp.layout("focusmaster auto"))


--------------------------------------------------------------------------------
-- ## Window Swapping (Vim: TM + j/k)
--------------------------------------------------------------------------------
-- Swap the focused window down/up the stack
hl.bind(MM .. " + " .. TM .. " + " .. up, hl.dsp.layout("swapprev loop"))
hl.bind(MM .. " + " .. TM .. " + " .. down, hl.dsp.layout("swapnext loop"))

-- Swap current active window with the master window
hl.bind(MM .. " + Return", hl.dsp.layout("swapwithmaster master"))


--------------------------------------------------------------------------------
-- ## Layout Resizing (Vim: h/l)
--------------------------------------------------------------------------------
-- Decrease / Increase the master split ratio (mfact)
hl.bind(MM .. " + " .. left, hl.dsp.layout("mfact -0.05"))
hl.bind(MM .. " + " .. right, hl.dsp.layout("mfact +0.05"))
-- Alternatively, set to an exact value (e.g., reset to exactly 50%)
hl.bind(MM .. " + " .. TM .. " + " .. left, hl.dsp.layout("mfact exact 0.50"))


--------------------------------------------------------------------------------
-- ## Stack Rotation (Rolling)
--------------------------------------------------------------------------------
-- Rotate windows through the master position while keeping focus on master
hl.bind(MM .. " + r", hl.dsp.layout("rollnext"))
hl.bind(MM .. " + " .. TM .. " + r", hl.dsp.layout("rollprev"))


--------------------------------------------------------------------------------
-- ## Master Capacity Limits
--------------------------------------------------------------------------------
-- Increase or decrease the number of allowed master windows
hl.bind(MM .. " + i", hl.dsp.layout("addmaster"))       -- 'i' for insert
hl.bind(MM .. " + d", hl.dsp.layout("removemaster"))    -- 'd' for delete


--------------------------------------------------------------------------------
-- ## Orientation Cycling
--------------------------------------------------------------------------------
-- Cycle the master area orientation (Left -> Top -> Right -> Bottom -> Center)
hl.bind(MM .. " + o", hl.dsp.layout("orientationnext"))
hl.bind(MM .. " + " .. TM .. " + o", hl.dsp.layout("orientationprev"))

-- Snap directly to specific orientations
hl.bind(MM .. " + c", hl.dsp.layout("orientationcenter"))
hl.bind(MM .. " + " .. left, hl.dsp.layout("orientationleft"))
hl.bind(MM .. " + " .. up, hl.dsp.layout("orientationtop"))
