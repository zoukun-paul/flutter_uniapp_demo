

import 'package:flutter/material.dart';

extension DateTimeExtend on DateTime {

  /// 当前周
  List<DateTime> currWeekDays(){
    final startOfWeek = subtract(Duration(days: weekday - 1));
    List<DateTime> thisWeekDays = [];
    for (int i = 0; i < 7; i++) {
      thisWeekDays.add(startOfWeek.add(Duration(days: i)));
    }
    return thisWeekDays;
  }

  DateTime time({
  int? hour,
  int? minute,
  int? second,
  int? millisecond,
  int? microsecond}){
    return copyWith(hour: hour, minute: minute, second: second,millisecond: millisecond,microsecond:microsecond);
  }
}
