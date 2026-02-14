import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

var SelectedIndex = 0;

var colors = [
    "ColorGrid",
    "TestPatternHorizontal",
    "TestPatternVertical",
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
    //"0x000000", "0x000055", "0x0000AA", "0x0000FF", "0x005500", "0x005555", "0x0055AA", "0x0055FF",
    //"0x00AA00", "0x00AA55", "0x00AAAA", "0x00AAFF", "0x00FF00", "0x00FF55", "0x00FFAA", "0x00FFFF",
    //"0x550000", "0x550055", "0x5500AA", "0x5500FF", "0x555500", "0x555555", "0x5555AA", "0x5555FF",
    //"0x55AA00", "0x55AA55", "0x55AAAA", "0x55AAFF", "0x55FF00", "0x55FF55", "0x55FFAA", "0x55FFFF",
    //"0xAA0000", "0xAA0055", "0xAA00AA", "0xAA00FF", "0xAA5500", "0xAA5555", "0xAA55AA", "0xAA55FF",
    //"0xAAAA00", "0xAAAA55", "0xAAAAAA", "0xAAAAFF", "0xAAFF00", "0xAAFF55", "0xAAFFAA", "0xAAFFFF",
    //"0xFF0000", "0xFF0055", "0xFF00AA", "0xFF00FF", "0xFF5500", "0xFF5555", "0xFF55AA", "0xFF55FF",
    //"0xFFAA00", "0xFFAA55", "0xFFAAAA", "0xFFAAFF", "0xFFFF00", "0xFFFF55", "0xFFFFAA", "0xFFFFFF",
];

class ColourTestApp extends Application.AppBase {
    function initialize() {
        System.println("App.initialize");
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
        System.println("App.onStart");
    }

    function onStop(state as Dictionary?) as Void {
        System.println("App.onStop");
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        System.println("App.getInitialView");
        return [new ColourTestView(), new ColourTestDelegate()];
    }
}

function getApp() as ColourTestApp {
    return Application.getApp() as ColourTestApp;
}
