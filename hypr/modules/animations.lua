local vars = require("modules.variables")

local AnimateStyle = vars.AnimateStyle

local style_map = {
    expressive = "Expressive",
    spring = "Spring",
    springy = "Spring",
    jelly = "Jelly",
    flyingcards = "FlyingCards",
    snappy = "Snappy",
    cinematic = "Cinematic",
    minimal = "Minimal",
    fluid = "Fluid",
    aggressive = "Aggressive",
    elegant = "Elegant",
    playful = "Playful",
    elastic = "Elastic",
    swift = "Swift",
    relaxed = "Relaxed",
    slipstream = "slipStream",
    standard = "Standard",
    fluent = "Fluent",
    none = "None"
}

local style_lower = AnimateStyle and string.lower(AnimateStyle) or "expressive"
local module_name = style_map[style_lower] or "Expressive"

require("modules.animations." .. module_name)

animations = {
    enabled = true,
}