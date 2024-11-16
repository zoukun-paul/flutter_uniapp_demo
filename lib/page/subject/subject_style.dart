

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';

class SubjectStyle extends Style<SubjectController> {

  Widget header(){
    return Column(
      children: [
        const SafeArea(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(controller.currWeek, style: const TextStyle(fontSize: 16),),
            const Icon(Icons.keyboard_arrow_right_outlined),
            const SizedBox(width: 6,),
            Text(controller.semester, style: const TextStyle(color: Color(0xff999999)),)
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("全国大学生英语四六级考试", style: TextStyle(fontSize: 18),),
                [Text("2024年12月31日", style: TextStyle(color: Color(0xff777777)),), label("还有71天")].span(size: 6).row(),
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
      child: Text(msg, style: const TextStyle(color: Color(0xfffdbf15)),),
    );
  }

  Widget get courseTableHeader => Row(

  );
}