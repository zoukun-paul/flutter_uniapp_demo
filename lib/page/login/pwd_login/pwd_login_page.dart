

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_controller.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_style.dart';
import 'package:get/get.dart';

class PwdLoginPage extends GetStyleView<PwdLoginStyle,PwdLoginController> {

  PwdLoginPage({super.key});

  @override
  Widget proxyBuild(BuildContext context) {
      return GestureDetector(
        onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Obx(()=> Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        header(),
                        style.formBody(),
                      ],
                    ),
                    otherLogin().margin(bottom: 40),
                  ],
                ),
                ),
              ),
            ) // 页面内容，包含 TextField
        ),
      );
  }

}
