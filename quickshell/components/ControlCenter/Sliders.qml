import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import "../../Variables/variables.js" as Vars
import "../.."

ColumnLayout {
    id: sliders
    Layout.fillWidth: true
    spacing: 8

    property var audioNode: Pipewire.defaultAudioSink
    property real currentVolume: audioNode && audioNode.audio ? audioNode.audio.volume : 0.0
    property real currentBrightness: 0.5 // Default fallback

    Component.onCompleted: {
        ddcQueryProcess.running = true;
    }

    Process {
        id: ddcQueryProcess
        command: ["ddcutil", "getvcp", "10", "-t"]
        stdout: StdioCollector {
            onStreamFinished: {
                let parts = this.text.trim().split(" ");
                if (parts.length >= 4) {
                    let b = parseInt(parts[3]);
                    if (!isNaN(b)) {
                        currentBrightness = b / 100.0;
                    }
                }
            }
        }
    }

    Timer {
        id: ddcSetTimer
        interval: 100 // Debounce to avoid overloading the I2C bus
        onTriggered: {
            let b = Math.round(currentBrightness * 100);
            ddcSetProcess.command = ["ddcutil", "setvcp", "10", b.toString()];
            ddcSetProcess.running = true;
        }
    }

    Process {
        id: ddcSetProcess
    }

    Slider {
        id: volumeSlider
        Layout.fillWidth: true
        implicitWidth: 320
        implicitHeight: 48 // Strict M3 48dp minimum touch target bounding box
        padding: 0
        
        value: currentVolume
        onMoved: {
            if (audioNode)
                audioNode.audio.volume = value;
        }

        // Internal geometry variables
        property int trackHeight: 32
        property int gap: 4
        property int handleWidth: 12

        background: Item {
            x: volumeSlider.leftPadding
            y: volumeSlider.topPadding + (volumeSlider.availableHeight - volumeSlider.trackHeight) / 2
            width: volumeSlider.availableWidth
            height: volumeSlider.trackHeight

            // 1. LEFT TRACK (Active Fill)
            Item {
                x: 0
                y: 0
                width: Math.max(0, (volumeSlider.visualPosition * (volumeSlider.availableWidth - volumeSlider.handleWidth)) - volumeSlider.gap)
                height: parent.height
                clip: true 

                Rectangle {
                    width: volumeSlider.availableWidth
                    height: parent.height
                    radius: 12
                    color: Theme.primary 
                    
                    // Overlay Icon
                    Text {
                        x: 16 // Must match leftMargin
                        anchors.verticalCenter: parent.verticalCenter
                        text: audioNode && audioNode.audio.muted ? "\ue04f" : "\ue050"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Theme.on_primary
                    }
                }
            }

            // 2. RIGHT TRACK (Inactive Base)
            Item {
                x: (volumeSlider.visualPosition * (volumeSlider.availableWidth - volumeSlider.handleWidth)) + volumeSlider.handleWidth + volumeSlider.gap
                y: 0
                width: Math.max(0, volumeSlider.availableWidth - x)
                height: parent.height
                clip: true 

                Rectangle {
                    x: -parent.x 
                    width: volumeSlider.availableWidth
                    height: parent.height
                    radius: 12
                    color: Theme.surface_variant 
                    
                    // Base Icon
                    Text {
                        x: 16 // Must match leftMargin
                        anchors.verticalCenter: parent.verticalCenter
                        text: audioNode && audioNode.audio.muted ? "\ue04f" : "\ue050"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Theme.on_surface_variant
                    }
                }
            }
        }

        // 3. THE HANDLE
        handle: Rectangle {
            x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
            y: volumeSlider.topPadding + (volumeSlider.availableHeight - height) / 2
            
            width: volumeSlider.handleWidth
            height: volumeSlider.implicitHeight 
            radius: width / 2
            color: Theme.on_surface 
        }
    }

    Slider {
        id: brightnessSlider
        Layout.fillWidth: true
        implicitWidth: 320
        implicitHeight: 48 // Strict M3 48dp minimum touch target bounding box
        padding: 0
        
        value: currentBrightness
        onMoved: {
            currentBrightness = value;
            ddcSetTimer.restart();
        }

        // Internal geometry variables
        property int trackHeight: 32
        property int gap: 4
        property int handleWidth: 12

        background: Item {
            x: brightnessSlider.leftPadding
            y: brightnessSlider.topPadding + (brightnessSlider.availableHeight - brightnessSlider.trackHeight) / 2
            width: brightnessSlider.availableWidth
            height: brightnessSlider.trackHeight

            // 1. LEFT TRACK (Active Fill)
            Item {
                x: 0
                y: 0
                width: Math.max(0, (brightnessSlider.visualPosition * (brightnessSlider.availableWidth - brightnessSlider.handleWidth)) - brightnessSlider.gap)
                height: parent.height
                clip: true 

                Rectangle {
                    width: brightnessSlider.availableWidth
                    height: parent.height
                    radius: 12
                    color: Theme.primary 
                    
                    // Overlay Icon
                    Text {
                        x: 16 // Must match leftMargin
                        anchors.verticalCenter: parent.verticalCenter
                        text: "\ue518"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Theme.on_primary
                    }
                }
            }

            // 2. RIGHT TRACK (Inactive Base)
            Item {
                x: (brightnessSlider.visualPosition * (brightnessSlider.availableWidth - brightnessSlider.handleWidth)) + brightnessSlider.handleWidth + brightnessSlider.gap
                y: 0
                width: Math.max(0, brightnessSlider.availableWidth - x)
                height: parent.height
                clip: true 

                Rectangle {
                    x: -parent.x 
                    width: brightnessSlider.availableWidth
                    height: parent.height
                    radius: 12
                    color: Theme.surface_variant 
                    
                    // Base Icon
                    Text {
                        x: 16 // Must match leftMargin
                        anchors.verticalCenter: parent.verticalCenter
                        text: "\ue518"
                        font.family: "Material Symbols Outlined"
                        font.pixelSize: 20
                        color: Theme.on_surface_variant
                    }
                }
            }
        }

        // 3. THE HANDLE
        handle: Rectangle {
            x: brightnessSlider.leftPadding + brightnessSlider.visualPosition * (brightnessSlider.availableWidth - width)
            y: brightnessSlider.topPadding + (brightnessSlider.availableHeight - height) / 2
            
            width: brightnessSlider.handleWidth
            height: brightnessSlider.implicitHeight 
            radius: width / 2
            color: Theme.on_surface 
        }
    }
}
