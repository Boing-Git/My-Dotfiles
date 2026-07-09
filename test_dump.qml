import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Bluetooth

Item {
    Component.onCompleted: {
        var adapter = Bluetooth.defaultAdapter;
        if (adapter) {
            console.log("Bluetooth adapter properties:");
            for (var p in adapter) {
                console.log(p);
            }
        }
        var wifi = Networking.devices.values.find(d => d.type === DeviceType.Wifi);
        if (wifi) {
            console.log("WiFi device properties:");
            for (var p in wifi) {
                console.log(p);
            }
        }
        Quickshell.exit(0);
    }
}
