import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import '../common.dart';

abstract class DayTimeEvent extends Equatable {
  const DayTimeEvent();
  @override
  List<Object> get props => [];
}

class UserSetDateTimeEvent extends DayTimeEvent {
  const UserSetDateTimeEvent();
  @override
  String toString() => 'UserSetDateTimeEvent {}';
}

class ChangeYearEvent extends DayTimeEvent {
  final int newYear;
  const ChangeYearEvent({this.newYear});

  @override
  List<Object> get props => [newYear];

  @override
  String toString() => 'ChangeYearEvent {newYear: $newYear}';
}

class ChangeMonthEvent extends DayTimeEvent {
  final int newMonth;
  const ChangeMonthEvent({this.newMonth});

  @override
  List<Object> get props => [newMonth];

  @override
  String toString() => 'ChangeMonthEvent {newMonth: $newMonth}';
}

class ChangeDayEvent extends DayTimeEvent {
  final int newDay;
  const ChangeDayEvent(this.newDay);

  @override
  List<Object> get props => [newDay];

  @override
  String toString() => 'ChangeDayEvent {newDay: $newDay}';
}

class SetMeridianEvent extends DayTimeEvent {
  final Meridian meridian;
  const SetMeridianEvent(this.meridian);

  @override
  List<Object> get props => [meridian];

  @override
  String toString() => 'SetMeridianEvent {meridian ${EnumToString.parse(meridian)}';
}

class SetSecondEvent extends DayTimeEvent {
  final int second;
  const SetSecondEvent({this.second});

  @override
  List<Object> get props => [second];

  @override
  String toString() => 'SetSecondEvent {second $second}';
}

class SetMinuteEvent extends DayTimeEvent {
  final int minute;
  const SetMinuteEvent({this.minute});

  @override
  List<Object> get props => [minute];

  @override
  String toString() => 'SetMinuteEvent {minute $minute}';
}

class SetHourEvent extends DayTimeEvent {
  final int hour;
  const SetHourEvent({this.hour});

  @override
  List<Object> get props => [hour];

  @override
  String toString() => 'SetHourEvent {hour: $hour}';
}

class MoveDayPickerEvent extends DayTimeEvent {
  final int newDay;
  const MoveDayPickerEvent(this.newDay);

  @override
  List<Object> get props => [newDay];

  @override
  String toString() => 'MoveDayPickerEvent {newDay: $newDay}';
}

class RefreshEvent extends DayTimeEvent {
  const RefreshEvent();

  @override
  String toString() => 'RefreshEvent {}';
}
