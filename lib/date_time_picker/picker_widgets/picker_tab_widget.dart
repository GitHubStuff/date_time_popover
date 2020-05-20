import '../common.dart';import 'picker_toggle_widget.dart';

class PickerTabWidget extends StatelessWidget with DateMeasurements {
  final PickerSize _pickerSize;

  PickerTabWidget({
    Key key,
    @required PickerSize pickerSize,
    ModeColor dateBackgroundColors,
    ModeColor timeBackgroundColors,
  })  : _pickerSize = pickerSize,
        assert(pickerSize != null),
        super(key: key);

  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        _tabButtons(context),
        PickerToggleWidget(
          pickerSize: _pickerSize,
        )
      ],
    );
  }

  Widget _tabButtons(BuildContext context) {
    final PickerBloc pickerBloc = context.bloc<PickerBloc>();
    final colors = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Row(
      children: <Widget>[
        Container(
          width: _pickerSize.scrollWidth / 2.0,
          height: _pickerSize.rowHeight,
          color: colors.dateWheelColors.color(context),
          child: FlatButton(
              onPressed: () {
                pickerBloc.add(SetPickerTypeEvent(DatePickerType.date));
              },
              child: Text(
                'Date',
                style: pickerTabButtonStyle(context, pickerSize: _pickerSize),
              )),
        ),
        Container(
          width: _pickerSize.scrollWidth / 2.0,
          height: _pickerSize.rowHeight,
          color: colors.timeWheelColors.color(context),
          child: FlatButton(
              onPressed: () {
                pickerBloc.add(SetPickerTypeEvent(DatePickerType.time));
              },
              child: Text(
                'Time',
                style: pickerTabButtonStyle(context, pickerSize: _pickerSize),
              )),
        ),
      ],
    );
  }
}
