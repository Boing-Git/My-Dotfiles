import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 200
    height: 200
    visible: true

    Rectangle {
        anchors.fill: parent
        anchors.margins: 20
        color: "blue"
        topLeftRadius: 20
        bottomRightRadius: 20
    }
}
