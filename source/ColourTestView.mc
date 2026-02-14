import Toybox.Graphics;
import Toybox.WatchUi;

class ColourTestView extends WatchUi.View {
  // var _timer;
  var _devSize;

  function initialize() {
    System.println("view.initialize");
    View.initialize();

    // refresh timer
    //_timer = new Timer.Timer();
    //_timer.start(method(:timerCallback), 1000, true);
  }

  function timerCallback() as Void {
    //System.println("timerCallback");
    // WatchUi.requestUpdate();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    System.println("view.onLayout");
    _devSize = dc.getHeight();
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
      System.println("view.onShow");
  }

  // Called when this View is removed from the screen
  function onHide() as Void {
      System.println("view.onHide");
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    var color = colors[SelectedIndex];
    System.println("view.onUpdate: " + color);

    if (color.equals("TestPatternHorizontal")) {
      drawTestPattern(dc, true);
      return;
    } else if (color.equals("TestPatternVertical")) {
      drawTestPattern(dc, false);
      return;
    } else if (color.equals("ColorGrid")) {
      drawColorGrid(dc);
      return;
    }
      
    dc.setColor(0, color.toLongWithBase(16));
    dc.clear();

    // TODO: make a setting for this?
    /*dc.setColor(0, -1);
    var font = Graphics.FONT_MEDIUM;
    var x = dc.getWidth() / 2;
    var y = dc.getHeight() / 2;
    dc.drawText(x, y, font, color, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);*/
  }

  // Draw an 8x8 grid of colors centered on the (round) screen.
  // Cells whose centers fall outside the circular screen are skipped.
  function drawColorGrid(dc) {
    var hexColors = [
      "0x000000", "0x000055", "0x0000AA", "0x0000FF", "0x005500", "0x005555", "0x0055AA", "0x0055FF",
      "0x00AA00", "0x00AA55", "0x00AAAA", "0x00AAFF", "0x00FF00", "0x00FF55", "0x00FFAA", "0x00FFFF",
      "0x550000", "0x550055", "0x5500AA", "0x5500FF", "0x555500", "0x555555", "0x5555AA", "0x5555FF",
      "0x55AA00", "0x55AA55", "0x55AAAA", "0x55AAFF", "0x55FF00", "0x55FF55", "0x55FFAA", "0x55FFFF",
      "0xAA0000", "0xAA0055", "0xAA00AA", "0xAA00FF", "0xAA5500", "0xAA5555", "0xAA55AA", "0xAA55FF",
      "0xAAAA00", "0xAAAA55", "0xAAAAAA", "0xAAAAFF", "0xAAFF00", "0xAAFF55", "0xAAFFAA", "0xAAFFFF",
      "0xFF0000", "0xFF0055", "0xFF00AA", "0xFF00FF", "0xFF5500", "0xFF5555", "0xFF55AA", "0xFF55FF",
      "0xFFAA00", "0xFFAA55", "0xFFAAAA", "0xFFAAFF", "0xFFFF00", "0xFFFF55", "0xFFFFAA", "0xFFFFFF",
    ];

    dc.setColor(0, 0);
    dc.clear(); // only required in simulator

    var cols = 8;
    var rows = 8;
    var gap = 1;

    // Compute base cell size and center the whole block
    var cellSize = (_devSize - (cols - 1) * gap) / cols;
    var totalUsed = cols * cellSize + (cols - 1) * gap;
    var offset = (_devSize - totalUsed) / 2;

    var cx = _devSize / 2;
    var cy = cx;
    var radius = _devSize / 2;
    var radiusSq = radius * radius;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        var idx = r * cols + c;
        var x = offset + c * (cellSize + gap);
        var y = offset + r * (cellSize + gap);

        // For last column/row, absorb any remaining pixels so block stays centered
        var w = (c == cols - 1) ? (_devSize - offset - x) : cellSize;
        var h = (r == rows - 1) ? (_devSize - offset - y) : cellSize;

        // Skip drawing if the cell center is outside the circular screen
        var rx = x + w / 2;
        var ry = y + h / 2;
        var dx = rx - cx;
        var dy = ry - cy;
        if (dx * dx + dy * dy > radiusSq) {
          continue;
        }

        var colorVal = hexColors[idx].toLongWithBase(16);
        dc.setColor(colorVal, 0);
        dc.fillRectangle(x, y, w, h);
      }
    }
  }

  // Draws a test pattern of colored bars with gaps in between
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

    var gapSize = 1;
    var colorSize = _colors.size();
    // Use (colorSize - 1) gaps between bars so we can center the
    // whole stack and make the top/bottom (or left/right) gaps equal.
    var barSize = (_devSize - (colorSize - 1) * gapSize) / colorSize;

    // Compute total used pixels and center the stack by offsetting
    // the start position so the gap at the start and end are equal.
    var totalUsed = colorSize * barSize + (colorSize - 1) * gapSize;
    var offset = (_devSize - totalUsed) / 2;
    var pos = offset;

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
}
