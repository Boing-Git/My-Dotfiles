import os
from pathlib import Path

repo = Path('/home/boing/Dotfiles/quickshell/components')
files_to_check = ['ControlCenter.qml', 'Launcher.qml', 'EmojiPicker.qml', 'PowerMenu.qml', 'PolkitDialog.qml', 'SettingsApp.qml', 'NotificationPopup.qml', 'ColorSchemeSwitcher.qml', 'WallpaperSwitcher.qml']

for filename in files_to_check:
    filepath = repo / filename
    if not filepath.exists():
        continue
        
    content = filepath.read_text(encoding='utf-8')
    
    # Replace radius assignment
    old_radius = "radius: root.gameMode ? 0 : (root.expanded ? Vars.radiusExtraLarge : height / 2)"
    new_radius = """topLeftRadius: root.gameMode || Vars.panelStyle === "Attached" || Vars.panelStyle === "Flat" ? 0 : (root.expanded ? Vars.radiusExtraLarge : height / 2)
        topRightRadius: root.gameMode || Vars.panelStyle === "Attached" || Vars.panelStyle === "Flat" ? 0 : (root.expanded ? Vars.radiusExtraLarge : height / 2)
        bottomLeftRadius: root.gameMode || Vars.panelStyle === "Flat" ? 0 : (root.expanded ? Vars.radiusExtraLarge : height / 2)
        bottomRightRadius: root.gameMode || Vars.panelStyle === "Flat" ? 0 : (root.expanded ? Vars.radiusExtraLarge : height / 2)"""
    
    if old_radius in content:
        content = content.replace(old_radius, new_radius)
        
    # Replace behavior
    old_behavior = "Behavior on radius { enabled: !root.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow } }"
    new_behavior = """Behavior on topLeftRadius { enabled: !root.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow } }
        Behavior on topRightRadius { enabled: !root.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow } }
        Behavior on bottomLeftRadius { enabled: !root.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow } }
        Behavior on bottomRightRadius { enabled: !root.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow } }"""
        
    if old_behavior in content:
        content = content.replace(old_behavior, new_behavior)
        
    filepath.write_text(content, encoding='utf-8')
    print(f"Updated {filename}")
