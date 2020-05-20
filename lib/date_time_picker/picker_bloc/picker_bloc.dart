import '../common.dart';import 'package:flutter_project_package/tracers/tracers.dart' as Log;

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  DatePickerType _datePickerType = DatePickerType.date;
  DatePickerType get datePickerType => _datePickerType;

  @override
  PickerState get initialState => InitialPickerState();

  @override
  Stream<PickerState> mapEventToState(PickerEvent event) async* {
    if (event is TogglePickerEvent) {
      _datePickerType = (_datePickerType == DatePickerType.date) ? DatePickerType.time : DatePickerType.date;
      yield SwitchPickerState(datePickerType: _datePickerType);
    } else if (event is SetPickerTypeEvent) {
      yield SwitchPickerState(datePickerType: event.datePickerType);
    } else {
      Log.f('Unhandled state ${event.toString()}');
    }
  }
}
