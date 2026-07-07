-- Elastic Animation Style
hl.curve("elasticIn", { type = "bezier", points = { {0.1, 1.4}, {0.4, 0.8} } })
hl.curve("elasticOut", { type = "bezier", points = { {0.6, 0.2}, {0.9, -0.4} } })
hl.curve("elasticStandard", { type = "bezier", points = { {0.1, 1.2}, {0.9, -0.2} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5, bezier = "elasticStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 4.5, bezier = "elasticIn" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.5,  bezier = "elasticIn", style = "popin 85%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4, bezier = "elasticOut", style = "popin 85%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 3.5, bezier = "elasticIn" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 3.5, bezier = "elasticOut" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.5, bezier = "elasticStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 4.5, bezier = "elasticStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4.5,    bezier = "elasticIn", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 4,  bezier = "elasticOut", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 3, bezier = "elasticIn" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 3, bezier = "elasticOut" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4, bezier = "elasticIn", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4, bezier = "elasticIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 4, bezier = "elasticOut", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    bezier = "elasticStandard" })
