import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 200
    height: 400
    visible: true

    ListModel {
        id: model
        ListElement { name: "A1"; cat: "A" }
        ListElement { name: "A2"; cat: "A" }
        ListElement { name: "B1"; cat: "B" }
        ListElement { name: "B2"; cat: "B" }
    }

    ListView {
        anchors.fill: parent
        model: model
        section.property: "cat"
        delegate: Rectangle {
            width: parent.width; height: 50
            border.color: "black"
            Text { text: name + " prev:" + ListView.previousSection + " curr:" + ListView.section + " next:" + ListView.nextSection }
        }
    }
}
