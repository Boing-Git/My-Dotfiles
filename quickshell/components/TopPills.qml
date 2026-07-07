import QtQuick
import ".."
import QtQuick.Layouts
import Quickshell
import "../Variables/variables.js" as Vars

PanelWindow {
    id: topWindow
    exclusionMode: ExclusionMode.Normal
    exclusiveZone: 50
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 750
    color: "transparent"

    signal popupOpened

    function closeAll() {
        launcherItem.expanded = false;
        controlCenterItem.expanded = false;
        wallpaperSwitcherItem.expanded = false;
        colorSchemeSwitcherItem.expanded = false;
        powerMenuItem.expanded = false;
        emojiPickerItem.expanded = false;
        notificationPopupItem.expanded = false;
    }

    // 1. The Mask Region Array
    mask: Region {
        Region {
            item: topBarMask
        }
        Region {
            item: controlCenterItem.panelMask
        }
        Region {
            item: launcherItem.panelMask
        }
        Region {
            item: powerMenuItem.panelMask
        }
        Region {
            item: polkitItem.panelMask
        }
        Region {
            item: wallpaperSwitcherItem.panelMask
        }
        Region {
            item: colorSchemeSwitcherItem.panelMask
        }
        Region {
            item: notificationPopupItem.panelMask
        }
        Region {
            item: emojiPickerItem.panelMask
        }
    }

    // 2. Fixed Top Bar Mask
    Item {
        id: topBarMask
        width: parent.width
        height: 70
    }

    // --- Main UI Content ---
    Item {
        anchors.fill: parent

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Vars.spacingSmall
            anchors.rightMargin: Vars.spacingSmall
            anchors.topMargin: Vars.spacingSmall
            anchors.bottomMargin: Vars.spacingSmall

            Item {
                Layout.fillWidth: true
            }

            Item {
                Layout.fillWidth: true
            }

            StatusBar {
                Layout.alignment: Qt.AlignTop
            }
        }
    }

    ClockPill {
        id: clockPill
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        opacity: notificationPopupItem.expanded ? 0.0 : 1.0
        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }

        onClicked: {
            toggleControlCenter();
        }
        onRightClicked: {
            toggleLauncher();
        }
        onScrolled: delta => {
            if (workspacesItem) {
                workspacesItem.handleScroll(delta);
            }
        }
    }

    HyprWorkspaces {
        id: workspacesItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
    }

    Launcher {
        id: launcherItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        width: 100
        height: 40
        focusWindow: topWindow

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function toggleLauncher() {
        if (!polkitItem.expanded) {
            if (launcherItem.expanded && !launcherItem.searchText.startsWith("/")) {
                launcherItem.expanded = false;
            } else {
                topWindow.popupOpened();
                launcherItem.expanded = true;
                launcherItem.searchText = "";
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function toggleControlCenter() {
        if (!polkitItem.expanded) {
            controlCenterItem.expanded = !controlCenterItem.expanded;
            if (controlCenterItem.expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function toggleWallpaper() {
        if (!polkitItem.expanded) {
            wallpaperSwitcherItem.expanded = !wallpaperSwitcherItem.expanded;
            if (wallpaperSwitcherItem.expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function toggleColorScheme() {
        if (!polkitItem.expanded) {
            colorSchemeSwitcherItem.expanded = !colorSchemeSwitcherItem.expanded;
            if (colorSchemeSwitcherItem.expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function togglePowerMenu() {
        if (!polkitItem.expanded) {
            powerMenuItem.expanded = !powerMenuItem.expanded;
            if (powerMenuItem.expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function toggleEmojiPicker() {
        if (!polkitItem.expanded) {
            if (launcherItem.expanded && launcherItem.searchText === "/emoji ") {
                launcherItem.expanded = false;
            } else {
                topWindow.popupOpened();
                launcherItem.expanded = true;
                launcherItem.searchText = "/emoji ";
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    function toggleClipboard() {
        if (!polkitItem.expanded) {
            if (launcherItem.expanded && launcherItem.searchText === "/clipboard ") {
                launcherItem.expanded = false;
            } else {
                topWindow.popupOpened();
                launcherItem.expanded = true;
                launcherItem.searchText = "/clipboard ";
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    PowerMenu {
        id: powerMenuItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        width: 100
        height: 40
        focusWindow: topWindow

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    PolkitDialog {
        id: polkitItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        width: 100
        height: 40
        focusWindow: topWindow

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    NotificationPopup {
        id: notificationPopupItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        width: 100
        height: 40
        focusWindow: topWindow

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
    }

    ControlCenter {
        id: controlCenterItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        width: 100
        height: 40
        focusWindow: topWindow
        forceHidePill: launcherItem.expanded || volumeOsdItem.isVisible || wallpaperSwitcherItem.expanded || colorSchemeSwitcherItem.expanded || powerMenuItem.expanded || polkitItem.expanded || notificationPopupItem.expanded || emojiPickerItem.expanded

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }
        
        onOpenColorSchemeRequested: {
            toggleColorScheme();
        }
    }

    VolumeOsd {
        id: volumeOsdItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        preventShow: launcherItem.expanded || controlCenterItem.expanded || wallpaperSwitcherItem.expanded || colorSchemeSwitcherItem.expanded || powerMenuItem.expanded || polkitItem.expanded || notificationPopupItem.expanded || emojiPickerItem.expanded || launcherItem.panel.width > 105 || controlCenterItem.panel.width > 105 || powerMenuItem.panel.width > 105 || polkitItem.panel.width > 105 || notificationPopupItem.panel.width > 105 || emojiPickerItem.panel.width > 105 || wallpaperSwitcherItem.panel.width > 105 || colorSchemeSwitcherItem.panel.width > 105
    }

    WallpaperSwitcher {
        id: wallpaperSwitcherItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        focusWindow: topWindow
        forceHidePill: launcherItem.expanded || controlCenterItem.expanded || colorSchemeSwitcherItem.expanded || powerMenuItem.expanded || polkitItem.expanded || notificationPopupItem.expanded || emojiPickerItem.expanded || volumeOsdItem.isVisible

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }

        onCloseRequested: expanded = false
    }

    EmojiPicker {
        id: emojiPickerItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        width: 100
        height: 40
        focusWindow: topWindow

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                colorSchemeSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
            }
        }
    }

    ColorSchemeSwitcher {
        id: colorSchemeSwitcherItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        focusWindow: topWindow
        forceHidePill: launcherItem.expanded || controlCenterItem.expanded || wallpaperSwitcherItem.expanded || powerMenuItem.expanded || polkitItem.expanded || notificationPopupItem.expanded || emojiPickerItem.expanded || volumeOsdItem.isVisible

        onExpandedChanged: {
            if (expanded) {
                topWindow.popupOpened();
                launcherItem.expanded = false;
                controlCenterItem.expanded = false;
                wallpaperSwitcherItem.expanded = false;
                powerMenuItem.expanded = false;
                emojiPickerItem.expanded = false;
            }
        }

        onCloseRequested: expanded = false
    }
}
