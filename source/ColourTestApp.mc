import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

var gSettings = null;

var SelectedIndex = 0;

var Colors as Array<Lang.String> = [
    "ColorWheel",
    "ColorGridBig",
    "ColorGridSquare",
    "TestPatternHorizontal",
    "TestPatternVertical",
    "Gradient",
    "0xFFFFFF", // COLOR_WHITE
    "0xAAAAAA", // COLOR_LT_GRAY
    "0x555555", // COLOR_DK_GRAY
    "0x000000", // COLOR_BLACK
    "0xFF0000", // COLOR_RED
    "0xAA0000", // COLOR_DK_RED
    "0xFF5500", // COLOR_ORANGE
    "0xFFAA00", // COLOR_YELLOW
    "0x00FF00", // COLOR_GREEN
    "0x00AA00", // COLOR_DK_GREEN
    "0x00AAFF", // COLOR_BLUE
    "0x0000FF", // COLOR_DK_BLUE
    "0xAA00FF", // COLOR_PURPLE
    "0xFF00FF", // COLOR_PINK
];

class ColourTestApp extends Application.AppBase {
    private var _view = null;

    function initialize() {
        System.println("App.initialize");
        AppBase.initialize();
        gSettings = new Settings();
        gSettings.loadSettings();
    }

    function onStart(state as Dictionary?) as Void {
        System.println("App.onStart");
    }

    function onStop(state as Dictionary?) as Void {
        System.println("App.onStop");
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        System.println("App.getInitialView");
        _view = new ColourTestView();
        return [_view, new ColourTestDelegate()];
    }

    // Called when settings have changed via the ConnectIQ app.
    function onSettingsChanged() as Void {
        System.println("app.onSettingsChanged");
        gSettings.loadSettings();
        WatchUi.requestUpdate();
    }
}

function getApp() as ColourTestApp {
    return Application.getApp() as ColourTestApp;
}
