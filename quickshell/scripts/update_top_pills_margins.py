import re

file_path = "/home/boing/Dotfiles/quickshell/components/TopPills.qml"
with open(file_path, "r") as f:
    content = f.read()

# Replace all occurrences of `anchors.topMargin: 5` with the dynamic panelStyle check
# But wait, ClockPill and Workspaces have `anchors.topMargin: topWindow.gameMode ? 0 : 5`
# And VolumeOsd has `anchors.topMargin: topWindow.gameMode ? 55 : 5`

content = re.sub(
    r"anchors\.topMargin:\s*topWindow\.gameMode\s*\?\s*0\s*:\s*5",
    r"anchors.topMargin: topWindow.gameMode || Vars.panelStyle === 'Attached' || Vars.panelStyle === 'Flat' ? 0 : 5",
    content
)

content = re.sub(
    r"anchors\.topMargin:\s*5",
    r"anchors.topMargin: topWindow.gameMode || Vars.panelStyle === 'Attached' || Vars.panelStyle === 'Flat' ? 0 : 5",
    content
)

content = re.sub(
    r"anchors\.topMargin:\s*topWindow\.gameMode\s*\?\s*55\s*:\s*5",
    r"anchors.topMargin: topWindow.gameMode ? 55 : (Vars.panelStyle === 'Attached' || Vars.panelStyle === 'Flat' ? 0 : 5)",
    content
)

with open(file_path, "w") as f:
    f.write(content)
print("Updated TopPills.qml")
