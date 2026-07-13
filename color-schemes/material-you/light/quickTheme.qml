pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	
		readonly property color background: "#f6f9fe"
	
		readonly property color error: "#ba1a1a"
	
		readonly property color error_container: "#ffdad6"
	
		readonly property color inverse_on_surface: "#eef1f6"
	
		readonly property color inverse_primary: "#94cdf7"
	
		readonly property color inverse_surface: "#2d3135"
	
		readonly property color on_background: "#181c20"
	
		readonly property color on_error: "#ffffff"
	
		readonly property color on_error_container: "#410002"
	
		readonly property color on_primary: "#ffffff"
	
		readonly property color on_primary_container: "#001e2e"
	
		readonly property color on_primary_fixed: "#001e2e"
	
		readonly property color on_primary_fixed_variant: "#004c6d"
	
		readonly property color on_secondary: "#ffffff"
	
		readonly property color on_secondary_container: "#0b1d29"
	
		readonly property color on_secondary_fixed: "#0b1d29"
	
		readonly property color on_secondary_fixed_variant: "#384956"
	
		readonly property color on_surface: "#181c20"
	
		readonly property color on_surface_variant: "#41484d"
	
		readonly property color on_tertiary: "#ffffff"
	
		readonly property color on_tertiary_container: "#1f1635"
	
		readonly property color on_tertiary_fixed: "#1f1635"
	
		readonly property color on_tertiary_fixed_variant: "#4b4163"
	
		readonly property color outline: "#71787e"
	
		readonly property color outline_variant: "#c1c7ce"
	
		readonly property color primary: "#246488"
	
		readonly property color primary_container: "#c8e6ff"
	
		readonly property color primary_fixed: "#c8e6ff"
	
		readonly property color primary_fixed_dim: "#94cdf7"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#4f606e"
	
		readonly property color secondary_container: "#d3e5f5"
	
		readonly property color secondary_fixed: "#d3e5f5"
	
		readonly property color secondary_fixed_dim: "#b7c9d8"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#3a5d75"
	
		readonly property color surface: "#f6f9fe"
	
		readonly property color surface_bright: "#f6f9fe"
	
		readonly property color surface_container: "#ebeef3"
	
		readonly property color surface_container_high: "#e5e8ed"
	
		readonly property color surface_container_highest: "#dfe3e8"
	
		readonly property color surface_container_low: "#f1f4f9"
	
		readonly property color surface_container_lowest: "#ffffff"
	
		readonly property color surface_dim: "#d7dadf"
	
		readonly property color surface_tint: "#246488"
	
		readonly property color surface_variant: "#dde3ea"
	
		readonly property color tertiary: "#63597c"
	
		readonly property color tertiary_container: "#e9ddff"
	
		readonly property color tertiary_fixed: "#e9ddff"
	
		readonly property color tertiary_fixed_dim: "#cec0e8"
	
}