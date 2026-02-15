import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;

class ColourTestView extends WatchUi.View {
  // var _timer;
  var _devSize;
  var _hexColors as Array<Lang.String>;
  var _systemColors as Array<Number>;

  function initialize() {
    System.println("view.initialize");
    View.initialize();

    _hexColors = [
      "0xFFFFFF","0xFFFFAA","0xFFFF55","0xFFFF00","0xFFAAFF","0xFFAAAA","0xFFAA55","0xFFAA00",
      "0xFF55FF","0xFF55AA","0xFF5555","0xFF5500","0xFF00FF","0xFF00AA","0xFF0055","0xFF0000",
      "0xAAFFFF","0xAAFFAA","0xAAFF55","0xAAFF00","0xAAAAFF","0xAAAAAA","0xAAAA55","0xAAAA00",
      "0xAA55FF","0xAA55AA","0xAA5555","0xAA5500","0xAA00FF","0xAA00AA","0xAA0055","0xAA0000",
      "0x55FFFF","0x55FFAA","0x55FF55","0x55FF00","0x55AAFF","0x55AAAA","0x55AA55","0x55AA00",
      "0x5555FF","0x5555AA","0x555555","0x555500","0x5500FF","0x5500AA","0x550055","0x550000",
      "0x00FFFF","0x00FFAA","0x00FF55","0x00FF00","0x00AAFF","0x00AAAA","0x00AA55","0x00AA00",
      "0x0055FF","0x0055AA","0x005555","0x005500","0x0000FF","0x0000AA","0x000055","0x000000",
    ];

    _systemColors = [
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
    // clear the display
    dc.setColor(0, 0);
    dc.clear();

    if (SelectedIndex < 0 || SelectedIndex >= Colors.size()) {
      System.println("view.onUpdate: invalid SelectedIndex");
      SelectedIndex = 0;
    }
    
    var color = Colors[SelectedIndex];
    System.println("view.onUpdate: " + color);

    switch (color) {
      case "ColorWheel":
        drawColorWheel(dc);
        return;
      case "TestPatternHorizontal":
        drawTestPattern(dc, true);
        return;
      case "TestPatternVertical":
        drawTestPattern(dc, false);
        return;
      case "ColorGridBig":
        drawColorGridBig(dc);
        return;
      case "ColorGridSquare":
        drawColorGridSquare(dc);
        return;
      case "Gradient":
        drawGradient(dc);
        return;
    }

    dc.setColor(0, color.toNumberWithBase(16));
    dc.clear();

    if (gSettings.showHexValue) {
      var font = Graphics.FONT_MEDIUM;
      var center = dc.getWidth() / 2;      
      dc.drawText(center, center, font, color, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
  }

  // Draw a color wheel using filled arc wedges.
  function drawColorWheel(dc as Dc) {
    var overlap = 0.5;
    var center = _devSize / 2;
    var radius = center;
    var slices = _systemColors.size();
    var sliceAngle = 360.0 / slices.toFloat();
    var penWidth = (radius + 1).toNumber();
    var arcRadius = (penWidth / 2).toNumber();

    dc.setPenWidth(penWidth);

    for (var s = 0; s < slices; s++) {
      var color = _systemColors[s];
      var startA = (s * sliceAngle).toNumber() - (overlap / 2.0);
      var endA = (s * sliceAngle + sliceAngle).toNumber() + (overlap / 2.0);
      dc.setColor(color, Graphics.COLOR_TRANSPARENT);
      dc.drawArc(center, center, arcRadius, Graphics.ARC_COUNTER_CLOCKWISE, startA, endA);
    }

    dc.setPenWidth(1);
  }

  // Draw an 8x8 grid of colors centered on the (round) screen.
  // Cells whose centers fall outside the circular screen are skipped.
  function drawColorGridBig(dc) {
    var cols = 8;
    var rows = 8;
    var gap = gSettings.gapSize;

    // Compute base cell size and center the whole block
    var cellSize = (_devSize - (cols - 1) * gap) / cols;
    var totalUsed = cols * cellSize + (cols - 1) * gap;
    var offset = (_devSize - totalUsed) / 2;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        var idx = r * cols + c;
        var x = offset + c * (cellSize + gap);
        var y = offset + r * (cellSize + gap);

        // For last column/row, absorb any remaining pixels so block stays centered
        var w = (c == cols - 1) ? (_devSize - offset - x) : cellSize;
        var h = (r == rows - 1) ? (_devSize - offset - y) : cellSize;

        dc.setColor(_hexColors[idx].toNumberWithBase(16), 0);
        dc.fillRectangle(x, y, w, h);
      }
    }
  }

  // Draw a square grid of colors centered on the screen.
  function drawColorGridSquare(dc as Dc) {
    // number of cells in the grid and gap size between them
    var cells = 8;
    var gapSize = gSettings.gapSize;

    // compute the side length of the largest square that can fit in the display
    var sideLength = _devSize / Math.sqrt(2);

    // compute cell size based on available space after accounting for gaps
    var cellSize = Math.floor((sideLength - (cells - 1) * gapSize) / cells);
    var totalUsed = cells * cellSize + (cells - 1) * gapSize;
    var offset = Math.floor((_devSize - totalUsed) / 2);
    var cellSizeWithGap = cellSize + gapSize;

    // draw cells filling the square area
    for (var row = 0; row < cells; row++) {
      for (var col = 0; col < cells; col++) {
        dc.setColor(_hexColors[row * cells + col].toNumberWithBase(16), 0);
        dc.fillRectangle(offset + col * cellSizeWithGap, offset + row * cellSizeWithGap, cellSize, cellSize);
      }
    }
  }

  // Draw a vertical gradient filling the whole display.
  // The gradient is defined by start/mid/end colors.
  function drawGradient(dc) {
    var startColor = gSettings.startColor.toNumberWithBase(16);
    var midColor = gSettings.midColor.toNumberWithBase(16);
    var endColor = gSettings.endColor.toNumberWithBase(16);
    ColorUtils.drawGradient(dc, startColor, midColor, endColor, 0, 0, _devSize, _devSize);
  }

  // Draws a test pattern of colored bars with gaps in between
  function drawTestPattern(dc, horizontal) {
    var colorSize = _systemColors.size();
    var gapSize = gSettings.gapSize;

    // Use (colorSize - 1) gaps between bars so we can center the
    // whole stack and make the top/bottom (or left/right) gaps equal
    var barSize = (_devSize - (colorSize - 1) * gapSize) / colorSize;

    // Compute total used pixels and center the stack by offsetting
    // the start position so the gap at the start and end are equal
    var totalUsed = colorSize * barSize + (colorSize - 1) * gapSize;
    var offset = (_devSize - totalUsed) / 2;
    var pos = offset;

    for (var i = 0; i < colorSize; i++) {
      dc.setColor(_systemColors[i], 0);
      if (horizontal) {
        dc.fillRectangle(0, pos, _devSize, barSize);
      } else {
        dc.fillRectangle(pos, 0, barSize, _devSize);
      }
      pos += barSize + gapSize;
    }
  }
}
