import '../common.dart';

class PickerToggleWidget extends StatefulWidget {
  final PickerSize _pickerSize;

  PickerToggleWidget({Key key, @required PickerSize pickerSize})
      : _pickerSize = pickerSize,
        super(key: key);

  @override
  _PickerToggleWidget createState() => _PickerToggleWidget();
}

class _PickerToggleWidget extends State<PickerToggleWidget>
    with WidgetsBindingObserver, AfterLayoutMixin<PickerToggleWidget> {
  DateWidget _dateWidget;
  TimeWidget _timeWidget;

  @override //- WidgetBindingObserver
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {}

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _dateWidget = DateWidget(
      dateMode: DateMode.scientific,
      pickerSize: widget._pickerSize,
    );
    _timeWidget = TimeWidget(
      pickerSize: widget._pickerSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _stack(context);
  }

  Widget _stack(BuildContext context) {
    final DateTimeBloc dateTimeBloc = context.bloc<DateTimeBloc>();
    return BlocBuilder<PickerBloc, PickerState>(builder: (BuildContext context, PickerState pickerState) {
      if (pickerState is InitialPickerState) {
        return _dateWidget;
      } else if (pickerState is SwitchPickerState) {
        dateTimeBloc.add(RefreshEvent());
        return (pickerState.datePickerType == DatePickerType.date) ? _dateWidget : _timeWidget;
      } else {
        return Text('(root_widget) Unknown State: ${pickerState.toString()}');
      }
    });
  }
}
