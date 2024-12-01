

import 'package:flutter/material.dart';

import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';
import 'package:flutter_uniapp_demo/page/login/phone_bind_page/phone_bind_controller.dart';
import 'package:flutter_uniapp_demo/page/login/phone_login/phone_login_page.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_page.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:get/get.dart';

import 'phone_bind_style.dart';


/// 绑定电话号码页面
class PhoneBindPage extends GetStyleView<PhoneBindStyle,PhoneBindController> {

  PhoneBindPage({super.key});

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
                      header(
                          actionText: "手机密码登录",
                          title: "Hi, 同学你好! 请绑定手机号码",
                          automaticallyImplyLeading: false,
                          actionTextOnTap: (){
                            if(Get.previousRoute == "/${PwdLoginPage().runtimeType}") {
                              Routers.back();
                            }else{
                              Routers.toPwdLoginPage(type: RouteType.replace);
                            }
                          }),
                      style.formBody(),
                    ],
                  ),
                ],
              ),
              ),
            ),
          ) // 页面内容，包含 TextField
      ),
    );
  }

}

