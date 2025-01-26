

import 'package:chinese_number/chinese_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_uniapp_demo/common/const.dart';
import 'package:flutter_uniapp_demo/common/extension/color.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/model/week.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:intl/intl.dart';

import 'model/course.dart';
import 'model/course_schedule.dart';

class SubjectStyle extends Style<SubjectController> {

  /// 课程表 星期栏 高度
  final weekCellHeight = 56.0;
  final _weekHeaderHeight = 36.0;
  final _noticeBoxHeaderHeight = 67.0;

  /// 课程表 课程单元格最大高度
  final double cellHeight = 67;
  final double cellWith = 45;

  Widget header(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: Const.statusBarHeight,),
          SizedBox(
            height: _weekHeaderHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("第${controller.currWeek.toSimplifiedChineseNumber()}周", style: const TextStyle(fontSize: 15),),
                    const Icon(Icons.keyboard_arrow_right_outlined),
                    const SizedBox(width: 6,),
                    Text(controller.semester, style: const TextStyle(color: Color(0xff999999), fontSize: 14),)
                  ],
                ),
                SvgPicture.asset("assets/subject/xysub.svg",colorFilter: const ColorFilter.mode(Color(0xffff619b), BlendMode.srcIn))
              ],
            ),
          ),
          SizedBox(
            height: _noticeBoxHeaderHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("全国大学生英语四六级考试", style: TextStyle(fontSize: 14),),
                        const SizedBox(height: 5,),
                        [const Text(
                          "2024年12月31日",
                          style: TextStyle(color: Color(0xff777777), fontSize: 12),
                        ),
                        label("还有71天",)].span(size: 6).row(),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    ...[
                      SvgPicture.asset("assets/subject/week.svg",),
                      SvgPicture.asset("assets/subject/filter.svg"),
                      SvgPicture.asset("assets/subject/add.svg"),
                    ].span(size: 16)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget label(String msg){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 0),
      decoration: const BoxDecoration(
        color: Color(0xfffff9e8),
        borderRadius: BorderRadius.all(Radius.circular(3))
      ),
      child: Text(msg, style: const TextStyle(color: Color(0xfffdbf15),fontSize: 12),),
    );
  }

  Widget headerCell(DateTime dateTime, {bool monthModel=false, bool isCurrDay=false}){
    const Color activeColor = Color(0xff32b7b3);
    return SizedBox(
      height: weekCellHeight,
      width: cellWith,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 6,),
          Text(
            monthModel?"${dateTime.month}":dateTime.weekday.toSimplifiedChineseNumber(),
            style: const TextStyle(color: Color(0xff222222),fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4,),
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                color: isCurrDay?activeColor:null,
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Center(
              child: Text(
                "${monthModel?'月':dateTime.day}",
                style:monthModel ? null : TextStyle(color: isCurrDay?Colors.white:const Color(0xff777777)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> scheduleHeaderRow() {
    return controller
        .weekDays
        .map((e)=>headerCell(e, isCurrDay: DateUtils.isSameDay(DateTime.now(), e)))
        .toList()
        .ins(0, headerCell(controller.weekDays.first, monthModel: true))
        .toList();
  }

  Widget scheduleCell(int index ,CourseSchedule courseSchedule){
    return SizedBox(
      height: cellHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$index", style: const TextStyle(fontSize: 14)),
          Text(courseSchedule.startTime.format(DateFormat("HH:mm")), style: const TextStyle(fontSize: 12),),
          Text(courseSchedule.endDateTime.format(DateFormat("HH:mm")), style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget courseCell(ScheduleCell course){
    Widget child = SizedBox(
      height: cellHeight,
    );
    if(course is Course){
      var color = roundColor();
      child = Container(
        width: cellWith,
        height: cellHeight * course.count,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: color.withOpacity(0.6), width: 0.6),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Center(
            child: Text(
              "${course.name}@${course.location}",
              style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
            ),
          )
        ),
      );
    }
    return child;
  }

  List<Widget> courseCells(List<ScheduleCell> courses){
    return courses.map((e)=>courseCell(e)).toList();
  }

}