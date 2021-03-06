library flutter_date_time_popover;

import 'package:date_time_popover/date_time_picker/common.dart';
import 'package:intl/intl.dart';

export 'date_time_picker/input_widget/date_time_input_widget.dart';

String formattedDate(DateTime dateTime) {
  assert(dateTime != null, 'Cannot pass null dateTime');
  if (dateTime == null) throw FlutterError('Cannot pass "null" dateTime to "formattedTime(dateTime)"');
  return DateFormat('EEE, MMM d, yyyy').format(dateTime);
}

String formattedDateTime(DateTime dateTime) {
  assert(dateTime != null, 'Cannot pass null dateTime');
  if (dateTime == null) throw FlutterError('Cannot pass "null" dateTime to "formattedTime(dateTime)"');
  return '${formattedDate(dateTime)} ${formattedTime(dateTime)}';
}

String formattedTime(DateTime dateTime) {
  assert(dateTime != null, 'Cannot pass null dateTime');
  if (dateTime == null) throw FlutterError('Cannot pass "null" dateTime to "formattedTime(dateTime)"');
  return DateFormat('h:mm:ss a').format(dateTime);
}
