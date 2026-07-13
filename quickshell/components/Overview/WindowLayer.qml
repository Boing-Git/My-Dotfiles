import QtQuick
import QtQuick.Effects
import Quickshell
import "../.."
import "../../Variables"
import Quickshell.Io
import ".."
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import "../../Variables/variables.js" as Vars

Item {
    id: root

    property var overviewContainer
    property var overviewPanel
    property bool gameMode: false
    
    signal closeRequested()

    // Debug: log toplevel data on visibility change
    onVisibleChanged: {
        if (visible) {
            const tpls = ToplevelManager.toplevels.values;
            console.log("=== OVERVIEW DEBUG ===");
            console.log("ToplevelManager.toplevels.values count:", tpls ? tpls.length : "null/undefined");
            console.log("HyprlandData.windowList count:", HyprlandData.windowList.length);
            console.log("HyprlandData.windowByAddress keys:", Object.keys(HyprlandData.windowByAddress).join(", "));
            if (tpls && tpls.length > 0) {
                for (let i = 0; i < Math.min(tpls.length, 5); i++) {
                    const t = tpls[i];
                    const hyprAddr = t.HyprlandToplevel ? t.HyprlandToplevel.address : "NO_HYPRLAND_TOPLEVEL";
                    console.log("  Toplevel", i, "appId:", t.appId, "address:", hyprAddr);
                }
            }
            console.log("=== END DEBUG ===");
        }
    }

    Repeater {
        model: ScriptModel {
            values: {
                // Reactive dependencies
                const dummy = HyprlandData.windowList.length;
                const tpls = ToplevelManager.toplevels.values;
                if (!tpls || tpls.length === 0)
                    return [];

                const result = tpls.filter(toplevel => {
                    if (!toplevel)
                        return false;
                    // Try both with and without HyprlandToplevel
                    let address = "";
                    if (toplevel.HyprlandToplevel) {
                        address = `0x${toplevel.HyprlandToplevel.address}`;
                    } else {
                        return false;
                    }
                    const win = HyprlandData.windowByAddress[address];
                    if (!win || !win.workspace)
                        return false;
                    const wsId = win.workspace.id;
                    return wsId >= 1 && wsId <= overviewPanel.totalWorkspaces;
                }).sort((a, b) => {
                    const addrA = `0x${a.HyprlandToplevel.address}`;
                    const addrB = `0x${b.HyprlandToplevel.address}`;
                    const winA = HyprlandData.windowByAddress[addrA];
                    const winB = HyprlandData.windowByAddress[addrB];
                    if (winA?.floating !== winB?.floating)
                        return winA?.floating ? 1 : -1;
                    return (winB?.focusHistoryID ?? 0) - (winA?.focusHistoryID ?? 0);
                });
                return result;
            }
        }

        delegate: Item {
            id: winItem
            required property var modelData
            required property int index

            property string address: `0x${modelData.HyprlandToplevel.address}`
            property var winData: HyprlandData.windowByAddress[address]

            // Which workspace cell does this window belong to?
            property int wsId: winData?.workspace?.id ?? 1
            property int wsRow: overviewContainer ? Math.floor((wsId - 1) / overviewContainer.gridColumns) : 0
            property int wsCol: overviewContainer ? (wsId - 1) % overviewContainer.gridColumns : 0

            // Grid cell origin (top-left corner of that workspace tile)
            property real cellX: wsCol * (overviewPanel.wsWidth + overviewPanel.wsSpacing)
            property real cellY: wsRow * (overviewPanel.wsHeight + overviewPanel.wsSpacing)

            // Monitor geometry
            property real monX: overviewPanel.hyprMonitor?.x ?? 0
            property real monY: overviewPanel.hyprMonitor?.y ?? 0

            // Window geometry relative to the monitor
            property real winX: (winData?.at?.[0] ?? 0) - monX
            property real winY: (winData?.at?.[1] ?? 0) - monY
            property real winW: winData?.size?.[0] ?? 100
            property real winH: winData?.size?.[1] ?? 100

            // Scale from real monitor pixels to tile pixels
            property real scaleX: overviewPanel.wsWidth / (overviewPanel.monitorWidth / overviewPanel.monitorScale)
            property real scaleY: overviewPanel.wsHeight / (overviewPanel.monitorHeight / overviewPanel.monitorScale)

            // Final position: cell origin + scaled window position within monitor
            property real initX: Math.round(cellX + Math.max(0, winX * scaleX))
            property real initY: Math.round(cellY + Math.max(0, winY * scaleY))

            x: initX
            y: initY
            width: Math.round(Math.min(winW * scaleX, overviewPanel.wsWidth))
            height: Math.round(Math.min(winH * scaleY, overviewPanel.wsHeight))
            z: dragArea.drag.active ? 99999 : index

            clip: true

            property string windowAddress: address

            // Drag is manually managed - do NOT bind Drag.active
            Drag.keys: ["window"]
            Drag.source: winItem
            Drag.hotSpot.x: width / 2
            Drag.hotSpot.y: height / 2

            Component.onCompleted: {
                console.log("Window delegate created:", modelData.appId, "addr:", address, "wsId:", wsId, "pos:", Math.round(x), Math.round(y), "size:", Math.round(width), "x", Math.round(height));
            }

            // Opaque background behind preview
            Rectangle {
                anchors.fill: parent
                radius: Vars.radiusMedium
                color: Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.12)
                border.width: 1
                border.color: winItem.winData?.floating ? Theme.tertiary_container : Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.2)
            }

            // Live screen capture
            ScreencopyView {
                id: preview
                anchors.fill: parent
                captureSource: winItem.modelData
                live: true
                layer.enabled: true
                layer.smooth: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: previewMask
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1.0
                }
            }

            // Mask for rounded corners
            Item {
                id: previewMask
                anchors.fill: parent
                visible: false
                layer.enabled: true
                layer.smooth: true
                Rectangle {
                    anchors.fill: parent
                    radius: Vars.radiusMedium
                }
            }

            // Hover/press overlay + icon
            Rectangle {
                anchors.fill: parent
                radius: Vars.radiusMedium
                color: dragArea.containsMouse ? Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.12) : Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.05)
                border.width: 1
                border.color: Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.1)

                // App icon centered over preview
                IconImage {
                    anchors.centerIn: parent
                    width: Math.min(parent.width, parent.height) * 0.35
                    height: width
                    source: Quickshell.iconPath(overviewContainer ? overviewContainer.resolveIcon(winItem.modelData.appId) : "", "application-x-executable")
                    asynchronous: false
                }
            }

            // Interaction: click to focus, middle-click to close, drag to move
            MouseArea {
                id: dragArea
                property bool wasDragged: false
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                cursorShape: Qt.PointingHandCursor
                drag.target: winItem

                onPressed: {
                    wasDragged = false;
                    overviewPanel.draggingFromWorkspace = winItem.wsId;
                }

                onPositionChanged: {
                    if (drag.active && !wasDragged) {
                        wasDragged = true;
                        winItem.Drag.active = true;
                    }
                }

                onClicked: mouse => {
                    if (wasDragged)
                        return;
                    if (mouse.button === Qt.LeftButton) {
                        Hyprland.dispatch(`hl.dsp.focus({ window = 'address:${winItem.address}' })`);
                        root.closeRequested();
                    } else if (mouse.button === Qt.MiddleButton) {
                        Hyprland.dispatch(`hl.dsp.window.close({ window = 'address:${winItem.address}' })`);
                    }
                }

                onReleased: {
                    const targetWs = overviewPanel.draggingTargetWorkspace;
                    overviewPanel.draggingFromWorkspace = -1;

                    if (wasDragged) {
                        winItem.Drag.active = false;

                        if (targetWs !== -1 && targetWs !== winItem.wsId) {
                            Hyprland.dispatch(`hl.dsp.window.move({workspace = '${targetWs}', follow = false, window = 'address:${winItem.address}'})`);
                        }
                    }

                    // Restore bindings so position reacts to workspace changes
                    winItem.x = Qt.binding(function () {
                        return winItem.initX;
                    });
                    winItem.y = Qt.binding(function () {
                        return winItem.initY;
                    });
                }
            }
        }
    }

    // === FOCUSED WORKSPACE INDICATOR ===
    Rectangle {
        id: focusedIndicator
        readonly property int activeWsId: Hyprland.focusedWorkspace?.id ?? 1
        readonly property int activeRow: overviewContainer ? Math.floor((activeWsId - 1) / overviewContainer.gridColumns) : 0
        readonly property int activeCol: overviewContainer ? (activeWsId - 1) % overviewContainer.gridColumns : 0

        x: Math.round(root.x + activeCol * (overviewPanel.wsWidth + overviewPanel.wsSpacing))
        y: Math.round(root.y + activeRow * (overviewPanel.wsHeight + overviewPanel.wsSpacing))
        width: Math.round(overviewPanel.wsWidth)
        height: Math.round(overviewPanel.wsHeight)
        z: 99999
        color: "transparent"
        radius: Vars.radiusSmall
        border.width: 2
        border.color: Theme.on_primary_container

        visible: activeWsId >= 1 && activeWsId <= overviewPanel.totalWorkspaces

        Behavior on x {
            enabled: !root.gameMode
            NumberAnimation {
                duration: Vars.animationDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Vars.m3ExpressiveSpatialFast
            }
        }
        Behavior on y {
            enabled: !root.gameMode
            NumberAnimation {
                duration: Vars.animationDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Vars.m3ExpressiveSpatialFast
            }
        }
    }
}
