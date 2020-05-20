import '../common.dart';
abstract class PickerState extends Equatable {
  const PickerState();

  @override
  List<Object> get props => [];
}

class InitialPickerState extends PickerState {
  const InitialPickerState();
  @override
  String toString() => 'InitialPickerState {}';
}

class SwitchPickerState extends PickerState {
  final DatePickerType datePickerType;
  const SwitchPickerState({@required this.datePickerType});

  @override
  List<Object> get props => [datePickerType];

  @override
  String toString() => 'SwitchPickerState {}';
}
