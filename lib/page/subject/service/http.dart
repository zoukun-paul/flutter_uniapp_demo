
import 'package:flutter_uniapp_demo/common/model/Date.dart';
import 'package:flutter_uniapp_demo/common/model/time.dart';
import 'package:flutter_uniapp_demo/common/model/week.dart';
import 'package:flutter_uniapp_demo/page/subject/model/Target_schedule.dart';
import 'package:flutter_uniapp_demo/page/subject/model/course_schedule.dart';

import '../model/course.dart';

abstract class SubjectHttpApi {

  static SubjectHttpApi get instance => SubjectHttpApiMockImpl();

  List<TargetSchedule> queryTargetSchedule({String? userId});

  /// 查询指定日期所在周的课程
  List<Course> queryScheduleCourse({Date date});

  /// 课程表
  List<CourseSchedule> queryCourseSchedule();

}

class SubjectHttpApiImpl extends SubjectHttpApi{

  @override
  List<TargetSchedule> queryTargetSchedule({String? userId}) {
    // TODO: implement query
    throw UnimplementedError();
  }

  @override
  List<Course> queryScheduleCourse({Date? date}) {
    // TODO: implement queryScheduleCourse
    throw UnimplementedError();
  }

  @override
  List<CourseSchedule> queryCourseSchedule() {
    // TODO: implement queryCourseSchedule
    throw UnimplementedError();
  }

}

/// mock data
class SubjectHttpApiMockImpl extends SubjectHttpApi{

  @override
  List<TargetSchedule> queryTargetSchedule({String? userId}) {
    return [
      TargetSchedule(
        deadline: DateTime.now().add(const Duration(days: 21)),
        title: "全国大学生英语四六级考试",
      ),
      TargetSchedule(
          deadline: DateTime.now().add(const Duration(days: 37)),
          title: "高数考试",
          location: "T1体育管"
      )
    ];
  }

  @override
  List<Course> queryScheduleCourse({Date? date}) {
    return [
      Course(week: Weekday.sunday, startIndex: 3, endIndex: 4, name: '线性代数', location: "C2", teacher: "kzou"),
      Course(week: Weekday.friday, startIndex: 1, endIndex: 4, name: '高数', location: "C2", teacher: "kzou")
    ];
  }

  @override
  List<CourseSchedule> queryCourseSchedule()=>[
    CourseSchedule(startTime: Time(hour: 8,minute: 0), endDateTime: Time(hour: 8, minute: 45)),
    CourseSchedule(startTime: Time(hour: 8,minute: 50), endDateTime: Time(hour: 9, minute: 35)),
    CourseSchedule(startTime: Time(hour: 10,minute: 5), endDateTime: Time(hour: 10, minute: 50)),
    CourseSchedule(startTime: Time(hour: 10,minute: 55), endDateTime: Time(hour: 11, minute: 40)),
    CourseSchedule(startTime: Time(hour: 12,minute: 30), endDateTime: Time(hour: 13, minute: 15)),
    CourseSchedule(startTime: Time(hour: 13,minute: 20), endDateTime: Time(hour: 14, minute: 5)),
    CourseSchedule(startTime: Time(hour: 14,minute: 30), endDateTime: Time(hour: 15, minute: 15)),
    CourseSchedule(startTime: Time(hour: 15,minute: 20), endDateTime: Time(hour: 16, minute: 5)),
    CourseSchedule(startTime: Time(hour: 16,minute: 10), endDateTime: Time(hour: 16, minute: 45)),
  ];

}
