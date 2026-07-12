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
    id: moduleGridRoot
    
    property bool isEditorMode: false
    property real baseCellWidth: (width / 4) - 12
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

    function activateModule(moduleId) {
        for (let i = 0; i < availableTiles.count; i++) {
            if (availableTiles.get(i).moduleId === moduleId) {
                let payload = { "moduleId": availableTiles.get(i).moduleId, "expanded": false };
                availableTiles.remove(i);
                activeTiles.append(payload);
                saveLayout();
                return;
            }
        }
    }

    function deactivateModule(moduleId) {
        for (let i = 0; i < activeTiles.count; i++) {
            if (activeTiles.get(i).moduleId === moduleId) {
                let payload = { "moduleId": activeTiles.get(i).moduleId, "expanded": false };
                activeTiles.remove(i);
                availableTiles.append(payload);
                saveLayout();
                return;
            }
        }
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
            
            property bool isExpanded: model.expanded !== undefined ? model.expanded : false
            
            width: isExpanded ? (moduleGridRoot.baseCellWidth * 2) + 12 : moduleGridRoot.baseCellWidth
            height: 64
            keys: ["m3_module"]
            
            Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            
            z: dragArea.drag.active ? 100 : 1

            property int visualIndex: DelegateModel.itemsIndex
            property string dragMode: "active_module"
            property string moduleId: model.moduleId
            property var rootItem: moduleGridRoot

            onEntered: function(drag) {
                if (!moduleGridRoot.isEditorMode) return;
                if (!drag.source) return;
                
                // WARNING: If using a custom C++ QAbstractListModel or external JS array, 
                // ensure items.move() splices the array properly and does not duplicate entries.
                let from = drag.source.visualIndex;
                let to = activeDropArea.visualIndex;
                
                if (from !== undefined && to !== undefined && from !== to && drag.source !== activeDropArea) {
                    activeVisualModel.items.move(from, to);
                    drag.source.visualIndex = to; // Anti-thrashing guard
                }
            }
            onDropped: function(drag) {
                if (drag.source.dragMode === "available_module") {
                    let from = drag.source.sourceIndex; // from availableTiles
                    if (from >= 0 && from < availableTiles.count) {
                        let mIdVal = availableTiles.get(from).moduleId;
                        availableTiles.remove(from, 1);
                        activeTiles.insert(activeDropArea.visualIndex, { "moduleId": mIdVal, "expanded": false });
                        moduleGridRoot.saveLayout();
                    }
                } else {
                    moduleGridRoot.saveLayout();
                }
            }

            Rectangle {
                id: tileDelegate
                property int visualIndex: DelegateModel.itemsIndex

                x: 0
                y: 0
                width: activeDropArea.width
                height: activeDropArea.height
                radius: 16
                color: dragArea.drag.active ? Theme.surface_container_highest : (isActive ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.25) : Theme.surface_container)
                scale: dragArea.drag.active ? 1.05 : 1.0
                
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 150 } }
                
                property string moduleId: model.moduleId
                
                property bool isActive: (moduleId === "wifi" ? Networking.wifiEnabled : false) || 
                                        (moduleId === "bluetooth" ? moduleGridRoot.adapterState : false) || 
                                        (moduleId === "audio" ? (moduleGridRoot.audioNode && !moduleGridRoot.audioNode.audio.muted) : false) || 
                                        (moduleId === "display" ? false : false) ||
                                        (moduleId === "peace" ? NotificationService.peaceMode : false)
                                        
                property string mIcon: moduleId === "wifi" ? moduleGridRoot.wifiIcon :
                                       moduleId === "bluetooth" ? moduleGridRoot.bluetoothIcon :
                                       moduleId === "audio" ? (moduleGridRoot.audioNode && moduleGridRoot.audioNode.audio.muted ? "\ue04f" : "\ue050") :
                                       moduleId === "display" ? "\ue30d" :
                                       moduleId === "peace" ? "\ue15c" :
                                       moduleId === "color" ? "palette" :
                                       moduleId === "wallpaper" ? "wallpaper" :
                                       moduleId === "overview" ? "grid_view" : ""
                                       
                property string mTitle: moduleId === "wifi" ? "Wi-Fi" :
                                        moduleId === "bluetooth" ? "Bluetooth" :
                                        moduleId === "audio" ? "Audio" :
                                        moduleId === "display" ? "Display" :
                                        moduleId === "peace" ? "Peace" :
                                        moduleId === "color" ? "Colors" :
                                        moduleId === "wallpaper" ? "Wallpaper" :
                                        moduleId === "overview" ? "Overview" : ""
                                        
                function getExpandedSubtitle() {
                    switch(moduleId) {
                        case "wifi": 
                            return moduleGridRoot.activeNet ? moduleGridRoot.activeNet.name : "Not Connected";
                        case "bluetooth": 
                            return moduleGridRoot.connectDevice ? moduleGridRoot.connectDevice.name : (moduleGridRoot.adapterState ? "On" : "Available");
                        case "audio": 
                            return moduleGridRoot.audioNode && moduleGridRoot.audioNode.audio.muted ? "Muted" : "Active";
                        case "display": 
                            return "Default";
                        case "peace":
                            return isActive ? "Active" : "Inactive";
                        case "color":
                            return "Change Theme";
                        case "wallpaper":
                            return "Switcher";
                        case "overview":
                            return "Workspaces";
                        default: 
                            return "";
                    }
                }
                                          
                function doAction() {
                    if (moduleId === "wifi") moduleGridRoot.subMenuRequested("wifi");
                    else if (moduleId === "bluetooth") moduleGridRoot.subMenuRequested("bluetooth");
                    else if (moduleId === "display") moduleGridRoot.subMenuRequested("display");
                    else if (moduleId === "color") moduleGridRoot.openColorSchemeRequested()
                    else if (moduleId === "wallpaper") moduleGridRoot.openWallpaperRequested()
                    else if (moduleId === "overview") moduleGridRoot.openOverviewRequested()
                    else doToggle();
                }
                
                function doToggle() {
                    if (moduleId === "wifi") Networking.wifiEnabled = !Networking.wifiEnabled;
                    else if (moduleId === "bluetooth") { if (moduleGridRoot.adapter) moduleGridRoot.adapter.enabled = !moduleGridRoot.adapter.enabled }
                    else if (moduleId === "audio") { if (moduleGridRoot.audioNode) moduleGridRoot.audioNode.audio.muted = !moduleGridRoot.audioNode.audio.muted }
                    else if (moduleId === "peace") NotificationService.peaceMode = !NotificationService.peaceMode;
                    else doAction();
                }

                // --- INSERT YOUR WORKING MODULE UI HERE ---
                Item {
                    id: contentWrapper
                    anchors.fill: parent
                    anchors.margins: 12
                    clip: true
                    
                    // State 1: The Collapsed UI (Pure Centered Icon)
                    Item {
                        id: collapsedUI
                        anchors.fill: parent
                        opacity: activeDropArea.isExpanded ? 0.0 : 1.0
                        Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                        visible: opacity > 0
                        
                        Text {
                            anchors.centerIn: parent
                            width: 32
                            height: 32
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Material Symbols Outlined"
                            font.pixelSize: 24
                            color: tileDelegate.isActive ? Theme.primary : Theme.on_surface_variant
                            text: tileDelegate.mIcon
                        }
                    }
                    
                    // State 2: The Expanded UI (Left-Aligned List Item)
                    Item {
                        id: expandedUI
                        anchors.fill: parent
                        opacity: activeDropArea.isExpanded ? 1.0 : 0.0
                        Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                        visible: opacity > 0
                        
                        RowLayout {
                            anchors.fill: parent
                            spacing: 16
                            
                            // Static Icon Container
                            Item {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                Layout.alignment: Qt.AlignVCenter
                                
                                Text {
                                    anchors.centerIn: parent
                                    font.family: "Material Symbols Outlined"
                                    font.pixelSize: 24
                                    color: tileDelegate.isActive ? Theme.primary : Theme.on_surface_variant
                                    text: tileDelegate.mIcon
                                }
                            }
                            
                            // Morphing Text Column
                            ColumnLayout {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.fillWidth: true
                                
                                Text {
                                    Layout.alignment: Qt.AlignLeft
                                    horizontalAlignment: Text.AlignLeft
                                    text: tileDelegate.mTitle
                                    font.family: Vars.fontFamily
                                    font.pixelSize: 16
                                    font.weight: 600
                                    color: Theme.on_surface
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                }
                                
                                Text {
                                    Layout.alignment: Qt.AlignLeft
                                    horizontalAlignment: Text.AlignLeft
                                    color: Theme.on_surface_variant
                                    font.family: Vars.fontFamily
                                    font.pixelSize: 14
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                    
                                    text: tileDelegate.getExpandedSubtitle()
                                }
                            }
                        }
                    }
                    
                    MouseArea { 
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor; 
                        onClicked: { if (!moduleGridRoot.isEditorMode) tileDelegate.doAction() } 
                    }
                }
                // --- END WORKING MODULE UI ---

                // ---- EDITOR OVERLAY ----
                Item {
                    anchors.fill: parent
                    opacity: moduleGridRoot.isEditorMode ? 1.0 : 0.0
                    visible: opacity > 0
                    Behavior on opacity { NumberAnimation { duration: 150 } }

                    // Overlay to show edit mode is active, slightly dimming the content
                    Rectangle {
                        anchors.fill: parent; radius: 16
                        color: dragArea.drag.active ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.0) : (dragArea.containsMouse ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.08) : Qt.rgba(0, 0, 0, 0.1))
                        Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3EmphasizedDecelerate } }
                    }

                    // Full Card Drag Handle
                    MouseArea {
                        id: dragArea
                        anchors.fill: parent
                        cursorShape: Qt.OpenHandCursor
                        
                        drag.target: tileDelegate

                        onPressed: {
                            cursorShape = Qt.ClosedHandCursor;
                        }
                        onReleased: {
                            cursorShape = Qt.OpenHandCursor;
                            tileDelegate.Drag.drop();
                            tileDelegate.x = 0;
                            tileDelegate.y = 0;
                            rootItem.saveLayout();
                        }
                    }

                    // Top-Left Drag Indicator Badge
                    Text {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: 12
                        font.family: "Material Symbols Outlined"; font.pixelSize: 20
                        color: Theme.on_surface_variant
                        text: "drag_indicator"
                    }
                    
                    // Expand/Collapse Chevron Pill (Right Edge)
                    Rectangle {
                        width: 12
                        height: 48
                        radius: 6
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: -6
                        color: Theme.secondary_container
                        
                        Text {
                            anchors.centerIn: parent
                            font.family: "Material Symbols Outlined"; font.pixelSize: 12
                            color: Theme.on_secondary_container
                            text: activeDropArea.isExpanded ? "expand_less" : "expand_more"
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                model.expanded = !model.expanded
                                moduleGridRoot.saveLayout()
                            }
                        }
                    }
                }


                
                Drag.active: dragArea.drag.active
                Drag.source: activeDropArea
                z: dragArea.drag.active ? 100 : 1
                Drag.keys: ["m3_module"]
            }
        }
    }

    // ==========================================
    // VISUAL GRIDS
    // ==========================================
    
    // Background drop area to catch active tiles dropped at the end
    DropArea {
        Layout.fillWidth: true
        Layout.preferredHeight: activeFlow.implicitHeight > 64 ? activeFlow.implicitHeight : 64
        keys: ["m3_module"]
        onDropped: function(drop) {
            if (drop.source && drop.source.moduleId) {
                moduleGridRoot.activateModule(drop.source.moduleId);
                drop.accept();
            }
            moduleGridRoot.saveLayout();
        }
        
        Flow {
            id: activeFlow
            anchors.fill: parent
            spacing: 12
            
            move: Transition {
                NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutCubic }
            }
            
            Repeater {
                model: activeVisualModel
            }
        }
    }

    DelegateModel {
        id: availableVisualModel
        model: availableTiles
        delegate: DropArea {
            id: availableDropArea
            width: GridView.view ? GridView.view.cellWidth : 80
            height: GridView.view ? GridView.view.cellHeight : 80
            keys: ["m3_module"]
            
            z: availDragArea.drag.active ? 100 : 1
            
            property int visualIndex: DelegateModel.itemsIndex
            property string dragMode: "available_module"
            property string moduleId: model.moduleId
            property var rootItem: moduleGridRoot

            onPositionChanged: function(drag) {
                if (!moduleGridRoot.isEditorMode) return;
                if (!drag.source) return;
                if (drag.source.dragMode !== "available_module") return;
                
                let from = drag.source.visualIndex;
                let hoverIndex = availableDropArea.visualIndex;
                
                if (from !== undefined && hoverIndex !== undefined && from !== hoverIndex && drag.source !== availableDropArea) {
                    let isLeftHalf = drag.x < availableDropArea.width / 2;
                    let targetIndex = hoverIndex;
                    
                    if (from < hoverIndex && !isLeftHalf) {
                        targetIndex = hoverIndex;
                    } else if (from < hoverIndex && isLeftHalf) {
                        targetIndex = hoverIndex - 1;
                    } else if (from > hoverIndex && isLeftHalf) {
                        targetIndex = hoverIndex;
                    } else if (from > hoverIndex && !isLeftHalf) {
                        targetIndex = hoverIndex + 1;
                    }
                    
                    if (from !== targetIndex) {
                        availableVisualModel.items.move(from, targetIndex);
                        drag.source.visualIndex = targetIndex;
                    }
                }
            }
            
            Rectangle {
                id: availDelegate
                anchors.centerIn: parent
                width: GridView.view ? GridView.view.cellWidth - 16 : 100
                height: GridView.view ? GridView.view.cellHeight - 16 : 48
                radius: 16
                
                color: availDragArea.drag.active ? Theme.surface_container_highest : Theme.surface_container_high
                scale: availDragArea.drag.active ? 1.05 : 1.0
                
                Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 150 } }

                property string mIcon: moduleId === "wifi" ? moduleGridRoot.wifiIcon : moduleId === "bluetooth" ? moduleGridRoot.bluetoothIcon : moduleId === "audio" ? "\ue050" : moduleId === "display" ? "\ue30d" : moduleId === "peace" ? "\ue15c" : moduleId === "color" ? "palette" : moduleId === "wallpaper" ? "wallpaper" : moduleId === "overview" ? "grid_view" : ""
                property string mName: moduleId.charAt(0).toUpperCase() + moduleId.slice(1)

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12
                    
                    Text {
                        Layout.alignment: Qt.AlignVCenter
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 24
                        color: Theme.on_surface_variant
                        text: availDelegate.mIcon
                    }
                    Text {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                        font.family: Vars.fontFamily
                        font.pixelSize: 14
                        font.weight: 500
                        color: Theme.on_surface_variant
                        text: availDelegate.mName
                        elide: Text.ElideRight
                    }
                }

                MouseArea {
                    id: availDragArea
                    anchors.fill: parent
                    cursorShape: Qt.OpenHandCursor
                    drag.target: availDelegate

                    onPressed: { cursorShape = Qt.ClosedHandCursor; }
                    onReleased: {
                        cursorShape = Qt.OpenHandCursor;
                        availDelegate.Drag.drop();
                        availDelegate.x = 0;
                        availDelegate.y = 0;
                        rootItem.saveLayout();
                    }
                }
                
                Drag.active: availDragArea.drag.active
                Drag.source: availableDropArea
                Drag.keys: ["m3_module"]
            }
        }
    }

    // ==========================================
    // MODULE STASH (HOLDING AREA)
    // ==========================================
    ColumnLayout {
        id: moduleStashContainer
        Layout.fillWidth: true
        Layout.topMargin: 16
        visible: moduleGridRoot.isEditorMode
        spacing: 12

        Text {
            text: "Available Modules"
            font.family: Vars.fontFamily
            font.pixelSize: 14
            font.weight: Font.DemiBold
            color: Theme.on_surface_variant
        }

        DropArea {
            id: stashDropArea
            Layout.fillWidth: true
            Layout.preferredHeight: Math.ceil(availableTiles.count / 2) * 64 + 16 > 64 ? Math.ceil(availableTiles.count / 2) * 64 + 16 : 64
            keys: ["m3_module"]

            onDropped: function(drop) {
                if (drop.source && drop.source.moduleId) {
                    moduleGridRoot.deactivateModule(drop.source.moduleId);
                    drop.accept();
                }
                moduleGridRoot.saveLayout();
            }

            Rectangle {
                anchors.fill: parent
                color: stashDropArea.containsDrag ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.08) : Theme.surface
                border.color: Theme.outline_variant
                border.width: 1
                radius: 16
                
                Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.OutCubic } }

                GridView {
                    id: availableFlow
                    anchors.fill: parent
                    anchors.margins: 8
                    
                    cellWidth: width / 2
                    cellHeight: 64
                    
                    // Allow scrollbar width if needed, but clip:false helps.
                    boundsBehavior: Flickable.StopAtBounds
                    clip: !moduleGridRoot.isEditorMode

                    move: Transition {
                        NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutCubic }
                    }
                    
                    model: availableVisualModel
                }
            }
        }
    }
}
