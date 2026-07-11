import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../../Variables/variables.js" as Vars
import "../.."

ColumnLayout {
    id: sliders
    
    Layout.fillWidth: true
    spacing: 16
    
    property var audioNode: Pipewire.defaultAudioSink
    property real currentVolume: audioNode && audioNode.audio ? audioNode.audio.volume : 0.0

    // Volume Row
    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 48
        spacing: 16

        Text { 
            font.family: "Material Symbols Outlined"; font.pixelSize: 24
            color: Theme.on_surface_variant
            text: audioNode && audioNode.audio.muted ? "\ue04f" : "\ue050" 
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Inactive Track
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: 16
                radius: 8
                color: Theme.surface_variant
            }
            // Active Track
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: Math.max(16, parent.width * currentVolume)
                height: 16
                radius: 8
                color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.4)
                Behavior on width { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }
            }
            // Thumb
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                x: Math.max(0, Math.min(parent.width - width, parent.width * currentVolume - width/2))
                width: 16
                height: 16
                radius: 8
                color: Theme.primary
                Behavior on x { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }
            }
            
            MouseArea {
                anchors.fill: parent
                onPositionChanged: (mouse) => { if(audioNode) audioNode.audio.volume = Math.max(0, Math.min(1, mouse.x / width)) }
                onPressed: (mouse) => { if(audioNode) audioNode.audio.volume = Math.max(0, Math.min(1, mouse.x / width)) }
            }
        }
    }

    // Brightness Row
    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 48
        spacing: 16

        Text { 
            font.family: "Material Symbols Outlined"; font.pixelSize: 24
            color: Theme.on_surface_variant
            text: "\ue518" 
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Inactive Track
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: 16
                radius: 8
                color: Theme.surface_variant
            }
            // Active Track
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: Math.max(16, parent.width * 0.35)
                height: 16
                radius: 8
                color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.4)
                Behavior on width { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }
            }
            // Thumb
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                x: Math.max(0, Math.min(parent.width - width, parent.width * 0.35 - width/2))
                width: 16
                height: 16
                radius: 8
                color: Theme.primary
                Behavior on x { NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }
            }
        }
    }
}
