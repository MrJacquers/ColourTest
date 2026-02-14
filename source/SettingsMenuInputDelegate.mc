import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Lang;

class SettingsMenuInputDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var id = item.getId();
        System.println("SettingsMenuInputDelegate.onSelect: " + id);

        if (id.equals("gapsize")) {
            showGapSizeMenu();
        } else if (id.equals("showhex")) {
            var toggleItem = item as WatchUi.ToggleMenuItem;
            gSettings.showHexValue = toggleItem.isEnabled();
            Application.Properties.setValue("ShowHexValue", gSettings.showHexValue);
            System.println("ShowHexValue toggled to: " + gSettings.showHexValue);
            onBack();
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.requestUpdate(); // refresh the main view to reflect any changes
    }

    private function showGapSizeMenu() as Void {
        var menu = new WatchUi.Menu2({:title => "Gap Size"});
        for (var i = 0; i < 5; i++) {
            var label = i.toString();
            if (i == gSettings.gapSize) {
                label = "[" + label + "]";
            }
            menu.addItem(new WatchUi.MenuItem(label, "", i, {}));
        }   

        var gapSizeDelegate = new GapSizeMenuInputDelegate();
        WatchUi.pushView(menu, gapSizeDelegate, WatchUi.SLIDE_IMMEDIATE);
    }
}
