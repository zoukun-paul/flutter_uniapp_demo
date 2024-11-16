


import 'package:flutter_uniapp_demo/common/extension/DateTime.dart';

import 'subject_controller.dart';

List<CourseSchedule> get standardCourseSchedule  {
  final date = DateTime.now();
  return [
    CourseSchedule(startTime: date.time(hour: 8,minute: 0), endDateTime: date.time(hour: 8, minute: 45)),
    CourseSchedule(startTime: date.time(hour: 8,minute: 50), endDateTime: date.time(hour: 9, minute: 35)),
    CourseSchedule(startTime: date.time(hour: 10,minute: 5), endDateTime: date.time(hour: 10, minute: 50)),
    CourseSchedule(startTime: date.time(hour: 10,minute: 55), endDateTime: date.time(hour: 11, minute: 40)),
    CourseSchedule(startTime: date.time(hour: 12,minute: 30), endDateTime: date.time(hour: 13, minute: 15)),
    CourseSchedule(startTime: date.time(hour: 13,minute: 20), endDateTime: date.time(hour: 14, minute: 5)),
    CourseSchedule(startTime: date.time(hour: 14,minute: 30), endDateTime: date.time(hour: 15, minute: 15)),
    CourseSchedule(startTime: date.time(hour: 15,minute: 20), endDateTime: date.time(hour: 16, minute: 5)),
  ];
}