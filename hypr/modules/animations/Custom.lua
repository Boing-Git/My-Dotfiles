local vars = require("modules.variables")

hl.config({
    bezier = {
        "customStandard, " .. vars.CustomStandard,
        "customStandardDecelerate, " .. vars.CustomStandardDecelerate,
        "customStandardAccelerate, " .. vars.CustomStandardAccelerate,
        "customEmphasizedDecelerate, " .. vars.CustomEmphasizedDecelerate,
        "customEmphasizedAccelerate, " .. vars.CustomEmphasizedAccelerate,
        "customExpressiveSpatialFast, " .. vars.CustomExpressiveSpatialFast,
        "customExpressiveSpatialSlow, " .. vars.CustomExpressiveSpatialSlow
    },
    animation = {
        "windows, 1, 4, customStandard",
        "windowsIn, 1, 4, customEmphasizedDecelerate, popin 80%",
        "windowsOut, 1, 3, customEmphasizedAccelerate, popin 80%",
        "border, 1, 5, customExpressiveSpatialSlow",
        "borderangle, 1, 8, customExpressiveSpatialSlow",
        "fade, 1, 3, customStandard",
        "workspaces, 1, 4, customExpressiveSpatialSlow, fade"
    }
})
