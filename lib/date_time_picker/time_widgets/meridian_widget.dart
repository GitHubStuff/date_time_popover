import 'dart:async';
import '../common.dart';

final FixedExtentScrollController _scrollController = FixedExtentScrollController();
Timer _timerToKeepSmoothScroll;

class MeridianWidget extends StatelessWidget with WidgetsBindingObserver, DateMeasurements {
  final PickerSize _pickerSize;

  MeridianWidget(this._pickerSize, {Key key}) : super(key: key);

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
          final row = (dayState.dateTime.hour < 12) ? 0 : 1;
          _animateColumn(toRow: row, animationDurationInMilliSeconds: 1);
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
              _timerToKeepSmoothScroll?.cancel();
              _timerToKeepSmoothScroll = Timer(Duration(milliseconds: DateMeasurements.SCROLL_DELAY_MILLISECONDS), () {
                final meridian = (index == 0) ? Meridian.AM : Meridian.PM;
                dateTimeBloc.add(SetMeridianEvent(meridian));
              });
            },
            useMagnifier: true,
            magnification: DateMeasurements.MAGNIFICATION,
            childDelegate: ListWheelChildBuilderDelegate(builder: (BuildContext context, int index) {
              if (index < 0 || index > 1) return null;
              final meridianText = EnumToString.parse((index == 0) ? Meridian.AM : Meridian.PM);
              return Text('$meridianText', style: _pickerSize.textStyle);
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
