import '../common.dart';
abstract class PickerEvent extends Equatable {
  const PickerEvent();

  @override
  List<Object> get props => [];
}

class TogglePickerEvent extends PickerEvent {
  const TogglePickerEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TogglePickerEvent {}';
}

class SetPickerTypeEvent extends PickerEvent {
  final DatePickerType datePickerType;

  const SetPickerTypeEvent(this.datePickerType);

  @override
  List<Object> get props => [datePickerType];

  @override
  String toString() => 'SetPickerEventType {datePickerType: ${EnumToString.parse(datePickerType)}';
}
