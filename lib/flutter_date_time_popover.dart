library flutter_date_time_popover;

import 'package:intl/intl.dart';

export 'date_time_picker/input_widget/date_time_input_widget.dart';

String formattedDate(DateTime dateTime) => DateFormat('EEE, MMM d, yyyy').format(dateTime);
String formattedTime(DateTime dateTime) => DateFormat('h:mm:ss a').format(dateTime);
