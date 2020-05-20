import '../common.dart';

class TimeWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  final PickerSize _pickerSize;

  TimeWidget({Key key, @required PickerSize pickerSize})
      : _pickerSize = pickerSize,
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
      color: colors.timeWheelColors.color(context),
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
    return Row(
      children: <Widget>[
        HourWidget(_pickerSize),
        MinuteWidget(_pickerSize),
        SecondWidget(_pickerSize),
        MeridianWidget(_pickerSize),
      ],
    );
  }
}
