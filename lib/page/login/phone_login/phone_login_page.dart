

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';
import 'package:flutter_uniapp_demo/page/login/phone_login/phone_login_style.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:get/get.dart';
import 'phone_login_controller.dart';

final class PhoneLoginPage extends GetStyleView<PhoneLoginStyle,PhoneLoginController> {

  PhoneLoginPage({super.key});

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
              child: Obx( ()=> Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        header(actionText: "手机密码登录", actionTextOnTap: ()=>Routers.toPwdLoginPage()),
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


