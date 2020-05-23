# flutterdatetimepopover

A DateTime Picker Flutter package.

## Getting Started

### Make sure the widget is passed a function

DateTimeInputWidget({  
> Key key,  
  @required this.pickerWidth,   //Min 300pts  (MINIMAL_PICKER_WIDTH)
  @required this.dateTimeWidget,  // Widget name(DateTime result){}  
  this.initialDateTime,  // Starting dateTime (defaults to DateTime.now())
  this.pickerBodyColors,  
  this.dateWheelColors,  
  this.timeWheelColors,  
  this.setButtonColors,  
  this.pickerHiliteColors,  
})

The 'dateTimeWidget' must be a function that accepts 'DateTime' and returns a widget.
That widget is wrapped in gesture detector so when the user taps it the picker will overlay
appear and the user scrolls to their desired date and time.

example:  
Widget startTime(DateTime dateTime) {  
    return Text(dateTime.toString());  
  }  
