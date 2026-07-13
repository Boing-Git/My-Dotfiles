import QtQuick
import Quickshell
import Quickshell.Services.Desktop

Item {
    Component.onCompleted: {
        console.log("Desktop entries:", typeof DesktopEntries);
        Qt.quit();
    }
}
