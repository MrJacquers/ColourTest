import Toybox.Lang;
import Toybox.WatchUi;

// https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi/InputDelegate.html
// https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi/BehaviorDelegate.html
class ColourTestDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        System.println("onMenu");
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ColourTestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        System.println("onKey: " + key);

        if (key == 8) {
            // down
            nextColor();
            return true;
        } else if (key == 13) {
            // up
            prevColor();
            return true;
        }
        
        return false; // allow default behavior (e.g. back button)
    }

    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        System.println("onSwipe: " + direction);

        if (direction.equals(WatchUi.SWIPE_UP)) {
            nextColor();
            return true;
        } else if (direction.equals(WatchUi.SWIPE_DOWN)) {
            prevColor();
            return true;
        }
        
        return false;
    }

    (:debug)
    function onTap(clickEvent as WatchUi.ClickEvent) as Lang.Boolean {
        System.println("onTap");
        nextColor();
        return true;
    }

    function nextColor() as Void {
        SelectedIndex = (SelectedIndex + 1) % colors.size();
        WatchUi.requestUpdate();
    }

    function prevColor() as Void {
        SelectedIndex = (SelectedIndex - 1 + colors.size()) % colors.size();
        WatchUi.requestUpdate();
    }    
}
