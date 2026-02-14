import Toybox.Lang;
import Toybox.Application.Storage;
import Toybox.Application;

class Settings {
    var gapSize = 2;
    var showHexValue = false;

    function loadSettings() {
        // https://developer.garmin.com/connect-iq/core-topics/properties-and-app-settings/
        // https://forums.garmin.com/developer/connect-iq/w/wiki/4/new-developer-faq#settings-crash
        if (Toybox.Application has :Properties) {
            gapSize = Application.Properties.getValue("GapSize");
            showHexValue = Application.Properties.getValue("ShowHexValue");
            System.println("Settings.loadSettings: gapSize=" + gapSize + ", showHexValue=" + showHexValue);
        }
    }
}
