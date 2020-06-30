
import 'package:mode_theme/mode_theme.dart';

import '../common.dart';

class ColorInheritedWidget extends InheritedWidget {
  final ModeColor pickerBodyColors;
  final ModeColor dateWheelColors;
  final ModeColor timeWheelColors;
  final ModeColor setButtonColors;
  final ModeColor pickerHiliteColors;

  ColorInheritedWidget(
      {@required ModeColor pickerBodyColors,
      @required ModeColor dateWheelColors,
      @required ModeColor timeWheelColors,
      @required ModeColor setButtonColors,
      @required ModeColor pickerHiliteColors,
      Widget child})
      : this.pickerBodyColors = pickerBodyColors ?? ModeColor(light: Colors.grey, dark: Colors.deepPurple),
        this.dateWheelColors = dateWheelColors ?? ModeColor(light: Colors.lightBlueAccent, dark: Colors.black),
        this.timeWheelColors = timeWheelColors ?? ModeColor(light: Colors.lightBlue, dark: Colors.deepPurpleAccent),
        this.setButtonColors = setButtonColors ?? ModeColor.mono(Colors.blueAccent),
        this.pickerHiliteColors = pickerHiliteColors ?? ModeColor.mono(Colors.grey),
        super(child: child);

  @override
  bool updateShouldNotify(ColorInheritedWidget oldWidget) => false;
}
