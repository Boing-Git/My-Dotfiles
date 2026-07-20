pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	
		readonly property color background: "#f9f9f9"
	
		readonly property color error: "#ba1a1a"
	
		readonly property color error_container: "#ffdad6"
	
		readonly property color inverse_on_surface: "#f1f1f1"
	
		readonly property color inverse_primary: "#c6c6c6"
	
		readonly property color inverse_surface: "#303030"
	
		readonly property color on_background: "#1b1b1b"
	
		readonly property color on_error: "#ffffff"
	
		readonly property color on_error_container: "#410002"
	
		readonly property color on_primary: "#e2e2e2"
	
		readonly property color on_primary_container: "#ffffff"
	
		readonly property color on_primary_fixed: "#ffffff"
	
		readonly property color on_primary_fixed_variant: "#e2e2e2"
	
		readonly property color on_secondary: "#ffffff"
	
		readonly property color on_secondary_container: "#1b1b1b"
	
		readonly property color on_secondary_fixed: "#1b1b1b"
	
		readonly property color on_secondary_fixed_variant: "#3b3b3b"
	
		readonly property color on_surface: "#1b1b1b"
	
		readonly property color on_surface_variant: "#474747"
	
		readonly property color on_tertiary: "#e2e2e2"
	
		readonly property color on_tertiary_container: "#ffffff"
	
		readonly property color on_tertiary_fixed: "#ffffff"
	
		readonly property color on_tertiary_fixed_variant: "#e2e2e2"
	
		readonly property color outline: "#777777"
	
		readonly property color outline_variant: "#c6c6c6"
	
		readonly property color primary: "#000000"
	
		readonly property color primary_container: "#3b3b3b"
	
		readonly property color primary_fixed: "#5e5e5e"
	
		readonly property color primary_fixed_dim: "#474747"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#5e5e5e"
	
		readonly property color secondary_container: "#e2e2e2"
	
		readonly property color secondary_fixed: "#c6c6c6"
	
		readonly property color secondary_fixed_dim: "#ababab"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#6a645a"
	
		readonly property color surface: "#f9f9f9"
	
		readonly property color surface_bright: "#f9f9f9"
	
		readonly property color surface_container: "#eeeeee"
	
		readonly property color surface_container_high: "#e8e8e8"
	
		readonly property color surface_container_highest: "#e2e2e2"
	
		readonly property color surface_container_low: "#f3f3f3"
	
		readonly property color surface_container_lowest: "#ffffff"
	
		readonly property color surface_dim: "#dadada"
	
		readonly property color surface_tint: "#5e5e5e"
	
		readonly property color surface_variant: "#e2e2e2"
	
		readonly property color tertiary: "#3b3b3b"
	
		readonly property color tertiary_container: "#747474"
	
		readonly property color tertiary_fixed: "#5e5e5e"
	
		readonly property color tertiary_fixed_dim: "#474747"
	
}