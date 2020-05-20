import 'dart:async';

import '../common.dart';
//import 'package:flutter_project_package/tracers/tracers.dart' as Log;

final FixedExtentScrollController _scrollController = FixedExtentScrollController();
Timer _timer;

class YearWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  final PickerSize _pickerSize;

  YearWidget(this._pickerSize, {Key key}) : super(key: key);

  @override //- WidgetBindingObserver
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangePlatformBrightness() {}

  @override
  Widget build(BuildContext context) {
    final DateTimeBloc dateTimeBloc = context.bloc<DateTimeBloc>();
    return BlocBuilder<DateTimeBloc, DateTimeState>(
      builder: (BuildContext context, DateTimeState dayState) {
        if (dayState is InitialDayState) {
          _animateColumn(toRow: dayState.dateTime.year - BASE_YEAR, animationDurationInMilliSeconds: 1);
        }
        return Container(
          height: _pickerSize.pickerHeight,
          width: _pickerSize.yearWidth,
          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            itemExtent: _pickerSize.rowHeight,
            diameterRatio: DateMeasurements.DIAMATER_RATIO,
            physics: FixedExtentScrollPhysics(),
            offAxisFraction: DateMeasurements.OFF_AXIS_MONTH,
            onSelectedItemChanged: (index) {
              _timer?.cancel();
              _timer = Timer(Duration(milliseconds: DateMeasurements.SCROLL_DELAY_MILLISECONDS), () {
                dateTimeBloc.add(ChangeYearEvent(newYear: index));
              });
            },
            useMagnifier: true,
            magnification: DateMeasurements.MAGNIFICATION,
            childDelegate: ListWheelChildBuilderDelegate(builder: (BuildContext context, int index) {
              final year = BASE_YEAR + index;
              return Text('$year', style: _pickerSize.textStyle);
            }),
          ),
        );
      },
    );
  }

  void _animateColumn({@required int toRow, @required int animationDurationInMilliSeconds}) {
    final double distance = toRow * _pickerSize.rowHeight;
    Future.delayed(Duration(microseconds: DateMeasurements.ANIMIATE_DELAY_MICROSECONDS), () {
      _scrollController.jumpTo(distance);
    });
  }
}
