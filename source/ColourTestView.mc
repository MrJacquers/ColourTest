import Toybox.Graphics;
import Toybox.WatchUi;

class ColourTestView extends WatchUi.View {
  // var _timer;
  var _devSize;

  function initialize() {
    View.initialize();

    // refresh timer
    //_timer = new Timer.Timer();
    //_timer.start(method(:timerCallback), 1000, true);
  }

  function timerCallback() as Void {
    // WatchUi.requestUpdate();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void { _devSize = dc.getHeight(); }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    var color = colors[SelectedIndex];

    if (color.equals("TestPatternHorizontal")) {
      drawTestPattern(dc, true);
      return;
    } else if (color.equals("TestPatternVertical")) {
      drawTestPattern(dc, false);
      return;
    } else {
      dc.setColor(0, color.toLongWithBase(16));
    }

    dc.clear();
    dc.setColor(0, -1);
    var font = Graphics.FONT_MEDIUM;
    var x = dc.getWidth() / 2;
    var y = dc.getHeight() / 2;
    dc.drawText(x, y, font, color, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
  }

  function drawTestPattern(dc, horizontal) {
    var _colors = [
      Graphics.COLOR_WHITE,
      Graphics.COLOR_LT_GRAY,
      Graphics.COLOR_DK_GRAY,
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
    ];

    dc.setColor(0, 0);
    dc.clear(); // only required in simulator

    var pos = 0;
    var gapSize = 1;
    var colorSize = _colors.size();
    var barSize = (_devSize - colorSize * gapSize) / colorSize;

    for (var i = 0; i < colorSize; i++) {
      dc.setColor(_colors[i], 0);

      if (horizontal) {
        dc.fillRectangle(0, pos, _devSize, barSize);
      } else {
        dc.fillRectangle(pos, 0, barSize, _devSize);
      }

      pos += barSize + gapSize;
    }
  }
  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}
}
