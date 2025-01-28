
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/DateTime.dart';
import 'package:flutter_uniapp_demo/common/model/week.dart';
import 'package:flutter_uniapp_demo/page/subject/model/target_schedule.dart';
import 'package:flutter_uniapp_demo/page/subject/service/http.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'model/course.dart';
import 'model/course_schedule.dart';
import 'package:collection/collection.dart';
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
  final Rx<List<CourseSchedule>> _subScheduleTimes =Rx<List<CourseSchedule>>([]);
  List<CourseSchedule> get subScheduleTimes => _subScheduleTimes.value;
  set subScheduleTimes(List<CourseSchedule> val) => _subScheduleTimes.value = val;

  /// 课程 （周一到周天： size=7）
  final Rx<Map<Weekday, List<Course>>> _curs = Rx<Map<Weekday, List<Course>>>({});
  List<ScheduleCell> curs(Weekday week, {bool padding=true}) {
    List<ScheduleCell> data = !_curs.value.containsKey(week)
        ? []
        : _curs.value[week]!.sorted((Course c1, Course c2)=>c1.startIndex-c2.startIndex);
    if(padding){
      // padding
      List<ScheduleCell> rt = [];
      var nextIndex = 1;
      for(var i=0;i<data.length;){
        var it = data[i];
        if(it.startIndex==nextIndex) {
          rt.add(it);
          i++;
        }else{
          // add paddingCell
          rt.add(PaddingCell(week: week, startIndex: nextIndex, endIndex: nextIndex));
          nextIndex+=1;
        }
      }
      return rt;
    }
    return data;
  }
  /// 目标
  List<TargetSchedule> targetSchedule = [];

  @override
  void onReady() {
    targetSchedule = SubjectHttpApi.instance.queryTargetSchedule();
    _curs.value = SubjectHttpApi.instance.queryScheduleCourse().groupListsBy((e)=>e.week);
    subScheduleTimes = SubjectHttpApi.instance.queryCourseSchedule();
  }

  /// 底部周选择抽屉
  showWeekSelectorSheet(BuildContext context, int currWeek){
    bool isCurrWeek(int week)=>week==currWeek;
    showMaterialModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(6),
          ),
        ),
        builder: (context){
          return SizedBox(
            height: 420,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text("查看周课表", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Color(0xff222222)),),
                      Text("修改当前周", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff32B7B3)),),
                    ],
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: List.generate(25, (i){
                        return Container(
                          decoration: BoxDecoration(
                            color: !isCurrWeek(i+1)?const Color(0xfff1f1f1):const Color(0xff32b7b3),
                            borderRadius: const BorderRadius.all(Radius.circular(4))
                          ),
                          alignment: Alignment.center,
                          child: !isCurrWeek(i+1)?Text("${i+1}"):const Text("本周",style: TextStyle(color: Colors.white),),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }


}


