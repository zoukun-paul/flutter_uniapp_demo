
import 'package:flutter_uniapp_demo/common/model/time.dart';

class CourseSchedule {

  final Time startTime;

  final Time endDateTime;

  late ScheduleTimeType scheduleTimeType;

  CourseSchedule({required this.startTime, required this.endDateTime, ScheduleTimeType? scheduleTimeType}){
    this.scheduleTimeType = scheduleTimeType ?? _scheduleTimeType(startTime);
  }

  ScheduleTimeType _scheduleTimeType(Time dt){
    if(dt.hour > 0 && dt.hour<13 ){
      return ScheduleTimeType.morning;
    }
    if(dt.hour<19){
      return ScheduleTimeType.afternoon;
    }
    return ScheduleTimeType.evening;
  }
}

enum ScheduleTimeType {

  /// 早上
  morning(1),

  /// 下午
  afternoon(2),

  /// 晚上
  evening(3),

  ;

  final int code;

  const ScheduleTimeType(this.code);


}