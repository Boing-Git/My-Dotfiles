local vars = require("modules.variables")

hl.config({
    bezier = {
        "customStandard, 0.20, 0.00, 0.00, 1.00",
        "customStandardDecelerate, 0.0, 0.0, 0.0, 1.0",
        "customStandardAccelerate, 0.3, 0.0, 1.0, 1.0",
        "customEmphasizedDecelerate, 0.05, 0.7, 0.1, 1.0",
        "customEmphasizedAccelerate, 0.3, 0.0, 0.8, 0.15",
        "customExpressiveSpatialFast, 0.42, 1.67, 0.21, 0.9",
        "customExpressiveSpatialSlow, 0.39, 1.29, 0.35, 0.98"
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
