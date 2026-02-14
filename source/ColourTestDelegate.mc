import Toybox.Lang;
import Toybox.WatchUi;

// https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi/InputDelegate.html
// https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi/BehaviorDelegate.html
class ColourTestDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ColourTestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        System.println("onKey: " + key);
        if (key == 13) {
            SelectedIndex = (SelectedIndex - 1 + colors.size()) % colors.size(); // up / prev
            WatchUi.requestUpdate();
        } else if (key == 8) {
            SelectedIndex = (SelectedIndex + 1) % colors.size(); // down / next
            WatchUi.requestUpdate();
        }
        return true;
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        System.println("onSwipe: " + direction);
        if (direction.equals(WatchUi.SWIPE_UP)) {
            SelectedIndex = (SelectedIndex - 1 + colors.size()) % colors.size(); // up / prev
            WatchUi.requestUpdate();
        } else if (direction.equals(WatchUi.SWIPE_DOWN)) {
            SelectedIndex = (SelectedIndex + 1) % colors.size(); // down / next
            WatchUi.requestUpdate();
        }
        return true;
    }

    (:debug)
    function onTap(clickEvent as WatchUi.ClickEvent) as Lang.Boolean {
        System.println("onTap");
        // advance to the next color index, loop back to start if at the end
        SelectedIndex = (SelectedIndex + 1) % colors.size();
        WatchUi.requestUpdate();
        return true;
    }
}
