pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	
		readonly property color background: Vars.translucent ? withAlpha("#191724", 0.7) : "#191724"
	
		readonly property color surface: Vars.translucent ? withAlpha("#191724", 0.7) : Vars.translucent ? withAlpha("#191724", 0.7) : "#191724"
	
		readonly property color surface_dim: Vars.translucent ? withAlpha("#403d52", 0.7) : Vars.translucent ? withAlpha("#403d52", 0.7) : "#403d52"
	
		readonly property color surface_bright: Vars.translucent ? withAlpha("#403d52", 0.7) : Vars.translucent ? withAlpha("#403d52", 0.7) : "#403d52"
	
		readonly property color surface_variant: Vars.translucent ? withAlpha("#403d52", 0.7) : Vars.translucent ? withAlpha("#403d52", 0.7) : "#403d52"
	
		readonly property color on_surface: "#e0def4"
	
		readonly property color on_surface_variant: "#6e6a86"
	
		readonly property color on_background: "#e0def4"
	
		readonly property color outline: "#6e6a86"
	
		readonly property color outline_variant: "#403d52"
	
		readonly property color primary: "#191724"
	
		readonly property color on_primary: "#e0def4"
	
		readonly property color primary_container: "#e0def4"
	
		readonly property color on_primary_container: "#191724"
	
		readonly property color primary_fixed: "#e0def4"
	
		readonly property color primary_fixed_dim: "#e0def4"
	
		readonly property color on_primary_fixed: "#191724"
	
		readonly property color on_primary_fixed_variant: "#191724"
	
		readonly property color secondary: "#403d52"
	
		readonly property color on_secondary: "#e0def4"
	
		readonly property color secondary_container: "#403d52"
	
		readonly property color on_secondary_container: "#e0def4"
	
		readonly property color secondary_fixed: "#403d52"
	
		readonly property color secondary_fixed_dim: "#403d52"
	
		readonly property color on_secondary_fixed: "#e0def4"
	
		readonly property color on_secondary_fixed_variant: "#e0def4"
	
		readonly property color tertiary: "#9ccfd8"
	
		readonly property color on_tertiary: "#191724"
	
		readonly property color tertiary_container: "#9ccfd8"
	
		readonly property color on_tertiary_container: "#191724"
	
		readonly property color tertiary_fixed: "#9ccfd8"
	
		readonly property color tertiary_fixed_dim: "#9ccfd8"
	
		readonly property color on_tertiary_fixed: "#191724"
	
		readonly property color on_tertiary_fixed_variant: "#191724"
	
		readonly property color error: "#eb6f92"
	
		readonly property color on_error: "#191724"
	
		readonly property color error_container: "#eb6f92"
	
		readonly property color on_error_container: "#191724"
	
		readonly property color shadow: "#000000"
	
		readonly property color scrim: "#000000"
	
		readonly property color inverse_surface: "#e0def4"
	
		readonly property color inverse_on_surface: "#191724"
	
		readonly property color inverse_primary: "#191724"
	
}