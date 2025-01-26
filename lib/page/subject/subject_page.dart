
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/model/week.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_style.dart';
import 'package:get/get.dart';

class SubjectPage extends GetStyleView<SubjectStyle, SubjectController> {

  @override
  Widget proxyBuild(BuildContext context) {
    return Column(
      children: [
        style.header(),
        divider(size: 1, bgColor: const Color(0xffE5E5E5), horizontal: true),
        Expanded(
          child: Stack(
            children: [
              /// 课程表 星期栏
              Positioned(
                  top:0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: style.scheduleHeaderRow(),
                  )
              ),
              Positioned(
                  top: style.weekCellHeight,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 时间列
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...controller.subScheduleTimes.mapIndex((e,i)=>style.scheduleCell(i+1, e))
                          ],
                        ),
                        /// 课程表主体
                        Obx(
                          ()=>Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [...style.courseCells(controller.curs(Weekday.monday))],),
                              Column(children: [...style.courseCells(controller.curs(Weekday.tuesday))],),
                              Column(children: [...style.courseCells(controller.curs(Weekday.wednesday))],),
                              Column(children: [...style.courseCells(controller.curs(Weekday.thursday))],),
                              Column(children: [...style.courseCells(controller.curs(Weekday.friday))],),
                              Column(children: [...style.courseCells(controller.curs(Weekday.saturday))],),
                              Column(children: [...style.courseCells(controller.curs(Weekday.sunday))],),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        )
      ],
    );
  }

}