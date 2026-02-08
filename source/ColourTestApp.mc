import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

var SelectedIndex = 0;

var colors = [
    Graphics.COLOR_WHITE,
    Graphics.COLOR_LT_GRAY,
    Graphics.COLOR_DK_GRAY,
    Graphics.COLOR_BLACK,
    Graphics.COLOR_RED,
    Graphics.COLOR_DK_RED,
    Graphics.COLOR_ORANGE,
    Graphics.COLOR_YELLOW,
    Graphics.COLOR_GREEN,
    Graphics.COLOR_DK_GREEN,
    Graphics.COLOR_BLUE,
    Graphics.COLOR_DK_BLUE,
    Graphics.COLOR_PURPLE,
    Graphics.COLOR_PINK,
    "TestPatternHorizontal",
    "TestPatternVertical",
];

class ColourTestApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {}

    function onStop(state as Dictionary?) as Void {}

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [new ColourTestView(), new ColourTestDelegate()];
    }
}

function getApp() as ColourTestApp {
    return Application.getApp() as ColourTestApp;
}
