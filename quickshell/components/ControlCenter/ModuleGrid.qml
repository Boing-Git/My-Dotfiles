import QtQuick
import QtQuick.Layouts
import Quickshell
import QtCore
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import "../../Variables/variables.js" as Vars
import "../.."

ColumnLayout {
    id: moduleGrid
    
    property bool isEditorMode: false
    signal subMenuRequested(string menuName)
    signal openColorSchemeRequested()
    signal openSettingsRequested()
    signal openWallpaperRequested()
    signal openOverviewRequested()
    
    // External states for some modules
    property var audioNode: Pipewire.defaultAudioSink
    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var activeNet: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null
    property var signal: activeNet ? activeNet.signalStrength : 0

    readonly property string wifiIcon: {
        if (!Networking.wifiEnabled) return "\ue1da"; 
        if (!activeNet) return "\uf067"; 
        let tier = Math.min(Math.floor(signal / 25), 3);
        let icons = ["\ue1ba", "\uebe4", "\uebd6", "\uebe1"];
        return icons[tier];
    }

    property var adapter: Bluetooth.defaultAdapter
    property bool adapterState: adapter ? adapter.enabled : false
    property var connectDevice: adapter ? adapter.devices.values.find(d => d.connected) : null

    readonly property string bluetoothIcon: {
        if (!adapterState) return "\ue1a9"; 
        if (!connectDevice) return "\ue1a7"; 
        return "\ue1a8"; 
    }

    ListModel { id: activeTiles }
    ListModel { id: availableTiles }

    Settings {
        id: layoutSettings
        category: "ControlCenterLayout"
        property string activeLayout: "[]"
        property string availableLayout: "[]"
        
        Component.onCompleted: {
            loadLayout()
        }
    }

    function saveLayout() {
        let activeArr = [];
        for (let i = 0; i < activeTiles.count; i++) {
            activeArr.push({ "moduleId": activeTiles.get(i).moduleId, "expanded": activeTiles.get(i).expanded });
        }
        layoutSettings.activeLayout = JSON.stringify(activeArr);

        let availArr = [];
        for (let i = 0; i < availableTiles.count; i++) {
            availArr.push({ "moduleId": availableTiles.get(i).moduleId, "expanded": availableTiles.get(i).expanded });
        }
        layoutSettings.availableLayout = JSON.stringify(availArr);
    }

    function loadLayout() {
        let defaultActive = [
            {"moduleId": "wifi", "expanded": false},
            {"moduleId": "bluetooth", "expanded": false},
            {"moduleId": "audio", "expanded": false},
            {"moduleId": "display", "expanded": false}
        ];
        let defaultAvailable = [
            {"moduleId": "peace", "expanded": false},
            {"moduleId": "color", "expanded": false},
            {"moduleId": "wallpaper", "expanded": false},
            {"moduleId": "overview", "expanded": false}
        ];
        
        activeTiles.clear();
        availableTiles.clear();

        try {
            let activeArr = JSON.parse(layoutSettings.activeLayout);
            if (!activeArr || activeArr.length === 0) activeArr = defaultActive;
            for (let i = 0; i < activeArr.length; i++) {
                activeTiles.append(activeArr[i]);
            }
        } catch(e) {
            for (let i = 0; i < defaultActive.length; i++) activeTiles.append(defaultActive[i]);
        }
        
        try {
            let availArr = JSON.parse(layoutSettings.availableLayout);
            if (!availArr || availArr.length === 0) availArr = defaultAvailable;
            for (let i = 0; i < availArr.length; i++) {
                availableTiles.append(availArr[i]);
            }
        } catch(e) {
            for (let i = 0; i < defaultAvailable.length; i++) availableTiles.append(defaultAvailable[i]);
        }
    }

    // ==========================================
    // DELEGATE MODELS FOR DRAG AND DROP
    // ==========================================
    DelegateModel {
        id: activeVisualModel
        model: activeTiles
        delegate: DropArea {
            id: activeDropArea
            width: activeGridView.cellWidth
            height: activeGridView.cellHeight
            keys: ["active_module", "available_module"]
            
            z: dragArea.drag.active ? 100 : 1

            property int visualIndex: DelegateModel.itemsIndex
            property string dragMode: "active_module"

            onEntered: function(drag) {
                if (drag.source.dragMode === "active_module") {
                    let from = drag.source.visualIndex;
                    let to = activeDropArea.visualIndex;
                    if (from !== to && from !== undefined && to !== undefined) {
                        activeVisualModel.items.move(from, to);
                    }
                }
            }
            onDropped: function(drag) {
                if (drag.source.dragMode === "available_module") {
                    let from = drag.source.sourceIndex; // from availableTiles
                    if (from >= 0 && from < availableTiles.count) {
                        let mIdVal = availableTiles.get(from).moduleId;
                        availableTiles.remove(from, 1);
                        activeTiles.insert(activeDropArea.visualIndex, { "moduleId": mIdVal, "expanded": false });
                        moduleGrid.saveLayout();
                    }
                } else {
                    moduleGrid.saveLayout();
                }
            }

            Rectangle {
                id: tileDelegate
                property int visualIndex: DelegateModel.itemsIndex

                width: activeDropArea.width - 12
                height: activeDropArea.height - 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                radius: 16
                color: dragArea.drag.active ? Theme.surface_container_highest : (isActive ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.25) : Theme.surface_container)
                scale: dragArea.drag.active ? 1.05 : 1.0
                
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 150 } }
                
                property string mId: model.moduleId
                
                property bool isActive: (mId === "wifi" ? Networking.wifiEnabled : false) || 
                                        (mId === "bluetooth" ? moduleGrid.adapterState : false) || 
                                        (mId === "audio" ? (moduleGrid.audioNode && !moduleGrid.audioNode.audio.muted) : false) || 
                                        (mId === "display" ? false : false) ||
                                        (mId === "peace" ? NotificationService.peaceMode : false)
                                        
                property string mIcon: mId === "wifi" ? moduleGrid.wifiIcon :
                                       mId === "bluetooth" ? moduleGrid.bluetoothIcon :
                                       mId === "audio" ? (moduleGrid.audioNode && moduleGrid.audioNode.audio.muted ? "\ue04f" : "\ue050") :
                                       mId === "display" ? "\ue30d" :
                                       mId === "peace" ? "\ue15c" :
                                       mId === "color" ? "palette" :
                                       mId === "wallpaper" ? "wallpaper" :
                                       mId === "overview" ? "grid_view" : ""
                                       
                property string mTitle: mId === "wifi" ? "Wi-Fi" :
                                        mId === "bluetooth" ? "Bluetooth" :
                                        mId === "audio" ? "Audio" :
                                        mId === "display" ? "Display" :
                                        mId === "peace" ? "Peace" :
                                        mId === "color" ? "Colors" :
                                        mId === "wallpaper" ? "Wallpaper" :
                                        mId === "overview" ? "Overview" : ""
                                        
                property string mSubtext: mId === "wifi" ? (moduleGrid.activeNet ? moduleGrid.activeNet.name : "Off") :
                                          mId === "bluetooth" ? (moduleGrid.connectDevice ? moduleGrid.connectDevice.name : (moduleGrid.adapterState ? "On" : "Off")) :
                                          mId === "audio" ? (moduleGrid.audioNode && moduleGrid.audioNode.audio.muted ? "Muted" : "Active") :
                                          mId === "display" ? "Default" :
                                          mId === "peace" ? (isActive ? "Active" : "Inactive") :
                                          mId === "color" ? "Change Theme" :
                                          mId === "wallpaper" ? "Switcher" :
                                          mId === "overview" ? "Workspaces" : ""
                                          
                function doAction() {
                    if (mId === "wifi") moduleGrid.subMenuRequested("wifi");
                    else if (mId === "bluetooth") moduleGrid.subMenuRequested("bluetooth");
                    else if (mId === "display") moduleGrid.subMenuRequested("display");
                    else if (mId === "color") moduleGrid.openColorSchemeRequested()
                    else if (mId === "wallpaper") moduleGrid.openWallpaperRequested()
                    else if (mId === "overview") moduleGrid.openOverviewRequested()
                    else doToggle();
                }
                
                function doToggle() {
                    if (mId === "wifi") Networking.wifiEnabled = !Networking.wifiEnabled;
                    else if (mId === "bluetooth") { if (moduleGrid.adapter) moduleGrid.adapter.enabled = !moduleGrid.adapter.enabled }
                    else if (mId === "audio") { if (moduleGrid.audioNode) moduleGrid.audioNode.audio.muted = !moduleGrid.audioNode.audio.muted }
                    else if (mId === "peace") NotificationService.peaceMode = !NotificationService.peaceMode;
                    else doAction();
                }

                // --- INSERT YOUR WORKING MODULE UI HERE ---
                Item {
                    anchors.fill: parent
                    clip: true
                    
                    Text { 
                        anchors.centerIn: parent
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 24
                        color: tileDelegate.isActive ? Theme.primary : Theme.on_surface_variant
                        text: tileDelegate.mIcon
                    }
                    MouseArea { 
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor; 
                        onClicked: { if (!moduleGrid.isEditorMode) tileDelegate.doAction() } 
                    }
                }
                // --- END WORKING MODULE UI ---

                // ---- EDITOR OVERLAY ----
                Item {
                    anchors.fill: parent
                    opacity: moduleGrid.isEditorMode ? 1.0 : 0.0
                    visible: opacity > 0
                    Behavior on opacity { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3EmphasizedDecelerate } }

                    // Overlay to show edit mode is active, slightly dimming the content
                    Rectangle {
                        anchors.fill: parent; radius: 16
                        color: dragArea.drag.active ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.0) : (dragArea.containsMouse ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.08) : Qt.rgba(0, 0, 0, 0.1))
                        Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3EmphasizedDecelerate } }
                    }

                    // Drag Handle (Top Right) - 48x48dp Touch Target
                    MouseArea {
                        id: dragArea
                        width: 48; height: 48
                        anchors.top: parent.top
                        anchors.right: parent.right
                        cursorShape: Qt.OpenHandCursor
                        
                        drag.target: tileDelegate

                        onPressed: {
                            cursorShape = Qt.ClosedHandCursor;
                            activeGridView.interactive = false; // ensure GridView doesn't scroll
                        }
                        onReleased: {
                            cursorShape = Qt.OpenHandCursor;
                            activeGridView.interactive = false;
                            tileDelegate.Drag.drop();
                            moduleGrid.saveLayout();
                        }

                        Text {
                            anchors.centerIn: parent
                            font.family: "Material Symbols Outlined"; font.pixelSize: 20
                            color: Theme.on_surface_variant
                            text: "drag_indicator"
                        }
                    }
                }
                
                states: [
                    State {
                        when: dragArea.drag.active
                        ParentChange {
                            target: tileDelegate
                            parent: activeGridView
                        }
                        AnchorChanges {
                            target: tileDelegate
                            anchors.horizontalCenter: undefined
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
                
                Drag.active: dragArea.drag.active
                Drag.source: activeDropArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2
                Drag.keys: ["active_module"]
            }
        }
    }

    DelegateModel {
        id: availableVisualModel
        model: availableTiles
        delegate: DropArea {
            id: availableDropArea
            width: availableGridView.cellWidth
            height: availableGridView.cellHeight
            keys: ["available_module", "active_module"]
            
            z: availDragArea.drag.active ? 100 : 1
            
            property int visualIndex: DelegateModel.itemsIndex
            property string dragMode: "available_module"
            
            // To pass the index easily on drop from available to active:
            property int sourceIndex: model.index

            onEntered: function(drag) {
                if (drag.source.dragMode === "available_module") {
                    let from = drag.source.visualIndex;
                    let to = availableDropArea.visualIndex;
                    if (from !== to && from !== undefined && to !== undefined) {
                        availableVisualModel.items.move(from, to);
                    }
                }
            }
            onDropped: function(drag) {
                if (drag.source.dragMode === "active_module") {
                    let from = drag.source.visualIndex;
                    if (from >= 0 && from < activeTiles.count) {
                        let mIdVal = activeTiles.get(from).moduleId;
                        activeTiles.remove(from, 1);
                        availableTiles.insert(availableDropArea.visualIndex, { "moduleId": mIdVal, "expanded": false });
                        moduleGrid.saveLayout();
                    }
                } else {
                    moduleGrid.saveLayout();
                }
            }

            Rectangle {
                id: availDelegate
                property int visualIndex: DelegateModel.itemsIndex

                width: availableDropArea.width - 12
                height: availableDropArea.height - 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                radius: 16
                
                color: availDragArea.drag.active ? Theme.surface_container_highest : Theme.surface_container
                scale: availDragArea.drag.active ? 1.05 : 1.0
                
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 150 } }

                property string mId: model.moduleId
                property string mIcon: mId === "wifi" ? moduleGrid.wifiIcon : mId === "bluetooth" ? moduleGrid.bluetoothIcon : mId === "audio" ? "\ue050" : mId === "display" ? "\ue30d" : mId === "peace" ? "\ue15c" : mId === "color" ? "palette" : mId === "wallpaper" ? "wallpaper" : mId === "overview" ? "grid_view" : ""

                // --- INSERT YOUR WORKING MODULE UI HERE ---
                Text {
                    anchors.centerIn: parent
                    font.family: "Material Symbols Outlined"; font.pixelSize: 24
                    color: Theme.on_surface_variant
                    text: availDelegate.mIcon
                }
                // --- END WORKING MODULE UI ---

                // Drag Handle (Top Right)
                MouseArea {
                    id: availDragArea
                    width: 48; height: 48
                    anchors.top: parent.top
                    anchors.right: parent.right
                    cursorShape: Qt.OpenHandCursor
                    
                    drag.target: availDelegate

                    onPressed: {
                        cursorShape = Qt.ClosedHandCursor;
                    }
                    onReleased: {
                        cursorShape = Qt.OpenHandCursor;
                        availDelegate.Drag.drop();
                        moduleGrid.saveLayout();
                    }
                    
                    Text {
                        anchors.centerIn: parent
                        font.family: "Material Symbols Outlined"; font.pixelSize: 20
                        color: Theme.on_surface_variant
                        text: "drag_indicator"
                    }
                }
                
                states: [
                    State {
                        when: availDragArea.drag.active
                        ParentChange {
                            target: availDelegate
                            parent: availableGridView
                        }
                        AnchorChanges {
                            target: availDelegate
                            anchors.horizontalCenter: undefined
                            anchors.verticalCenter: undefined
                        }
                    }
                ]

                Drag.active: availDragArea.drag.active
                Drag.source: availableDropArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2
                Drag.keys: ["available_module"]
            }
        }
    }

    // ==========================================
    // VISUAL GRIDS
    // ==========================================
    
    // Background drop area to catch active tiles dropped at the end
    DropArea {
        Layout.fillWidth: true
        Layout.preferredHeight: activeGridView.contentHeight > 76 ? activeGridView.contentHeight : 76
        keys: ["available_module"]
        onDropped: function(drag) {
            if (drag.source.dragMode === "available_module") {
                let from = drag.source.sourceIndex; // from availableDropArea.sourceIndex
                if (from >= 0 && from < availableTiles.count) {
                    let mIdVal = availableTiles.get(from).moduleId;
                    availableTiles.remove(from, 1);
                    activeTiles.append({ "moduleId": mIdVal, "expanded": false });
                    moduleGrid.saveLayout();
                }
            }
        }
        
        GridView {
            id: activeGridView
            anchors.fill: parent
            cellWidth: parent.width / 4
            cellHeight: 76
            model: activeVisualModel
            interactive: false
            
            displaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutCubic }
            }
        }
    }

    ColumnLayout {
        id: availableGridWrapper
        Layout.fillWidth: true
        visible: moduleGrid.isEditorMode
        Layout.topMargin: 16
        spacing: 12

        Text {
            text: "Available Modules"
            font.family: Vars.fontFamily; font.pixelSize: 14; font.weight: 600; color: Theme.on_surface_variant
        }

        DropArea {
            Layout.fillWidth: true
            Layout.preferredHeight: availableGridView.contentHeight > 76 ? availableGridView.contentHeight : 76
            keys: ["active_module"]
            onDropped: function(drag) {
                if (drag.source.dragMode === "active_module") {
                    let from = drag.source.visualIndex;
                    if (from >= 0 && from < activeTiles.count) {
                        let mIdVal = activeTiles.get(from).moduleId;
                        activeTiles.remove(from, 1);
                        availableTiles.append({ "moduleId": mIdVal, "expanded": false });
                        moduleGrid.saveLayout();
                    }
                }
            }

            GridView {
                id: availableGridView
                anchors.fill: parent
                cellWidth: parent.width / 4
                cellHeight: 76
                model: availableVisualModel
                interactive: false
                
                displaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutCubic }
                }
            }
        }
    }
}
