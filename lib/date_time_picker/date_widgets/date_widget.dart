import 'package:mode_theme/mode_theme.dart';

import '../common.dart';

class DateWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  final DateMode _dateMode;
    final PickerSize _pickerSize;

  DateWidget({
    Key key,
    @required DateMode dateMode,
    @required PickerSize pickerSize,
    ModeColor dateBackgroundColors,
    ModeColor dateFocusColors,
  })  : _dateMode = dateMode,
        _pickerSize = pickerSize,
        assert(dateMode != null),
        assert(pickerSize != null),
        super(key: key);

  @override //- WidgetBindingObserver
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangePlatformBrightness() {}

  @override
  Widget build(BuildContext context) {
    return _stack(context);
  }

  Widget _stack(BuildContext context) {
    return Stack(
      children: <Widget>[
        _background(context),
        _bars(context),
        _container(),
      ],
    );
  }

  Widget _background(BuildContext context) {
    final colors = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Container(
      color: colors.dateWheelColors.color(context),
      height: _pickerSize.pickerHeight,
      width: _pickerSize.scrollWidth,
    );
  }

  Widget _bars(BuildContext context) {
    final colors = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Padding(
      padding: EdgeInsets.only(top: _pickerSize.focusBarOffset),
      child: Container(
        color: colors.pickerHiliteColors.color(context),
        height: _pickerSize.focusBarHeight,
        width: _pickerSize.scrollWidth,
      ),
    );
  }

  Widget _container() {
    return (_dateMode == DateMode.scientific)
        ? Row(
            children: <Widget>[
              YearWidget(_pickerSize),
              MonthWidget(_pickerSize),
              DayWidget(_pickerSize),
            ],
          )
        : Row(
            children: <Widget>[
              MonthWidget(_pickerSize),
              DayWidget(_pickerSize),
              YearWidget(_pickerSize),
            ],
          );
  }
}
