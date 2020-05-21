# flutterdatetimepopover

A DateTime Picker Flutter package.

## Getting Started
### Make sure the widget is passed a function

DateTimeInputWidget({  
> Key key,  
  @required this.pickerWidth,   //Max 330pts  
  @required this.dateTimeWidget,  //Widget function is wrapped in Inkwell and recieves date/time {usually Text()}  
  this.pickerBodyColors,  
  this.dateWheelColors,  
  this.timeWheelColors,  
  this.setButtonColors,  
  this.pickerHiliteColors,  
})