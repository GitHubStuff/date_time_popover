import '../common.dart';

abstract class DateTimeState extends Equatable {
  const DateTimeState();

  @override
  List<Object> get props => [];
}

class DateTimeSetState extends DateTimeState {
  final DateTime dateTime;
  const DateTimeSetState(this.dateTime);

  @override
  List<Object> get props => [dateTime];

  @override
  String toString() => 'DateTimeSetState {dateTime: $dateTime}';
}

class UpdateDateTimeState extends DateTimeState {
  final DateTime dateTime;
  const UpdateDateTimeState(this.dateTime);

  @override
  List<Object> get props => [dateTime];

  @override
  String toString() => 'UpdateDateTimeState {dateTime: $dateTime}';
}

class InitialDayState extends DateTimeState {
  final DateTime dateTime;
  const InitialDayState(this.dateTime);

  @override
  List<Object> get props => [dateTime];

  @override
  String toString() => 'InitialDayState {$dateTime}';
}

class ChangedDateTime extends DateTimeState {
  final DateTime dateTime;
  const ChangedDateTime(this.dateTime);

  @override
  List<Object> get props => [dateTime];

  @override
  String toString() => 'ChangedDateTime $dateTime';
}

class AdjustedDayState extends DateTimeState {
  final int newDay;
  const AdjustedDayState(this.newDay);

  @override
  List<Object> get props => [newDay];

  @override
  String toString() => 'AdjustedDayState {newDay: $newDay}';
}

class ReloadedDayState extends DateTimeState {
  final int newDay;
  const ReloadedDayState(this.newDay);

  @override
  List<Object> get props => [newDay];

  @override
  String toString() => 'ReloadedDayState {newDay: $newDay}';
}

class SetMeridianState extends DateTimeState {
  final Meridian meridian;
  const SetMeridianState(this.meridian);

  @override
  List<Object> get props => [meridian];

  @override
  String toString() => 'SetMeridianState {merdian ${EnumToString.parse(meridian)}}';
}
