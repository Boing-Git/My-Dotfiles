-- Swift Animation Style
hl.curve("swiftCurve", { type = "bezier", points = { {0.2, 1}, {0.1, 1} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 3, bezier = "swiftCurve" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 2.5, bezier = "swiftCurve" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2.5,  bezier = "swiftCurve", style = "popin 93%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2, bezier = "swiftCurve", style = "popin 93%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2, bezier = "swiftCurve" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2, bezier = "swiftCurve" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 2, bezier = "swiftCurve" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 2.5, bezier = "swiftCurve" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2.5,    bezier = "swiftCurve", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 2,  bezier = "swiftCurve", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 2, bezier = "swiftCurve" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 2, bezier = "swiftCurve" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2.5, bezier = "swiftCurve", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2.5, bezier = "swiftCurve", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2, bezier = "swiftCurve", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 3,    bezier = "swiftCurve" })
