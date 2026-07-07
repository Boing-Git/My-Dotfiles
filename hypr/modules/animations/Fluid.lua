-- Fluid Animation Style
hl.curve("fluidIn", { type = "bezier", points = { {0.4, 0}, {0.2, 1} } })
hl.curve("fluidOut", { type = "bezier", points = { {0.4, 0}, {1, 1} } })
hl.curve("fluidStandard", { type = "bezier", points = { {0.4, 0}, {0.4, 1} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5, bezier = "fluidStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 4, bezier = "fluidIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4,  bezier = "fluidIn", style = "popin 90%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 3.5, bezier = "fluidOut", style = "popin 90%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 3, bezier = "fluidIn" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 3, bezier = "fluidOut" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.5, bezier = "fluidStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 4, bezier = "fluidStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "fluidIn", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 3.5,  bezier = "fluidOut", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 3, bezier = "fluidIn" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 3, bezier = "fluidOut" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4, bezier = "fluidIn", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4, bezier = "fluidIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 3.5, bezier = "fluidOut", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    bezier = "fluidStandard" })
