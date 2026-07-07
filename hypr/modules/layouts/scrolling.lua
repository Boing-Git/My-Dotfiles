local vars = require("modules.keybinds_variables")

local MM =  vars.MM
local SM =  vars.SM
local TM =  vars.TM
local QM =  vars.QM

local left = vars.left 
local right = vars.right
local up = vars.up
local down = vars.down

hl.config({
    general = {
        layout = "scrolling"
    },
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        direction = "right",
        focus_fit_method = 1,
        follow_focus = true,
        follow_min_visible = 0.4,
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
        wrap_focus = true,
        wrap_swapcol = true,
    }
})

--------------------------------------------------------------------------------
-- 1. MOVE (Navigate or scroll the layout canvas horizontally)
--------------------------------------------------------------------------------
-- Shift focus or layout view by columns
hl.bind(MM .. " + " .. left, hl.dsp.layout("move -col"))
hl.bind(MM .. " + " .. right, hl.dsp.layout("move +col"))

-- Smooth scroll layout horizontally by relative pixels
hl.bind(MM .. " + " .. SM .. " + " .. left, hl.dsp.layout("move +200"))
hl.bind(MM .. " + " .. SM .. " + " .. right, hl.dsp.layout("move -200"))


--------------------------------------------------------------------------------
-- 2. COLRESIZE (Adjust column widths)
--------------------------------------------------------------------------------
-- Resize explicitly by relative factor
hl.bind(MM .. " + " .. SM .. " + " .. left, hl.dsp.layout("colresize -0.1"))
hl.bind(MM .. " + " .. SM .. " + " .. right, hl.dsp.layout("colresize +0.1"))

-- Cycle through your preconfigured widths (defined in explicit_column_widths)
hl.bind(MM .. " + " .. QM .. " + " .. left, hl.dsp.layout("colresize -conf"))
hl.bind(MM .. " + " .. QM .. " + " .. right, hl.dsp.layout("colresize +conf"))

-- Resize all columns to a uniform width (e.g., 500 pixels)
hl.bind(MM .. " + " .. QM .. " + A", hl.dsp.layout("colresize all 500"))


--------------------------------------------------------------------------------
-- 3. FIT (Adjust windows to fit screen boundaries)
--------------------------------------------------------------------------------
-- Fit active window, visible layout, or expand to use remaining free space
hl.bind(MM .. " + f", hl.dsp.layout("fit active"))
hl.bind(MM .. " + " .. TM .." + f", hl.dsp.layout("fit expand"))
hl.bind(MM .. " + " .. QM .. " + f", hl.dsp.layout("fit visible"))


--------------------------------------------------------------------------------
-- 4. FIT_INTO_VIEW (Force active column into view bounds)
--------------------------------------------------------------------------------
hl.bind(MM .. " + " .. SM .. " + v", hl.dsp.layout("fit_into_view"))


--------------------------------------------------------------------------------
-- 6. PROMOTE (Eject a nested window into its own full column)
--------------------------------------------------------------------------------
hl.bind(MM .. " + p", hl.dsp.layout("promote"))


--------------------------------------------------------------------------------
-- 7. SWAPCOL (Rearrange column ordering)
--------------------------------------------------------------------------------
-- Swap current column placement left or right
hl.bind(MM .. " + " .. TM .. " + " .. left, hl.dsp.layout("swapcol l"))
hl.bind(MM .. " + " .. TM .. " + " .. right, hl.dsp.layout("swapcol r"))


--------------------------------------------------------------------------------
-- 8. INHIBIT_SCROLL (Toggle canvas scrolling lock)
--------------------------------------------------------------------------------
-- Leaving the parameters blank toggles the scroll lock state
hl.bind(MM .. " + i", hl.dsp.layout("inhibit_scroll"))


--------------------------------------------------------------------------------
-- 9. EXPEL (Move window out of current column block into a dedicated column)
--------------------------------------------------------------------------------
hl.bind(MM .. " + e", hl.dsp.layout("expel"))


--------------------------------------------------------------------------------
-- 10. CONSUME (Pull adjacent window into the current focused column block)
--------------------------------------------------------------------------------
hl.bind(MM .. " + " .. SM .. " + C", hl.dsp.layout("consume"))


--------------------------------------------------------------------------------
-- 11. CONSUME_OR_EXPEL (Smart contextual layout consolidation)
--------------------------------------------------------------------------------
-- Expels window if grouped; consumes if isolated in a column
hl.bind(MM .. " + x", hl.dsp.layout("consume_or_expel next"))
hl.bind(MM .. " + " .. TM .. " + x", hl.dsp.layout("consume_or_expel prev"))
