local vars = require("modules.variables")

hl.config({
    bezier = {
        "customStandard, 0.98, 0.09, 0.42, 0.50",
        "customStandardDecelerate, 0.00, 0.00, 0.00, 1.00",
        "customStandardAccelerate, 1.00, 0.13, 0.63, 0.42",
        "customEmphasizedDecelerate, 0.05, 0.70, 0.10, 1.00",
        "customEmphasizedAccelerate, 0.30, 0.00, 0.80, 0.15",
        "customExpressiveSpatialFast, 0.42, 1.67, 0.21, 0.90",
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
