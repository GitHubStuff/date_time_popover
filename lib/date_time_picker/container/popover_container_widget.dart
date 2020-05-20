import '../../flutter_date_time_popover.dart';
import '../common.dart';

const String SET_BUTTON_TEXT = 'Set';

//
// Widget that wraps the spinners, has the 'SET' button, and displays the picker date/time
//
class PopoverContainerWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  static DateTime _displayDateTime = DateTime.now();
  final PickerSize _pickerSize;

  PopoverContainerWidget({Key key, @required PickerSize pickerSize})
      : _pickerSize = pickerSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorInheritedWidget = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Container(
      width: _pickerSize.scrollWidth + 2,
      height: _pickerSize.totalHeight - _pickerSize.arrowPointAdjustment,
      //color: colorInheritedWidget.pickerBodyColors.color(context),
      child: _pickerBody(context),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: colorInheritedWidget.pickerBodyColors.color(context),
        ),
      ),
    );
  }

  Widget _pickerBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _pickerHeader(context),
        PickerTabWidget(
          pickerSize: _pickerSize,
        ),
      ],
    );
  }

  Widget _pickerHeader(BuildContext context) {
    String date = formattedDate(_displayDateTime);
    String time = formattedTime(_displayDateTime);
    final colorInheritedWidget = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Container(
      height: _pickerSize.displayTimeHeight,
      color: colorInheritedWidget.pickerBodyColors.color(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: BlocBuilder<DateTimeBloc, DateTimeState>(builder: (BuildContext context, DateTimeState dayState) {
              if (dayState is UpdateDateTimeState) {
                _displayDateTime = dayState.dateTime;
                date = formattedDate(_displayDateTime);
                time = formattedTime(_displayDateTime);
              }
              return Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  '$date\n$time',
                  style: TextStyle(fontSize: _pickerSize.fontSize),
                ),
              );
            }),
          ),
          //theButton(),
          Container(
            width: _pickerSize.setButtonWidth,
            height: _pickerSize.setButtonHeight,
            child: _theSetButton(context),
          ),
        ],
      ),
    );
  }

  Widget _theSetButton(BuildContext context) {
    final DateTimeBloc dateTimeBloc = context.bloc<DateTimeBloc>();
    final colorInheritedWidget = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        right: 5,
      ),
      child: RaisedButton(
        onPressed: () {
          dateTimeBloc.add(UserSetDateTimeEvent());
        },
        color: colorInheritedWidget.setButtonColors.color(context),
        child: Text(SET_BUTTON_TEXT,
            style: TextStyle(
              fontSize: _pickerSize.fontSize,
              color: ModeDefiniation.contrastColors.color(context),
            )),
      ),
    );
  }
}
