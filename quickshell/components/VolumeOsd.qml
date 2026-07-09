import QtQuick
import QtQuick.Effects
import ".."
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../Variables/variables.js" as Vars

Item {
    id: mainContainer
    
    width: bg.width
    height: 40

    property bool isVisible: false
    property bool preventShow: false
    property bool gameMode: false
    property real smoothVolume: Pipewire.defaultAudioSink?.audio?.volume ?? 0

    onPreventShowChanged: {
        if (preventShow) {
            isVisible = false;
            hideTimer.stop();
        }
    }

    property string volumeIcon: {
        let isMuted = Pipewire.defaultAudioSink?.audio?.muted ?? false;
        let vol = Pipewire.defaultAudioSink?.audio?.volume ?? 0;

        if (isMuted || vol <= 0.0)
            return "\uE04F";
        if (vol < 0.5)
            return "\uE04D";
        return "\uE050";
    }

    Behavior on smoothVolume {
        enabled: !mainContainer.gameMode
        NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3Standard }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property real actualVolume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
    property bool actualMuted: Pipewire.defaultAudioSink?.audio?.muted ?? false

    onActualVolumeChanged: triggerShow()
    onActualMutedChanged: triggerShow()

    function triggerShow() {
        if (!preventShow) {
            mainContainer.isVisible = true;
            if (!hoverArea.containsMouse && !sliderMouseArea.pressed) {
                hideTimer.restart();
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 1500
        onTriggered: {
            if (!hoverArea.containsMouse && !sliderMouseArea.pressed) {
                mainContainer.isVisible = false;
            }
        }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        
        onContainsMouseChanged: {
            if (containsMouse && isVisible) {
                hideTimer.stop();
            } else if (!containsMouse && isVisible && !sliderMouseArea.pressed) {
                hideTimer.restart();
            }
        }

        onWheel: (wheel) => {
            if (Pipewire.defaultAudioSink?.audio) {
                let delta = wheel.angleDelta.y > 0 ? 0.02 : -0.02;
                let newVol = Math.max(0.0, Math.min(1.0, Pipewire.defaultAudioSink.audio.volume + delta));
                Pipewire.defaultAudioSink.audio.volume = newVol;
            }
        }
    }

    Rectangle {
        id: bg
        layer.enabled: true
        layer.effect: MultiEffect { shadowEnabled: true; shadowBlur: 1.0; shadowColor: Qt.rgba(0,0,0,0.25); shadowVerticalOffset: 4; shadowHorizontalOffset: 0 }
        anchors.centerIn: parent
        color: Theme.surface_container_high
        radius: mainContainer.gameMode ? 0 : height / 2
        clip: true

        width: mainContainer.isVisible ? 250 : 100
        height: 40
        
        opacity: mainContainer.isVisible ? 1.0 : 0.0
        visible: opacity > 0

        Behavior on width { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }
        Behavior on opacity { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3Standard } }

        RowLayout {
            anchors.fill: parent
            anchors.margins: Vars.spacingSmall
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 16
            
            opacity: mainContainer.isVisible ? 1.0 : 0.0
            Behavior on opacity { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3Standard } }

            Text {
                id: iconText
                Layout.alignment: Qt.AlignVCenter
                transformOrigin: Item.Center

                font.family: "Material Symbols Outlined"
                font.pixelSize: 20
                color: Theme.primary
                text: mainContainer.volumeIcon

                onTextChanged: {
                    if (!iconPop.running) {
                        iconPop.restart();
                    }
                }

                SequentialAnimation {
                    id: iconPop
                    // Disable icon pop when in game mode
                    NumberAnimation { target: iconText; property: "scale"; to: mainContainer.gameMode ? 1.0 : 1.25; duration: mainContainer.gameMode ? 0 : Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast }
                    NumberAnimation { target: iconText; property: "scale"; to: 1.0; duration: mainContainer.gameMode ? 0 : Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast }
                }

                MouseArea {
                    id: muteHover
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    enabled: mainContainer.isVisible
                    onClicked: {
                        if (Pipewire.defaultAudioSink?.audio) {
                            Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
                        }
                    }
                }
                Rectangle {
                    anchors.fill: parent
                    radius: Vars.radiusMedium
                    color: Theme.primary
                    opacity: muteHover.pressed ? 0.12 : (muteHover.containsMouse ? 0.08 : 0.0)
                    Behavior on opacity { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3Standard } }
                }
            }

            Rectangle {
                id: sliderTrack
                Layout.fillWidth: true
                implicitHeight: sliderMouseArea.containsMouse ? 12 : 8
                color: Theme.surface_variant
                radius: Vars.radiusSmall
                
                Behavior on implicitHeight { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }

                Rectangle {
                    id: fillBar
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    color: Theme.primary
                    radius: parent.radius
                    width: parent.width * mainContainer.smoothVolume
                    
                    Behavior on color { enabled: !mainContainer.gameMode; ColorAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3Standard } }
                }
                
                Rectangle {
                    id: sliderHandle
                    width: 16
                    height: 16
                    radius: 8
                    anchors.verticalCenter: parent.verticalCenter
                    x: Math.max(0, Math.min(fillBar.width - width / 2, parent.width - width))
                    color: Theme.primary
                    
                    scale: sliderMouseArea.pressed ? 1.4 : (sliderMouseArea.containsMouse ? 1.2 : 0.0)
                    opacity: scale > 0.0 ? 1.0 : 0.0
                    
                    Behavior on scale { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3ExpressiveSpatialFast } }
                    Behavior on opacity { enabled: !mainContainer.gameMode; NumberAnimation { duration: Vars.animationDuration; easing.type: Easing.BezierSpline; easing.bezierCurve: Vars.m3Standard } }
                }

                MouseArea {
                    id: sliderMouseArea
                    anchors.fill: parent
                    anchors.margins: -12
                    hoverEnabled: true
                    preventStealing: true
                    enabled: mainContainer.isVisible

                    function dragVolume(mouse) {
                        if (Pipewire.defaultAudioSink?.audio) {
                            let percentage = Math.max(0.0, Math.min(1.0, mouse.x / width));
                            Pipewire.defaultAudioSink.audio.volume = percentage;
                        }
                    }

                    onPressed: (mouse) => dragVolume(mouse)
                    onPositionChanged: (mouse) => {
                        if (pressed) dragVolume(mouse);
                    }
                    onReleased: {
                        if (!hoverArea.containsMouse) {
                            hideTimer.restart();
                        }
                    }
                }
            }
        }
    }
}