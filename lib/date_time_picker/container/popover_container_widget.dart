import 'package:mode_theme/mode_theme.dart';

import '../../flutter_date_time_popover.dart';
import '../common.dart';
//import 'package:flutter_project_package/tracers/tracers.dart' as Log;

const String _SET_BUTTON_TEXT = 'Set';

//
// Widget that wraps the spinners, has the 'SET' button, and displays the picker date/time
//
class PopoverContainerWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  static DateTime _displayDateTime = DateTime.now();

  final PickerSize _pickerSize;

  PopoverContainerWidget({Key key, @required PickerSize pickerSize, @required initalDateTime})
      : _pickerSize = pickerSize,
        super(key: key) {
    _displayDateTime = initalDateTime;
    //Log.z('PopoverCOntainerWidget constructor: ${_displayDateTime.toLocal().toString()}');
  }

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
              //Log.z('popover_container_widget state: ${dayState.toString()} time:$time');
              if (dayState is UpdateDateTimeState) {
                _displayDateTime = dayState.dateTime;
                //Log.z('popover_container_widget#61 ${_displayDateTime.toLocal().toString()}');
                date = formattedDate(_displayDateTime);
                time = formattedTime(_displayDateTime);
                //Log.z('verify: time $time');
              }
              //Log.z('passing: time $time');
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
        child: Text(_SET_BUTTON_TEXT,
            style: TextStyle(
              fontSize: _pickerSize.fontSize,
              color: ModeDefiniation.contrastColors.color(context),
            )),
      ),
    );
  }
}
