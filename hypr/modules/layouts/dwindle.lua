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
        layout = "dwindle",
    },
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

--------------------------------------------------------------------------------
-- ## Dwindle Layout Exclusive Keybinds (Grid Navigation & Manual Resizing)
--------------------------------------------------------------------------------

-- 1. Bracket Focus Navigation
for i = 1, 2 do
    local arrowkey = { "BracketLeft", "BracketRight" }
    local focusdir = { "l", "r" }
    hl.bind(MM .. " + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end

-- 2. Directional Focus Navigation (Vim Keys + Down Arrow)
for i = 1, 4 do
    local arrowkey = { left , right , up , down }
    local focusdir = { "l", "r" , "u", "d"}
    hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end

-- 3. Directional Window Moving (Vim Keys)
for i = 1, 4 do
    local arrowkey = { left , right , up , down }
    local focusdir = { "l", "r" , "u", "d"}
    hl.bind(MM .. " + " .. SM .. " + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }))
end

-------------------------------------------------------------------------
-- Move workspace only the view with arrow keys or vim keys relatively --
-------------------------------------------------------------------------

hl.bind(QM .. " + " .. MM .. " + " .. left, hl.dsp.focus({ workspace ="r-1" }))
hl.bind(QM .. " + " .. MM .. " + " .. right, hl.dsp.focus({ workspace ="r+1" }))

-- 4. Split Ratio Window Resizing
-- Shrink window width (Minus)
hl.bind(MM .. " + " .. TM .. " + " .. right, hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })

-- Grow window width (MM + TM + h)
hl.bind(MM .. " + " .. TM .. "+" .. left, hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
