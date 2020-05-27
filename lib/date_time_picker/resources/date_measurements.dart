import 'package:flutter/material.dart';
import 'package:flutter_project_package/mode_themes/mode_color.dart';
import 'package:flutter_project_package/mode_themes/mode_definiations.dart';

import '../common.dart';

enum Meridian { AM, PM }
enum DateMode { formal, scientific }
enum DatePickerType { date, time }

const Color DATE_BACKGROUND_COLOR = const Color.fromARGB(255, 0, 191, 255);
const Color DATE_FOCUS_COLOR = const Color.fromARGB(255, 100, 149, 237);
const Color TIME_BACKGROUND_COLOR = const Color.fromARGB(255, 135, 206, 250);
const Color TIME_FOCUS_COLOR = const Color.fromARGB(255, 100, 149, 237);

const int BASE_YEAR = 1800;

mixin DateMeasurements {
  static const int ANIMATION_DURATION_MILLISECONDS = 1;
  static const int ANIMIATE_DELAY_MICROSECONDS = 1;
  static const double COUNT_OF_TIME_ELEMENTS = 5.0;
  static const double DIAMATER_RATIO = 4.0;
  static const double MAGNIFICATION = 1.2;
  static const double OFF_AXIS_YEAR = -0.2;
  static const double OFF_AXIS_MONTH = 0.0;
  static const double OFF_AXIS_DAY = 0.2;
  static const int SCROLL_DELAY_MILLISECONDS = 100;
  static const int FEBRUARY = 2;

  bool _isLeapYear(int year) => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  int numberOfDaysIn({@required int month, @required int year}) {
    final List<int> lengths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return (_isLeapYear(year) && month == FEBRUARY) ? 29 : lengths[month];
  }

  TextStyle pickerTabButtonStyle(BuildContext context, {@required PickerSize pickerSize, ModeColor modeColors}) {
    final colors = modeColors ?? ModeDefiniation.contrastColors;
    final textStyle = Theme.of(context).textTheme.button.merge(pickerSize.textStyle).merge(
          TextStyle(
            color: colors.color(context),
          ),
        );
    return textStyle;
  }

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'Decemeber',
  ];
}
