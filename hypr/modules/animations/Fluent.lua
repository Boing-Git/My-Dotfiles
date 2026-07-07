-- Fluent Animation Style
hl.config({
  animations = {
    enabled = true,
    workspace_wraparound = false,
  },
})

hl.curve("overshot"    , { type = "bezier" , points = { {0.05 , 0.9} , {0.1  , 1.1  } } })
hl.curve("softSnap"    , { type = "bezier" , points = { {0.4  , 0  } , {0.2  , 1    } } })
hl.curve("fluent"      , { type = "bezier" , points = { {0.0  , 0.0} , {0.2  , 1.0  } } })
hl.curve("linear"      , { type = "bezier" , points = { {0    , 0  } , {1    , 1    } } })
hl.curve("almostLinear", { type = "bezier" , points = { {0.5  , 0.5} , {0.75 , 1    } } })
hl.curve("quick"       , { type = "bezier" , points = { {0.15 , 0  } , {0.1  , 1    } } })
hl.curve("smoothIn"    , { type = "bezier" , points = { {0.25 , 1  } , {0.5  , 1    } } })
hl.curve("smoothOut"   , { type = "bezier" , points = { {0.36 , 0  } , {0.66 , -0.56} } })

-- ease in
hl.curve("easeInSine"  , { type = "bezier", points = { {0.12 , 0}, {0.39 , 0    } } })
hl.curve("easeInQuad"  , { type = "bezier", points = { {0.11 , 0}, {0.5  , 0    } } })
hl.curve("easeInCubic" , { type = "bezier", points = { {0.32 , 0}, {0.67 , 0    } } })
hl.curve("easeInQuart" , { type = "bezier", points = { {0.5  , 0}, {0.75 , 0    } } })
hl.curve("easeInQuint" , { type = "bezier", points = { {0.64 , 0}, {0.78 , 0    } } })
hl.curve("easeInExpo"  , { type = "bezier", points = { {0.7  , 0}, {0.84 , 0    } } })
hl.curve("easeInCirc"  , { type = "bezier", points = { {0.55 , 0}, {1    , 0.45 } } })
hl.curve("easeInBack"  , { type = "bezier", points = { {0.36 , 0}, {0.66 , -0.56} } })

-- ease out
hl.curve("easeOutSine" , { type = "bezier", points = { {0.61 , 1   } , {0.88 , 1} } })
hl.curve("easeOutQuad" , { type = "bezier", points = { {0.5  , 1   } , {0.89 , 1} } })
hl.curve("easeOutCubic", { type = "bezier", points = { {0.33 , 1   } , {0.68 , 1} } })
hl.curve("easeOutQuart", { type = "bezier", points = { {0.25 , 1   } , {0.5  , 1} } })
hl.curve("easeOutQuint", { type = "bezier", points = { {0.22 , 1   } , {0.36 , 1} } })
hl.curve("easeOutExpo" , { type = "bezier", points = { {0.16 , 1   } , {0.3  , 1} } })
hl.curve("easeOutCirc" , { type = "bezier", points = { {0    , 0.55} , {0.45 , 1} } })
hl.curve("easeOutBack" , { type = "bezier", points = { {0.34 , 1.56} , {0.64 , 1} } })

-- ease in-out
hl.curve("easeInOutSine"  , { type = "bezier", points = { {0.37 , 0   } , {0.63 , 1   } } })
hl.curve("easeInOutQuad"  , { type = "bezier", points = { {0.45 , 0   } , {0.55 , 1   } } })
hl.curve("easeInOutCubic" , { type = "bezier", points = { {0.65 , 0   } , {0.35 , 1   } } })
hl.curve("easeInOutQuart" , { type = "bezier", points = { {0.76 , 0   } , {0.24 , 1   } } })
hl.curve("easeInOutQuint" , { type = "bezier", points = { {0.83 , 0   } , {0.17 , 1   } } })
hl.curve("easeInOutExpo"  , { type = "bezier", points = { {0.87 , 0   } , {0.13 , 1   } } })
hl.curve("easeInOutCirc"  , { type = "bezier", points = { {0.85 , 0   } , {0.15 , 1   } } })
hl.curve("easeInOutBack"  , { type = "bezier", points = { {0.68 , -0.6} , {0.32 , 1.6 } } })


hl.animation({ leaf = "windows"             , enabled = true , speed = 7 , bezier = "easeInOutQuint" })
hl.animation({ leaf = "windowsIn"           , enabled = true , speed = 7 , bezier = "easeInOutQuint" , style = "popin 75%" })
hl.animation({ leaf = "windowsOut"          , enabled = true , speed = 5 , bezier = "easeInOutQuint" })
hl.animation({ leaf = "windowsMove"         , enabled = true , speed = 4 , bezier = "softSnap" })

hl.animation({ leaf = "layers"              , enabled = true , speed = 5 , bezier = "easeInOutQuint" , style = "popin 75%" })
hl.animation({ leaf = "layersIn"            , enabled = true , speed = 5 , bezier = "easeInOutQuint" , style = "popin 75%" })
hl.animation({ leaf = "layersOut"           , enabled = true , speed = 7 , bezier = "easeInOutQuint" , style = "popin 75%" })

hl.animation({ leaf = "fade"                , enabled = true , speed = 5 , bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeIn"              , enabled = true , speed = 5 , bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeOut"             , enabled = true , speed = 7 , bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeSwitch"          , enabled = true , speed = 5 , bezier = "easeInOutQuint" })
hl.animation({ leaf = "fadeShadow"          , enabled = true , speed = 5 , bezier = "easeInOutQuint" })
hl.animation({ leaf = "fadeDim"             , enabled = true , speed = 7 , bezier = "easeInOutQuint" })
hl.animation({ leaf = "fadeLayers"          , enabled = true , speed = 5 , bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeLayersIn"        , enabled = true , speed = 5 , bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeLayersOut"       , enabled = true , speed = 7 , bezier = "easeOutQuint" })

hl.animation({ leaf = "border"              , enabled = true , speed = 7  , bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle"         , enabled = true , speed = 15 , bezier = "easeOutBack" })

hl.animation({ leaf = "workspaces"          , enabled = true , speed = 7 , bezier = "easeOutQuint" , style = "slidefade 10%" })
hl.animation({ leaf = "workspacesIn"        , enabled = true , speed = 7 , bezier = "easeOutQuint" , style = "slidefade 10%" })
hl.animation({ leaf = "workspacesOut"       , enabled = true , speed = 5 , bezier = "easeOutQuint" , style = "slidefade 10%" })
hl.animation({ leaf = "specialWorkspace"    , enabled = true , speed = 7 , bezier = "easeOutQuint" , style = "slidefadevert -10%" })
hl.animation({ leaf = "specialWorkspaceIn"  , enabled = true , speed = 7 , bezier = "easeOutQuint" , style = "slidefadevert -10%" })
hl.animation({ leaf = "specialWorkspaceOut" , enabled = true , speed = 7 , bezier = "easeOutQuint" , style = "slidefadevert -10%" })
