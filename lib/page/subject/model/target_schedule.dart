

import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// 大学目标数据模型类
class TargetSchedule {

  /// 截至日期
  final DateTime deadline;

  /// 标题名称
  final String title;

  /// 备注
  final String? note;

  /// 地点
  final String? location;

  TargetSchedule({required this.planType, required this.deadline, required this.title, this.note, this.location});

  final TargetSchedulePlanType planType;

}

enum TargetSchedulePlanType {

  everyDay(1,"每天"),

  everyWeek(2, "每周"),

  everyMonth(3, "每月"),

  everyYear(4, "每年"),

  custom(5, "自定义"),
  ;
  final int code;
  final String desc;

  const TargetSchedulePlanType(this.code, this.desc);

  Color get color{
    switch(this){
      case TargetSchedulePlanType.everyDay: return const Color(0xff32b7b3);
      case TargetSchedulePlanType.everyWeek: return const Color(0xfffa8c16);
      case TargetSchedulePlanType.everyMonth: return const Color(0xffeb2f96);
      case TargetSchedulePlanType.everyYear:return const Color(0xff00aeff);
      case TargetSchedulePlanType.custom:return const Color(0xff1677ff);
    }
  }

  List<Color> get bgColor {
    switch(this){
      case TargetSchedulePlanType.everyDay: return [const Color(0xffe0f4f4), const Color(0xffeff9f9)];
      case TargetSchedulePlanType.everyWeek: return [const Color(0xfffeeedc),const Color(0xfffef6ed)];
      case TargetSchedulePlanType.everyMonth: return [const Color(0xfffce0ef),const Color(0xfffdeff7)];
      case TargetSchedulePlanType.everyYear:return [const Color(0xffdaf3ff), const Color(0xffebf9ff)];
      case TargetSchedulePlanType.custom:return [const Color(0xffddebff), const Color(0xffedf5ff)];
    }
  }


}