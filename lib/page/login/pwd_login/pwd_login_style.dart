

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_controller.dart';
import 'package:remixicon/remixicon.dart';

class PwdLoginStyle extends Style<PwdLoginController> {

  Widget formBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textField(labelText: "请输入手机号",onChange: (val)=>controller.phoneNumber=val,),
          textField(
            labelText: "请输入密码",
            obscureText:controller.obscureText,
            onChange: (val)=>controller.password=val,
            suffix: IconButton(
            icon: Icon(controller.obscureText?Remix.eye_close_line:Remix.eye_line, color: const Color(0xff999999),),
              onPressed: () =>controller.obscureText = !controller.obscureText,
            ),
          ),
          contract(selected: controller.agreeContract,onTap: (e)=>controller.agreeContract=e),
          actionBtn(active: controller.loginActive, onTap: controller.submit),
          optionAction(),
        ].span(size: 24, vertical: true),
      ),
    );
  }

}