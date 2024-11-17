import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_style.dart';

class SubjectPage extends GetStyleView<SubjectStyle, SubjectController> {

  @override
  Widget proxyBuild(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: style.header(),
        ),
        divider(size: 1, bgColor: const Color(0xffE5E5E5), horizontal: true).margin(top: 8, bottom: 8),
        StaggeredGrid.count(
          crossAxisCount: controller.weekDays.length + 1,
          children: style.scheduleHeaderRow(),
        ),
        Expanded(
          child: AlignedGridView.count(
            scrollDirection: Axis.horizontal,
            itemCount: controller.subScheduleTimes.length,
            itemBuilder: (BuildContext context, int index) {
              return style.scheduleCell(index + 1, controller.subScheduleTimes[index]);
              // return Container(height: 20,width: 20,color: Colors.red,);
            },
            crossAxisCount: controller.subScheduleTimes.length,
          ),
        )
      ],
    );
  }


}
