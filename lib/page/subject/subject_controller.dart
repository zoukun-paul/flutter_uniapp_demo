
import 'package:flutter_uniapp_demo/common/extension/DateTime.dart';
import 'package:get/get.dart';

import 'common.dart';

class SubjectController extends GetxController {

  final Rx<int> _currWeek = (DateTime.now().weekday).obs;
  int get currWeek => _currWeek.value;
  set currWeek(int week) => _currWeek.value=week;

  final _semester = "2024-2025 第一学期".obs;
  String get semester => _semester.value;
  set semester(semester) => _semester.value=semester;

  /// 当前周
  final _weekDays = ( DateTime.now().currWeekDays()).obs;
  List<DateTime> get weekDays =>  _weekDays;


  /// 时间表
  List<CourseSchedule> subScheduleTimes = standardCourseSchedule;

}

class CourseSchedule {

  final DateTime startTime;

  final DateTime endDateTime;

  // 0 表示课程时间
  final int type;

  CourseSchedule({required this.startTime, required this.endDateTime,this.type=0});
}

class Course {

  /// 课程名称
  final String name;

  /// 上课位置
  final String location;

  /// 老师
  final String teacher;

  /// 开始时间
  final DateTime startTime;

  /// 结束时间
  final DateTime endTime;

  /// 课程开始日期
  final DateTime startDate;

  /// 课程结束日期
  final DateTime endDate;

  Course(this.startTime, this.endTime, this.startDate, this.endDate, {required this.name, required this.location, required this.teacher});

}

