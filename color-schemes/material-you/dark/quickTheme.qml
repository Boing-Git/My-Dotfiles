pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	
		readonly property color background: "#101417"
	
		readonly property color error: "#ffb4ab"
	
		readonly property color error_container: "#93000a"
	
		readonly property color inverse_on_surface: "#2d3135"
	
		readonly property color inverse_primary: "#246488"
	
		readonly property color inverse_surface: "#dfe3e8"
	
		readonly property color on_background: "#dfe3e8"
	
		readonly property color on_error: "#690005"
	
		readonly property color on_error_container: "#ffdad6"
	
		readonly property color on_primary: "#00344d"
	
		readonly property color on_primary_container: "#c8e6ff"
	
		readonly property color on_primary_fixed: "#001e2e"
	
		readonly property color on_primary_fixed_variant: "#004c6d"
	
		readonly property color on_secondary: "#21323f"
	
		readonly property color on_secondary_container: "#d3e5f5"
	
		readonly property color on_secondary_fixed: "#0b1d29"
	
		readonly property color on_secondary_fixed_variant: "#384956"
	
		readonly property color on_surface: "#dfe3e8"
	
		readonly property color on_surface_variant: "#c1c7ce"
	
		readonly property color on_tertiary: "#342b4b"
	
		readonly property color on_tertiary_container: "#e9ddff"
	
		readonly property color on_tertiary_fixed: "#1f1635"
	
		readonly property color on_tertiary_fixed_variant: "#4b4163"
	
		readonly property color outline: "#8b9198"
	
		readonly property color outline_variant: "#41484d"
	
		readonly property color primary: "#94cdf7"
	
		readonly property color primary_container: "#004c6d"
	
		readonly property color primary_fixed: "#c8e6ff"
	
		readonly property color primary_fixed_dim: "#94cdf7"
	
		readonly property color scrim: "#000000"
	
		readonly property color secondary: "#b7c9d8"
	
		readonly property color secondary_container: "#384956"
	
		readonly property color secondary_fixed: "#d3e5f5"
	
		readonly property color secondary_fixed_dim: "#b7c9d8"
	
		readonly property color shadow: "#000000"
	
		readonly property color source_color: "#3a5d75"
	
		readonly property color surface: "#101417"
	
		readonly property color surface_bright: "#353a3e"
	
		readonly property color surface_container: "#1c2024"
	
		readonly property color surface_container_high: "#262a2e"
	
		readonly property color surface_container_highest: "#313539"
	
		readonly property color surface_container_low: "#181c20"
	
		readonly property color surface_container_lowest: "#0a0f12"
	
		readonly property color surface_dim: "#101417"
	
		readonly property color surface_tint: "#94cdf7"
	
		readonly property color surface_variant: "#41484d"
	
		readonly property color tertiary: "#cec0e8"
	
		readonly property color tertiary_container: "#4b4163"
	
		readonly property color tertiary_fixed: "#e9ddff"
	
		readonly property color tertiary_fixed_dim: "#cec0e8"
	
}