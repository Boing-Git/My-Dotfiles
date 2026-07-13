pragma Singleton
import QtQuick
import "variables.js" as Vars

QtObject {
    function withAlpha(hexString, alpha) {
        let col = Qt.color(hexString);
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }
	
		readonly property color background: Vars.translucent ? withAlpha("#282828", 0.7) : "#282828"
	
		readonly property color surface: Vars.translucent ? withAlpha("#282828", 0.7) : Vars.translucent ? withAlpha("#282828", 0.7) : "#282828"
	
		readonly property color surface_dim: Vars.translucent ? withAlpha("#282828", 0.7) : Vars.translucent ? withAlpha("#282828", 0.7) : "#282828"
	
		readonly property color surface_bright: Vars.translucent ? withAlpha("#665c54", 0.7) : Vars.translucent ? withAlpha("#665c54", 0.7) : "#665c54"
	
		readonly property color surface_variant: Vars.translucent ? withAlpha("#665c54", 0.7) : Vars.translucent ? withAlpha("#665c54", 0.7) : "#665c54"
	
		readonly property color on_surface: "#fbf1c7"
	
		readonly property color on_surface_variant: "#a89984"
	
		readonly property color on_background: "#fbf1c7"
	
		readonly property color outline: "#665c54"
	
		readonly property color outline_variant: "#a89984"
	
		readonly property color primary: "#282828"
	
		readonly property color on_primary: "#a89984"
	
		readonly property color primary_container: "#a89984"
	
		readonly property color on_primary_container: "#282828"
	
		readonly property color primary_fixed: "#282828"
	
		readonly property color primary_fixed_dim: "#665c54"
	
		readonly property color on_primary_fixed: "#282828"
	
		readonly property color on_primary_fixed_variant: "#665c54"
	
		readonly property color secondary: "#665c54"
	
		readonly property color on_secondary: "#a89984"
	
		readonly property color secondary_container: "#a89984"
	
		readonly property color on_secondary_container: "#665c54"
	
		readonly property color secondary_fixed: "#665c54"
	
		readonly property color secondary_fixed_dim: "#665c54"
	
		readonly property color on_secondary_fixed: "#282828"
	
		readonly property color on_secondary_fixed_variant: "#665c54"
	
		readonly property color tertiary: "#282828"
	
		readonly property color on_tertiary: "#a89984"
	
		readonly property color tertiary_container: "#a89984"
	
		readonly property color on_tertiary_container: "#282828"
	
		readonly property color tertiary_fixed: "#282828"
	
		readonly property color tertiary_fixed_dim: "#665c54"
	
		readonly property color on_tertiary_fixed: "#282828"
	
		readonly property color on_tertiary_fixed_variant: "#665c54"
	
		readonly property color error: "#9d0006"
	
		readonly property color on_error: "#282828"
	
		readonly property color error_container: "#ffffff"
	
		readonly property color on_error_container: "#fbf1c7"
	
		readonly property color shadow: "#fbf1c7"
	
		readonly property color scrim: "#fbf1c7"
	
		readonly property color inverse_surface: "#fbf1c7"
	
		readonly property color inverse_on_surface: "#282828"
	
		readonly property color inverse_primary: "#282828"
	
}