# flutterdatetimepopover

A DateTime Picker Flutter package.

## Getting Started

### Make sure the widget is passed a function

<pre>
DateTimeInputWidget({
  Key key,
  @required this.pickerWidth,   //Min 300pts  (MINIMAL_PICKER_WIDTH)
  @required this.dateTimeWidget,  // Widget name(DateTime result){}
  this.initialDateTime,  // Starting dateTime (defaults to DateTime.now())
  this.pickerBodyColors,
  this.dateWheelColors,
  this.timeWheelColors,
  this.setButtonColors,
  this.pickerHiliteColors,
});
</pre>
The 'dateTimeWidget' must be a function that accepts 'DateTime' and returns a widget.
That widget is wrapped in gesture detector so when the user taps it the picker will overlay
appear and the user scrolls to their desired date and time.

## Example 1

<pre>

DateTime inital = null;
Widget widget = DateTimeInputWidget(pickerWidth: 300,
                                    dateTimeWidget: startTime,
                                    initalDateTime: initial);

// dateTime == null because 'inital' == null
// *Unless, of course, the picker value was set.
Widget startTime(BuildContext context, DateTime dateTime) {
  if (dateTime == null) return Container();
  return Text(dateTime.toString());
}

Widget startTime(BuildContext context, DateTime dateTime) {
  if (dateTime == null) return Container();
  return Text(dateTime.toString());
}
</pre>

## Example 2

<pre>

DateTime inital = DateTime.now();
Widget widget = DateTimeInputWidget(pickerWidth: 300,
                                    dateTimeWidget: startTime,
                                    initalDateTime: initial);

// dateTime != null because 'inital' != null
Widget startTime(BuildContext context, DateTime dateTime) {
  if (dateTime == null) return Container();
  return Text(dateTime.toString());
}

Widget startTime(BuildContext context, DateTime dateTime) {
  if (dateTime == null) return Container();
  return Text(dateTime.toString());
}
</pre>