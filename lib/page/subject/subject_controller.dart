
import 'package:get/get.dart';

class SubjectController extends GetxController {

  final _currWeek = "第八周".obs;
  String get currWeek => _currWeek.value;
  set currWeek(week) => _currWeek.value=week;

  final _semester = "2024-2025 第一学期".obs;
  String get semester => _semester.value;
  set semester(semester) => _semester.value=semester;


  queryCourse(int currWeek){
    return [];
  }

}

class CourseSchedule {

  /// 课程表
  List<Course> course = [];

  /// 课程开始时间
  final DateTime startTime;

  final DateTime endDateTime;

  CourseSchedule(this.startTime, this.endDateTime);

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

