-- Minimal Animation Style
hl.curve("minimalCurve", { type = "bezier", points = { {0.4, 0}, {0.2, 1} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 2, bezier = "minimalCurve" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 2, bezier = "minimalCurve" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2,  bezier = "minimalCurve", style = "popin 98%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.5, bezier = "minimalCurve", style = "popin 98%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.5, bezier = "minimalCurve" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.5, bezier = "minimalCurve" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 1.5, bezier = "minimalCurve" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 2, bezier = "minimalCurve" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2,    bezier = "minimalCurve", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "minimalCurve", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.5, bezier = "minimalCurve" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.5, bezier = "minimalCurve" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2, bezier = "minimalCurve", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2, bezier = "minimalCurve", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.5, bezier = "minimalCurve", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 2,    bezier = "minimalCurve" })
