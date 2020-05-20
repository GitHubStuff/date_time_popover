import 'dart:async';

import '../common.dart';

final FixedExtentScrollController _scrollController = FixedExtentScrollController();
Timer _timer;

class MinuteWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  final PickerSize _pickerSize;

  MinuteWidget(this._pickerSize, {Key key}) : super(key: key);

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
          _animateColumn(toRow: dayState.dateTime.minute, animationDurationInMilliSeconds: 1);
        }
        return Container(
          height: _pickerSize.pickerHeight,
          width: _pickerSize.timeElementWidth,
          child: ListWheelScrollView.useDelegate(
            controller: _scrollController,
            itemExtent: _pickerSize.rowHeight,
            diameterRatio: DateMeasurements.DIAMATER_RATIO,
            physics: FixedExtentScrollPhysics(),
            offAxisFraction: DateMeasurements.OFF_AXIS_MONTH,
            onSelectedItemChanged: (index) {
              _timer?.cancel();
              _timer = Timer(Duration(milliseconds: DateMeasurements.SCROLL_DELAY_MILLISECONDS), () {
                dateTimeBloc.add(SetMinuteEvent(minute: index));
              });
            },
            useMagnifier: true,
            magnification: DateMeasurements.MAGNIFICATION,
            childDelegate: ListWheelChildBuilderDelegate(builder: (BuildContext context, int index) {
              final minute = (index % 60);
              return Text('${minute.toString().padLeft(2, '0')}', style: _pickerSize.textStyle);
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
