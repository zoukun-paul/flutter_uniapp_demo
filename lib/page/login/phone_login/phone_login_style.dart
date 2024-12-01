

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';

import 'phone_login_controller.dart';

class PhoneLoginStyle extends Style<PhoneLoginController> {


  Widget formBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textField(labelText: "请输入手机号",onChange: (val)=>controller.phoneNumber=val,),
          VerificationField(labelText: "请输入验证码", onChange: (val)=>controller.phoneVerificationCode=val),
          contract(selected: controller.agreeContract,onTap: (e)=>controller.agreeContract = !controller.agreeContract).onTap((){
            controller.agreeContract = !controller.agreeContract;
          }),
          actionBtn(active: controller.loginActive, onTap: controller.submit),
          const Text("若手机号未注册、登录后会自动注册",style: TextStyle(color: Color(0xffbcbcbc)),).center(),
          optionAction(),
        ].span(size: 24, vertical: true),
      ),
    );
  }

}