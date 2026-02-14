import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;

class GapSizeMenuInputDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var newSize = item.getId() as Number;
        gSettings.gapSize = newSize;
        Application.Properties.setValue("GapSize", newSize);
        System.println("GapSize changed to: " + newSize);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
