-- Snappy Animation Style
hl.curve("snappyIn", { type = "bezier", points = { {0.1, 1}, {0, 1} } })
hl.curve("snappyOut", { type = "bezier", points = { {1, 0}, {0.9, 0} } })
hl.curve("snappyStandard", { type = "bezier", points = { {0.2, 0.9}, {0.1, 1} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 3, bezier = "snappyStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 2.5, bezier = "snappyIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2,  bezier = "snappyIn", style = "popin 90%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.5, bezier = "snappyOut", style = "popin 90%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.5, bezier = "snappyIn" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.5, bezier = "snappyOut" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 2, bezier = "snappyStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 2.5, bezier = "snappyStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2,    bezier = "snappyIn", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "snappyOut", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.5, bezier = "snappyIn" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.5, bezier = "snappyOut" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2, bezier = "snappyIn", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.5, bezier = "snappyIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.5, bezier = "snappyOut", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 3,    bezier = "snappyStandard" })
