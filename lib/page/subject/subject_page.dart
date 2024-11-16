

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_style.dart';

class SubjectPage extends GetStyleView<SubjectStyle,SubjectController> {

  @override
  Widget proxyBuild(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: style.header(),
        ),
        divider(size: 1,bgColor: const Color(0xffE5E5E5), horizontal: true).margin(top: 8,bottom: 8),
        SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 8,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            children: [
              ...controller
                  .weekDays
                  .map((e)=>style.headerCell(e, isCurrDay: DateUtils.isSameDay(DateTime.now(), e)))
                  .toList()
                  .ins(0, style.headerCell(controller.weekDays.first, monthModel: true)),
              // StaggeredGridTile.count(
              //     crossAxisCellCount: 1,
              //     mainAxisCellCount: controller.subScheduleTimes.length,
              //     child: StaggeredGrid.count(crossAxisCount: 1,mainAxisSpacing: 10, children: [
              //       ...controller
              //           .subScheduleTimes
              //           .asMap()
              //           .map((index,ele)=>MapEntry(index, style.scheduleCell(index+1,ele)))
              //           .values
              //     ],)
              // ),
              // StaggeredGridTile.count(
              //     crossAxisCellCount: 7,
              //     mainAxisCellCount: controller.subScheduleTimes.length,
              //     child: Placeholder()
              // ),
            ],
          ),
        )
      ],
    );
  }

}
