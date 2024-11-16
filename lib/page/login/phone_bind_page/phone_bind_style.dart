
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';

import 'phone_bind_controller.dart';

class PhoneBindStyle extends Style<PhoneBindController> {

  Widget formBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textField(labelText: "请输入手机号",onChange: (val)=>controller.phoneNumber=val,),
          VerificationField(labelText: "请输入验证码", onChange: (val)=>controller.phoneVerificationCode=val),
          actionBtn(text:"绑定", active: controller.loginActive, onTap: controller.submit),
        ].span(size: 24, vertical: true),
      ),
    );
  }

}