import Toybox.Lang;
import Toybox.WatchUi;

class ColourTestDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ColourTestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKeyPressed(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        //System.println("Key Pressed: " + key);

        if (key == 13) {
            // up / prev
            SelectedIndex = (SelectedIndex - 1 + colors.size()) % colors.size();
            WatchUi.requestUpdate();
        } else if (key == 8) {
            // down / next
            SelectedIndex = (SelectedIndex + 1) % colors.size();
            WatchUi.requestUpdate();
        }

        return true;
    }

    function onTap(clickEvent as WatchUi.ClickEvent) as Lang.Boolean {
        //
        // advance to the next color index, loop back to start if at the end
        SelectedIndex = (SelectedIndex + 1) % colors.size();
        WatchUi.requestUpdate();
        return true;
    }
}
