

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_controller.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_style.dart';

class SubjectPage extends GetStyleView<SubjectStyle,SubjectController> {

  @override
  Widget proxyBuild(BuildContext context) {
    return Column(
      children: [
        style.header(),
        // Expanded(
        //     child: GridView.custom(
        //       gridDelegate: null,
        //       childrenDelegate: null,
        //     )
        // )
      ],
    );
  }

}
