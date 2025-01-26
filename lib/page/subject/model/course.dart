import 'dart:core';

import 'package:flutter_uniapp_demo/common/model/week.dart';

class Course extends ScheduleCell{

  /// 课程名称
  final String name;

  /// 上课位置
  final String location;

  /// 老师
  final String teacher;


  Course({required super.week, required super.startIndex, required super.endIndex,required this.name, required this.location, required this.teacher})
  :assert(startIndex < endIndex && startIndex>0)
  ;

}


abstract class ScheduleCell {

  /// 从1开始
  final int startIndex;

  final int endIndex;

  final Weekday week;

  int get count => endIndex - startIndex + 1;

  ScheduleCell({required this.week, required this.startIndex, required this.endIndex});

}

class PaddingCell extends ScheduleCell{

  PaddingCell({required super.week, required super.startIndex, required super.endIndex});

}
