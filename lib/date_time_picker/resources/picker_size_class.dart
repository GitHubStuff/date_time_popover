import 'package:flutter/material.dart';

import '../common.dart';

const MINIMAL_PICKER_WIDTH = 300.0;

class PickerSize {
  final double pickerWidth;
  double get rowHeight => _width * 0.119402;
  double get scrollWidth => _width;
  double get yearWidth => _width * 0.26865;
  double get monthWidth => _width * 0.44776;
  double get dayWidth => _width * 0.238805;
  double get pickerHeight => rowHeight * 5.0;
  double get pickerTabHeight => rowHeight;
  double get headerHeight => 1.55 * rowHeight;
  double get displayTimeHeight => 1.2 * rowHeight;
  double get totalHeight => pickerHeight + pickerTabHeight + headerHeight;
  double get totalBoundedHeight => totalHeight + (2.0 * triangleHeight);
  double get fontSize => rowHeight * 0.40;
  double get focusBarOffset => (pickerHeight / 2.0) - (fontSize * 1.8);
  double get focusBarHeight => (fontSize * 2.1);
  TextStyle get textStyle => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );
  double get setButtonWidth => _width / 3.5;
  double get setButtonHeight => displayTimeHeight * 0.8;
  double get timeElementWidth => _width / 5.0;
  double get triangleHeight => 10.0;
  double get _width => (pickerWidth - (2.0 * triangleHeight));
  double get arrowPointAdjustment => 9.0;

  const PickerSize({@required double width})
      : pickerWidth = width,
        assert(width >= MINIMAL_PICKER_WIDTH, 'Minimal width is $MINIMAL_PICKER_WIDTH');
}
