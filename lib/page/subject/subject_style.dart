

import 'package:chinese_number/chinese_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:intl/intl.dart';

class SubjectStyle extends Style<SubjectController> {

  Widget header(){
    return Column(
      children: [
        const SafeArea(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SvgPicture.asset("assets/subject/xysub.svg")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("全国大学生英语四六级考试", style: TextStyle(fontSize: 14),),
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
                  SvgPicture.asset("assets/subject/week.svg"),
                  SvgPicture.asset("assets/subject/filter.svg"),
                  SvgPicture.asset("assets/subject/add.svg"),
                ].span(size: 16)
              ],
            )
          ],
        )
      ],
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
    return Column(
      children: [
        Text(
          monthModel?"${dateTime.month}":dateTime.weekday.toSimplifiedChineseNumber(),
          style: const TextStyle(color: Color(0xff222222),fontWeight: FontWeight.w500),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: isCurrDay?activeColor:null,
              borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          child: Text(
            "${monthModel?'月':dateTime.day}",
            style:monthModel ? null : TextStyle(color: isCurrDay?Colors.white:const Color(0xff777777)),
          ),
        ),
      ],
    );
  }

  Widget scheduleCell(int index ,CourseSchedule courseSchedule){
    return Column(
      children: [
        Text("$index"),
        Text(DateFormat("HH:mm").format(courseSchedule.startTime)),
        Text(DateFormat("HH:mm").format(courseSchedule.endDateTime)),
      ],
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

}