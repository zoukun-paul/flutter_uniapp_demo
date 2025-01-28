

import 'dart:ffi';

import 'package:chinese_number/chinese_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_uniapp_demo/common/const.dart';
import 'package:flutter_uniapp_demo/common/extension/color.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/key_value_pair.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'goal_page/goal_page.dart';
import 'lovers_course_page/lovers_course_page.dart';
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

  /// 学期信息
  Widget semester(){
    return SizedBox(
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
          SvgPicture
              .asset("assets/subject/xysub.svg",colorFilter: const ColorFilter.mode(Color(0xffff619b), BlendMode.srcIn))
              .onTap((){
            Routers.toPage(LoversCoursePage());
          })
        ],
      ),
    );
  }

  /// 学期目标
  Widget target(BuildContext ctx){
    return Row(
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
                ), label("还有71天",)].span(size: 6).row(),
              ],
            ).onTap(()=>Routers.toPage(GoalPage()))
          ],
        ),
        Row(
          children: [
            ...[
              /// 周
              SvgPicture.asset("assets/subject/week.svg",).onTap((){
                controller.showWeekSelectorSheet(ctx, controller.currWeek);
              }),
              SvgPicture.asset("assets/subject/filter.svg"),
              SvgPicture.asset("assets/subject/add.svg"),
            ].span(size: 16)
          ],
        )
      ],
    );
  }

  Widget header(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: Const.statusBarHeight,),
          semester(),
          SizedBox(
            height: _noticeBoxHeaderHeight,
            child: target(context),
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

  Widget scheduleCell(int index, CourseSchedule courseSchedule){
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
      var color = bgColor(course.name);
      child = Container(
        width: cellWith,
        height: cellHeight * course.count,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            border: Border.all(color: color, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Center(
            child: Text(
              "${course.name}@${course.location}",
              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500, color: color),
            ),
          )
        ),
      );
    }
    return child;
  }

  List<Widget> courseCells(List<ScheduleCell> courses)=>courses.map((e)=>courseCell(e)).toList();

  /// 系统默认的课程表背景颜色
  List<KeyValuePair<Color, String?>> sysCourseBgColor = [
    KeyValuePair(key: const Color(0xff32b7b3), value: null),
    KeyValuePair(key: const Color(0xff1677ff), value: null),
    KeyValuePair(key: const Color(0xff8648dd), value: null),
    KeyValuePair(key: const Color(0xffeb2f96), value: null),

    KeyValuePair(key: const Color(0xfff5222d), value: null),
    KeyValuePair(key: const Color(0xfffa8c16), value: null),
    KeyValuePair(key: const Color(0xff17c540), value: null),
    KeyValuePair(key: const Color(0xffffd000), value: null),

    KeyValuePair(key: const Color(0xffff7b00), value: null),
    KeyValuePair(key: const Color(0xff5953fe), value: null),
    KeyValuePair(key: const Color(0xff00aeff), value: null),
    KeyValuePair(key: const Color(0xff71bf0b), value: null),
  ];

  Color bgColor(String name){
    if(sysCourseBgColor.where((e)=>e.value==null).isEmpty){
      // 系统颜色不够
      return  Colors.cyan;
    }
    var index = name.hashCode%sysCourseBgColor.length;
    while(true){
      index = index%(sysCourseBgColor.length);
      var pair =  sysCourseBgColor[index];
      if(pair.value==null || name == pair.value){
        pair.value ??= name;
        print("$name=${pair.key}");
        return pair.key;
      }
      index+=1;
    }
  }

}