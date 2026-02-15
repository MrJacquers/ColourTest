import Toybox.Lang;
import Toybox.Application.Storage;
import Toybox.Application;

class Settings {
    var gapSize = 2;
    var showHexValue = false;
    var startColor = "0xFF0000"; // Red
    var midColor = "0x00FF00";   // Green
    var endColor = "0x0000FF";   // Blue

    function loadSettings() {
        // https://developer.garmin.com/connect-iq/core-topics/properties-and-app-settings/
        // https://forums.garmin.com/developer/connect-iq/w/wiki/4/new-developer-faq#settings-crash
        if (Toybox.Application has :Properties) {
            gapSize = Application.Properties.getValue("GapSize");
            showHexValue = Application.Properties.getValue("ShowHexValue");
            startColor = Application.Properties.getValue("StartColor");
            midColor = Application.Properties.getValue("MidColor");
            endColor = Application.Properties.getValue("EndColor");
        }
    }
}
