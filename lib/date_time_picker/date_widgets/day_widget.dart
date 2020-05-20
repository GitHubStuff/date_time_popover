import 'dart:async';
import '../common.dart';

final FixedExtentScrollController _scrollController = FixedExtentScrollController();
Timer _timer;

class DayWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  final PickerSize _pickerSize;

  DayWidget(this._pickerSize, {Key key}) : super(key: key);

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
          _animateColumn(toRow: dayState.dateTime.day - 1, animationDurationInMilliSeconds: 1);
        } else if (dayState is AdjustedDayState) {
          _animateColumn(toRow: dayState.newDay - 1, animationDurationInMilliSeconds: 1000);
        } else if (dayState is ReloadedDayState) {
          _animateColumn(toRow: 20, animationDurationInMilliSeconds: 10);
          Future.delayed(Duration(milliseconds: 12), () {
            _animateColumn(toRow: dayState.newDay - 1, animationDurationInMilliSeconds: 1000);
          });
        }
        return Container(
          height: _pickerSize.pickerHeight,
          width: _pickerSize.dayWidth,
          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            itemExtent: _pickerSize.rowHeight,
            diameterRatio: DateMeasurements.DIAMATER_RATIO,
            physics: FixedExtentScrollPhysics(),
            offAxisFraction: DateMeasurements.OFF_AXIS_MONTH,
            onSelectedItemChanged: (index) {
              //_dayBloc.add(SetMonthEvent(index));
              _timer?.cancel();
              _timer = Timer(Duration(milliseconds: DateMeasurements.SCROLL_DELAY_MILLISECONDS), () {
                final maxDays = numberOfDaysIn(
                  month: dateTimeBloc.currentDateTime.month,
                  year: dateTimeBloc.currentDateTime.year,
                );
                final day = (index % maxDays) + 1;
                if (day > maxDays) {
                  _animateColumn(toRow: index - 1, animationDurationInMilliSeconds: 200);
                } else {
                  dateTimeBloc.add(ChangeDayEvent(day));
                }
              });
            },
            useMagnifier: true,
            magnification: DateMeasurements.MAGNIFICATION,
            childDelegate: ListWheelChildBuilderDelegate(builder: (BuildContext context, int index) {
              final maxDays = numberOfDaysIn(
                month: dateTimeBloc.currentDateTime.month,
                year: dateTimeBloc.currentDateTime.year,
              );
              final day = (index % maxDays) + 1;
              final text = (day > maxDays) ? '-' : '$day';
              return Text(text, style: _pickerSize.textStyle);
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
