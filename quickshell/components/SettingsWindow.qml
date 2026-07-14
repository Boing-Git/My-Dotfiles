import QtQuick
import Quickshell
import Quickshell.Wayland
import ".."

import "../Variables/variables.js" as Vars

Item {
    id: root
    
    signal requestWidgetToggle()
    
    // Only show the floating window if expanded is true
    property bool isActive: settingsContent.expanded

    Window {
        id: floatingWindow
        visible: root.isActive
        width: 900
        height: 650
        color: "transparent"
        
        // When the floating window is closed by the WM, update expanded state
        onVisibleChanged: {
            if (!visible) {
                settingsContent.expanded = false;
            }
        }
        
        SettingsApp {
            id: settingsContent
            anchors.fill: parent
            anchors.margins: 10
            
            expanded: false
            gameMode: false
            isFloatingInstance: true
            
            onDetachToggled: function(isFloating) {
                if (!isFloating) root.requestWidgetToggle();
            }
        }
    }
    
    function toggle() {
        settingsContent.expanded = !settingsContent.expanded;
    }
}
