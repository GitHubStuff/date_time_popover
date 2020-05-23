import 'package:flutter/material.dart';
import 'package:flutter_date_time_popover/flutter_date_time_popover.dart';
import 'package:flutter_project_package/mode_themes/mode_theme.dart';

const double WIDTH = 300;

class ScaffoldWidget extends StatelessWidget with WidgetsBindingObserver {
  @override //- WidgetBindingObserver
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangePlatformBrightness() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold'),
      ),
      body: _inkwell(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            ModeTheme.of(context).toggleBrightness();
          },
          tooltip: 'Mode',
          child: Icon(Icons.flash_on),
        ),
      ),
    );
  }

  Widget _inkwell() {
    final startedDateTime = DateTime.now().subtract(Duration(seconds: 86400 + (3 * 3600) + (14 * 60)));
    return Column(
      children: <Widget>[
        DateTimeInputWidget(
          pickerWidth: WIDTH,
          dateTimeWidget: startTime,
          initialDateTime: startedDateTime,
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: DateTimeInputWidget(
            pickerWidth: WIDTH,
            dateTimeWidget: finishTime,
            initialDateTime: null,
          ),
        ),
      ],
    );
  }

  Widget startTime(DateTime dateTime) {
    String text = (dateTime == null) ? 'Start Here' : formattedDate(dateTime) + ' ' + formattedTime(dateTime);
    return Text(text);
  }

  Widget finishTime(DateTime dateTime) {
    String text = (dateTime == null) ? 'Finish Here' : formattedDate(dateTime) + ' ' + formattedTime(dateTime);
    return Text(text);
  }
}
