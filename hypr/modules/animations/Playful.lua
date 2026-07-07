-- Playful Animation Style
hl.curve("playfulOvershoot", { type = "bezier", points = { {0.3, 1.2}, {0.5, 1} } })
hl.curve("playfulAnticipate", { type = "bezier", points = { {0.5, 0}, {0.7, -0.2} } })
hl.curve("playfulStandard", { type = "bezier", points = { {0.3, 1.2}, {0.7, -0.2} } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 4, bezier = "playfulStandard" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 4, bezier = "playfulOvershoot" }) 
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4,  bezier = "playfulOvershoot", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4, bezier = "playfulAnticipate", style = "popin 80%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 3, bezier = "playfulOvershoot" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 3, bezier = "playfulAnticipate" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3, bezier = "playfulStandard" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 4, bezier = "playfulStandard" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "playfulOvershoot", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 4,  bezier = "playfulAnticipate", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 3, bezier = "playfulOvershoot" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 3, bezier = "playfulAnticipate" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4, bezier = "playfulOvershoot", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 4, bezier = "playfulOvershoot", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 4, bezier = "playfulAnticipate", style = "slide" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 5,    bezier = "playfulStandard" })
