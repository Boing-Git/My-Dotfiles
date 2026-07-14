import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import "../../Variables/variables.js" as Vars
import "../.."

Rectangle {
    id: mediaPlayerRoot
    
    property var preferredMprisPlayer: null
    property var mprisPlayer: {
        let vals = Mpris.players.values;
        if (vals.length === 0) return null;
        if (preferredMprisPlayer && vals.indexOf(preferredMprisPlayer) !== -1) {
            return preferredMprisPlayer;
        }
        return vals[0];
    }
    property bool isPlaying: mprisPlayer ? mprisPlayer.isPlaying : false

    Layout.fillWidth: true
    Layout.preferredHeight: 220
    radius: 16
    color: Theme.surface_container_highest
    clip: true
    property int slideDirection: 1

    property real timeScale: mprisPlayer && mprisPlayer.length > 10000000 ? 1000000 : (mprisPlayer && mprisPlayer.length > 10000 ? 1000 : 1)

    function formatTime(val) {
        if (isNaN(val) || val <= 0) return "0:00";
        let totalSeconds = Math.floor(val / timeScale);
        let mins = Math.floor(totalSeconds / 60);
        let secs = Math.floor(totalSeconds % 60);
        return mins + ":" + (secs < 10 ? "0" : "") + secs;
    }

    Timer {
        interval: 1000
        repeat: true
        running: mprisPlayer && mprisPlayer.isPlaying
        onTriggered: {
            if (mprisPlayer && typeof mprisPlayer.positionChanged === "function") {
                mprisPlayer.positionChanged();
            }
        }
    }

    // Background Image Sliding Container
    Item {
        id: albumArtContainer
        anchors.fill: parent
        property string currentUrl: mprisPlayer && mprisPlayer.trackArtUrl ? mprisPlayer.trackArtUrl : ""
        property string oldUrl: ""

        onCurrentUrlChanged: {
            if (oldUrl !== "" && currentUrl !== "" && oldUrl !== currentUrl) {
                albumArtOld.source = oldUrl;
                albumArtOld.x = 0;
                albumArtOld.visible = true;
                
                albumArtNew.x = mediaPlayerRoot.slideDirection * width;
                
                slideOutOld.to = -mediaPlayerRoot.slideDirection * width;
                slideAnim.restart();
            } else if (currentUrl !== "") {
                albumArtNew.x = 0;
                albumArtOld.visible = false;
            } else {
                albumArtOld.visible = false;
            }
            oldUrl = currentUrl;
            mediaPlayerRoot.slideDirection = 1;
        }

        Image {
            id: albumArtOld
            width: parent.width; height: parent.height
            fillMode: Image.PreserveAspectCrop
            visible: false
        }

        Image {
            id: albumArtNew
            width: parent.width; height: parent.height
            source: albumArtContainer.currentUrl
            fillMode: Image.PreserveAspectCrop
            opacity: source !== "" ? 1.0 : 0.0
            Behavior on opacity { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: albumArtNew.source !== "" ? Vars.customEmphasizedDecelerate : Vars.customEmphasizedAccelerate } }
        }

        ParallelAnimation {
            id: slideAnim
            NumberAnimation { 
                id: slideOutOld
                target: albumArtOld; property: "x"; duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow 
            }
            NumberAnimation { 
                target: albumArtNew; property: "x"; to: 0; duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow 
            }
            onFinished: {
                albumArtOld.visible = false;
            }
        }
    }
    
    // Corner masks to simulate rounding against the Control Center background
    Item {
        id: cornerMasks
        anchors.fill: parent
        visible: albumArtContainer.currentUrl !== ""

        property real r: 16
        property color maskColor: Theme.surface_container_low
        z: 5 // Bring to front above the gradient overlay
        
        // Top-Left
        Item {
            x: 0; y: 0; width: cornerMasks.r; height: cornerMasks.r; clip: true
            Rectangle {
                x: -cornerMasks.r; y: -cornerMasks.r; width: cornerMasks.r * 4; height: cornerMasks.r * 4; radius: cornerMasks.r * 2
                color: "transparent"; border.color: cornerMasks.maskColor; border.width: cornerMasks.r
            }
        }
        // Top-Right
        Item {
            x: parent.width - cornerMasks.r; y: 0; width: cornerMasks.r; height: cornerMasks.r; clip: true
            Rectangle {
                x: -cornerMasks.r * 2; y: -cornerMasks.r; width: cornerMasks.r * 4; height: cornerMasks.r * 4; radius: cornerMasks.r * 2
                color: "transparent"; border.color: cornerMasks.maskColor; border.width: cornerMasks.r
            }
        }
        // Bottom-Left
        Item {
            x: 0; y: parent.height - cornerMasks.r; width: cornerMasks.r; height: cornerMasks.r; clip: true
            Rectangle {
                x: -cornerMasks.r; y: -cornerMasks.r * 2; width: cornerMasks.r * 4; height: cornerMasks.r * 4; radius: cornerMasks.r * 2
                color: "transparent"; border.color: cornerMasks.maskColor; border.width: cornerMasks.r
            }
        }
        // Bottom-Right
        Item {
            x: parent.width - cornerMasks.r; y: parent.height - cornerMasks.r; width: cornerMasks.r; height: cornerMasks.r; clip: true
            Rectangle {
                x: -cornerMasks.r * 2; y: -cornerMasks.r * 2; width: cornerMasks.r * 4; height: cornerMasks.r * 4; radius: cornerMasks.r * 2
                color: "transparent"; border.color: cornerMasks.maskColor; border.width: cornerMasks.r
            }
        }
    }
    
    // Fallback background icon when no album art
    Item {
        anchors.fill: parent
        visible: !mprisPlayer || !mprisPlayer.trackArtUrl
        
        Text {
            anchors.centerIn: parent
            font.family: "Material Symbols Outlined"
            font.pixelSize: 120
            color: Theme.primary
            opacity: 0.15
            text: "\ue405" // audiotrack
        }
    }

    Rectangle {
        anchors.fill: parent
        visible: mprisPlayer && mprisPlayer.trackArtUrl !== ""
        z: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.4; color: "transparent" }
            GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.95) }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Vars.spacingLarge
        spacing: Vars.spacingSmall
        
        // Spacer to push content down if needed, or rely on fillHeight
        Item { Layout.fillWidth: true; Layout.fillHeight: true }

        // Metadata and Controls row
        RowLayout {
            Layout.fillWidth: true
            spacing: Vars.spacingMedium
            
            // Text Column
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                
                Text { 
                    text: mprisPlayer ? (mprisPlayer.trackTitle || (mprisPlayer.metadata ? mprisPlayer.metadata["xesam:title"] : null) || mprisPlayer.identity || "Unknown Title") : "No Media Playing"
                    font.family: Vars.fontFamily
                    font.pixelSize: 20
                    font.weight: 700
                    color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_surface
                    Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                Text { 
                    text: mprisPlayer && mprisPlayer.trackArtist ? mprisPlayer.trackArtist : "Artist"
                    font.family: Vars.fontFamily
                    font.pixelSize: 14
                    color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_surface
                    Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                    opacity: 0.8
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                Text { 
                    text: mprisPlayer && mprisPlayer.trackAlbum ? mprisPlayer.trackAlbum : ""
                    font.family: Vars.fontFamily
                    font.pixelSize: 12
                    color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_surface
                    Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                    opacity: 0.6
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    visible: text !== ""
                }
            }
            
            RowLayout {
                spacing: 12
                Layout.alignment: Qt.AlignBottom
                
                Rectangle {
                    width: 32; height: 32; radius: 16; color: "transparent"
                    Text { 
                        anchors.centerIn: parent; font.family: "Material Symbols Outlined"; font.pixelSize: 24
                        color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_primary_container; text: "\ue045" 
                        Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                    }
                    MouseArea { anchors.fill: parent; onClicked: { mediaPlayerRoot.slideDirection = -1; if(mprisPlayer) mprisPlayer.previous(); } cursorShape: Qt.PointingHandCursor }
                }
                
                Rectangle {
                    width: 56; height: 56; radius: 28; color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.primary
                    Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                    Text { 
                        anchors.centerIn: parent; font.family: "Material Symbols Outlined"; font.pixelSize: 32; color: mprisPlayer && mprisPlayer.trackArtUrl ? "black" : Theme.on_surface
                        Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                        text: mprisPlayer && mprisPlayer.isPlaying ? "\ue034" : "\ue037"
                    }
                    MouseArea { 
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: if(mprisPlayer) {
                            if (typeof mprisPlayer.togglePlaying === "function") mprisPlayer.togglePlaying();
                            else if (typeof mprisPlayer.playPause === "function") mprisPlayer.playPause();
                        } 
                    }
                }

                Rectangle {
                    width: 32; height: 32; radius: 16; color: "transparent"
                    Text { 
                        anchors.centerIn: parent; font.family: "Material Symbols Outlined"; font.pixelSize: 24
                        color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_primary_container; text: "\ue044" 
                        Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
                    }
                    MouseArea { anchors.fill: parent; onClicked: { mediaPlayerRoot.slideDirection = 1; if(mprisPlayer) mprisPlayer.next(); } cursorShape: Qt.PointingHandCursor }
                }
            }
        }

        Item { Layout.preferredHeight: 16 }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            radius: 2
            color: mprisPlayer && mprisPlayer.trackArtUrl ? Qt.rgba(1,1,1,0.3) : Qt.rgba(Theme.on_primary_container.r, Theme.on_primary_container.g, Theme.on_primary_container.b, 0.2)
            
            Rectangle {
                height: parent.height
                width: mprisPlayer && mprisPlayer.length > 0 && mprisPlayer.position !== undefined ? parent.width * (mprisPlayer.position / mprisPlayer.length) : 0
                radius: 2
                color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_primary_container
                Behavior on width { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customExpressiveSpatialSlow } }
                Behavior on color { ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.customStandard } }
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                function seekToMouse(mouse) {
                    if(mprisPlayer && mprisPlayer.length > 0) {
                        let ratio = Math.max(0, Math.min(1, mouse.x / width));
                        let newPos = ratio * mprisPlayer.length;
                        if (mprisPlayer.canSeek) {
                            mprisPlayer.position = newPos; 
                        }
                    }
                }
                onPressed: (mouse) => seekToMouse(mouse)
                onPositionChanged: (mouse) => { if (pressed) seekToMouse(mouse) }
            }
        }
    }

    // MPRIS Player Selector Toggle
    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: Vars.spacingMedium
        width: selectorRow.width + Vars.spacingLarge
        height: 28
        radius: height / 2
        color: selectorMouse.containsMouse ? Qt.rgba(255,255,255, 0.2) : Qt.rgba(255,255,255, 0.1)
        visible: Mpris.players.values.length > 1
        z: 5
        
        RowLayout {
            id: selectorRow
            anchors.centerIn: parent
            spacing: 4
            Text {
                text: mprisPlayer ? (mprisPlayer.identity || "Unknown") : ""
                font.family: Vars.fontFamily
                font.pixelSize: 13
                font.weight: 600
                color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_surface
            }
            Text {
                font.family: "Material Symbols Outlined"
                font.pixelSize: 16
                color: mprisPlayer && mprisPlayer.trackArtUrl ? "white" : Theme.on_surface
                text: playerDropdown.visible ? "\ue5ce" : "\ue5cf" // expand_less / expand_more
            }
        }
        
        MouseArea {
            id: selectorMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: playerDropdown.visible = !playerDropdown.visible
        }
    }
    
    // MPRIS Player Dropdown
    Rectangle {
        id: playerDropdown
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: Vars.spacingMedium + 28 + 4
        anchors.rightMargin: Vars.spacingMedium
        width: 180
        height: playerColumn.implicitHeight + 8
        radius: Vars.radiusMedium
        color: Theme.surface_container_highest
        border.color: Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.1)
        border.width: 1
        visible: false
        z: 10
        
        Column {
            id: playerColumn
            anchors.fill: parent
            anchors.margins: 4
            
            Repeater {
                model: Mpris.players.values
                delegate: Rectangle {
                    width: playerColumn.width
                    height: 36
                    radius: Vars.radiusSmall
                    color: itemMouse.containsMouse ? Qt.rgba(Theme.on_surface.r, Theme.on_surface.g, Theme.on_surface.b, 0.08) : "transparent"
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12
                        
                        Text {
                            text: modelData.identity || "Unknown"
                            font.family: Vars.fontFamily
                            font.pixelSize: 14
                            color: mprisPlayer === modelData ? Theme.primary : Theme.on_surface
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        Text {
                            font.family: "Material Symbols Outlined"
                            font.pixelSize: 18
                            color: Theme.primary
                            text: "\ue876" // check
                            visible: mprisPlayer === modelData
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    
                    MouseArea {
                        id: itemMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            mediaPlayerRoot.preferredMprisPlayer = modelData;
                            playerDropdown.visible = false;
                        }
                    }
                }
            }
        }
    }
}
