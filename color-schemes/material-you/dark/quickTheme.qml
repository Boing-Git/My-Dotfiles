pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	
		readonly property color background: "#131313"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#303030"
	
		readonly property color inverse_primary: "#5e5e5e"
	
		readonly property color inverse_surface: "#e2e2e2"
	
		readonly property color on_background: "#e2e2e2"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#1b1b1b"
	
		readonly property color on_primary_container: "#000000"
	
		readonly property color on_primary_fixed: "#ffffff"
	
		readonly property color on_primary_fixed_variant: "#e2e2e2"
	
		readonly property color on_secondary: "#1b1b1b"
	
		readonly property color on_secondary_container: "#e2e2e2"
	
		readonly property color on_secondary_fixed: "#1b1b1b"
	
		readonly property color on_secondary_fixed_variant: "#3b3b3b"
	
		readonly property color on_surface: "#e2e2e2"
	
		readonly property color on_surface_variant: "#c6c6c6"
	
		readonly property color on_tertiary: "#1b1b1b"
	
		readonly property color on_tertiary_container: "#000000"
	
		readonly property color on_tertiary_fixed: "#ffffff"
	
		readonly property color on_tertiary_fixed_variant: "#e2e2e2"
	
		readonly property color outline: "#919191"
	
		readonly property color outline_variant: "#474747"
	
		readonly property color primary: "#ffffff"
	
		readonly property color primary_container: "#d4d4d4"
	
		readonly property color primary_fixed: "#5e5e5e"
	
		readonly property color primary_fixed_dim: "#474747"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#c6c6c6"
	
		readonly property color secondary_container: "#474747"
	
		readonly property color secondary_fixed: "#c6c6c6"
	
		readonly property color secondary_fixed_dim: "#ababab"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#6a645a"
	
		readonly property color surface: "#131313"
	
		readonly property color surface_bright: "#393939"
	
		readonly property color surface_container: "#1f1f1f"
	
		readonly property color surface_container_high: "#2a2a2a"
	
		readonly property color surface_container_highest: "#353535"
	
		readonly property color surface_container_low: "#1b1b1b"
	
		readonly property color surface_container_lowest: "#0e0e0e"
	
		readonly property color surface_dim: "#131313"
	
		readonly property color surface_tint: "#c6c6c6"
	
		readonly property color surface_variant: "#474747"
	
		readonly property color tertiary: "#e2e2e2"
	
		readonly property color tertiary_container: "#919191"
	
		readonly property color tertiary_fixed: "#5e5e5e"
	
		readonly property color tertiary_fixed_dim: "#474747"
	
}