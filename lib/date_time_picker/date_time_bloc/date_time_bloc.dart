import 'package:flutter_project_package/tracers/tracers.dart' as Log;

import '../common.dart';

enum DateTimeElements { year, month, day, hour, minute, second }

class DateTimeBloc extends Bloc<DayTimeEvent, DateTimeState> with DateMeasurements {
  DateTime _currentDateTime;
  DateTime get currentDateTime => _currentDateTime;
  Meridian _meridian;

  DateTimeBloc(this._currentDateTime) {
    _meridian = _currentDateTime.hour < 12 ? Meridian.AM : Meridian.PM;
  }

  @override
  DateTimeState get initialState => InitialDayState(_currentDateTime);

  @override
  Stream<DateTimeState> mapEventToState(DayTimeEvent event) async* {
    if (event is UserSetDateTimeEvent) {
      yield DateTimeSetState(currentDateTime);
    } else if (event is ChangeYearEvent) {
      yield* _changeYear(event.newYear);
    } else if (event is ChangeMonthEvent) {
      yield* _changeMonth(event.newMonth);
    } else if (event is SetSecondEvent) {
      yield* _set(DateTimeElements.second, toValue: event.second);
    } else if (event is SetMeridianEvent) {
      yield* _setMeridian(event.meridian);
    } else if (event is SetMinuteEvent) {
      yield* _set(DateTimeElements.minute, toValue: event.minute);
    } else if (event is SetHourEvent) {
      yield* _setHour(event.hour);
    } else if (event is MoveDayPickerEvent) {
      yield AdjustedDayState(event.newDay);
    } else if (event is ChangeDayEvent) {
      yield* _set(DateTimeElements.day, toValue: event.newDay);
    } else if (event is RefreshEvent) {
      yield InitialDayState(_currentDateTime);
    } else {
      Log.e('FAKE STATE... should not get here {day_bloc#29}');
      throw Exception('Unknown event ${event.toString()}');
    }
  }

  Stream<DateTimeState> _setMeridian(Meridian meridian) async* {
    int hour;
    _meridian = meridian;
    switch (meridian) {
      case Meridian.AM:
        hour = (_currentDateTime.hour >= 12) ? _currentDateTime.hour - 12 : _currentDateTime.hour;
        break;
      case Meridian.PM:
        hour = (_currentDateTime.hour <= 12) ? _currentDateTime.hour + 12 : _currentDateTime.hour;
        break;
    }
    yield* _set(DateTimeElements.hour, toValue: hour);
  }

  Stream<DateTimeState> _setHour(int hour) async* {
    final boundedHour = (hour % 12) + 1;
    int newHour;
    if (boundedHour == 12) {
      newHour = (_meridian == Meridian.AM) ? 0 : 12;
    } else {
      newHour = (_meridian == Meridian.AM) ? boundedHour : boundedHour + 12;
    }
    yield* _set(DateTimeElements.hour, toValue: newHour);
  }

  Stream<DateTimeState> _set(DateTimeElements element, {int toValue}) async* {
    _currentDateTime = DateTime(
      (element == DateTimeElements.year) ? toValue : _currentDateTime.year,
      (element == DateTimeElements.month) ? toValue : _currentDateTime.month,
      (element == DateTimeElements.day) ? toValue : _currentDateTime.day,
      (element == DateTimeElements.hour) ? toValue : _currentDateTime.hour,
      (element == DateTimeElements.minute) ? toValue % 60 : _currentDateTime.minute,
      (element == DateTimeElements.second) ? toValue % 60 : _currentDateTime.second,
      0,
      0,
    );
    yield UpdateDateTimeState(_currentDateTime);
  }

  Stream<DateTimeState> _setLeapYearDate(DateTime dateTime) async* {
    _currentDateTime = dateTime;
    if (_currentDateTime.day > 27) {
      yield ReloadedDayState(dateTime.day);
    } else {
      yield UpdateDateTimeState(_currentDateTime);
    }
  }

  Stream<DateTimeState> _setNonLeapYear(DateTime dateTime) async* {
    _currentDateTime = dateTime;
    yield UpdateDateTimeState(_currentDateTime);
  }

  Stream<DateTimeState> _changeYear(int newYear) async* {
    final yearIndex = newYear + BASE_YEAR;
    final isFebruary = currentDateTime.month == DateMeasurements.FEBRUARY;
    DateTime newDate = DateTime(
      yearIndex,
      currentDateTime.month,
      currentDateTime.day,
      currentDateTime.hour,
      currentDateTime.minute,
      currentDateTime.second,
      0,
      0,
    );
    if (isFebruary) {
      //Moved out of a leap year
      if (newDate.month != DateMeasurements.FEBRUARY) {
        final daysInMonth = numberOfDaysIn(month: DateMeasurements.FEBRUARY, year: newDate.year);
        newDate = DateTime(
          yearIndex,
          DateMeasurements.FEBRUARY,
          daysInMonth,
          newDate.hour,
          newDate.minute,
          newDate.second,
          0,
          0,
        );
      }
      yield* _setLeapYearDate(newDate);
    } else {
      yield* _setNonLeapYear(newDate);
    }
  }

  Stream<DateTimeState> _changeMonth(int newMonth) async* {
    final monthIndex = (newMonth % 12) + 1;
    int modifyDay = _currentDateTime.day;
    DateTime newDate = DateTime(
      currentDateTime.year,
      monthIndex,
      modifyDay,
      currentDateTime.hour,
      currentDateTime.minute,
      currentDateTime.second,
      0,
      0,
    );
    if (newDate.day != currentDateTime.day) {
      modifyDay = numberOfDaysIn(month: monthIndex, year: currentDateTime.year);
      newDate = DateTime(
        currentDateTime.year,
        monthIndex,
        modifyDay,
        currentDateTime.hour,
        currentDateTime.minute,
        currentDateTime.second,
        0,
        0,
      );
      yield ReloadedDayState(modifyDay);
    }

    yield* _setLeapYearDate(newDate);
  }
}
