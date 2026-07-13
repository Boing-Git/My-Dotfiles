pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	<* for name, value in colors *>
		readonly property color {{name}}: "{{value.dark.hex}}"
	<* endfor *>
}