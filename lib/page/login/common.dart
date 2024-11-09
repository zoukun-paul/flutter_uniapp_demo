

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/get/get_style_view.dart';
import 'package:flutter_uniapp_demo/common/theme.dart';
import 'package:flutter_uniapp_demo/common/widget/checkbox.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

const double _labelSpan = 12;

class VerificationField extends StatefulWidget {
  VerificationField({super.key, this.labelSpan=_labelSpan, this.labelText="请输入验证码", this.text="获取验证码", this.countdownSecond=60,this.onChange});
  final String labelText;
  final double labelSpan;
  final int countdownSecond;
  String text;
  void Function(String)? onChange;

  @override
  State<VerificationField> createState() => _VerificationFieldState();
}

class _VerificationFieldState extends State<VerificationField> {

  int currCountdownSecond = -1;

  bool get sendActive=>currCountdownSecond<=0;

  @override
  Widget build(BuildContext context) {
    return textField(onChange: widget.onChange, labelText: widget.labelText, labelSpan: widget.labelSpan, suffix: Padding(
      padding: EdgeInsets.only(right: widget.labelSpan),
      child: GestureDetector(
        child: Text(
          sendActive?widget.text:'重新发送(${currCountdownSecond}s)',
          style: TextStyle(color:sendActive?AppTheme.primaryColor:const Color(0xff999999)),
        ),
        onTap: (){
          if(currCountdownSecond<=0){
            currCountdownSecond = widget.countdownSecond;
          }
          Timer.periodic(const Duration(seconds: 1), (timer){
            setState(() {
              currCountdownSecond-=1;
            });
            if(currCountdownSecond<0){
              timer.cancel();
            }
          });
        },
      ),
    ));
  }
}

Widget textField({bool obscureText=false,required String labelText, double labelSpan=_labelSpan, Widget? suffix, void Function(String)? onChange}){
  InputBorder border =  UnderlineInputBorder(
      borderSide: BorderSide(color: AppTheme.grayColor[200]!)
  );
  return TextField(
    obscureText:obscureText,
    onChanged: onChange,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [suffix??const SizedBox()],),
      fillColor: const Color(0xffeef5f0),
      filled: false,
      enabledBorder: border,
      focusedBorder: border,
      border: border,
      label: Row(
        children: [
          SizedBox(width: labelSpan,),
          Text(labelText, style: TextStyle(color: AppTheme.fontColor[50]),)
        ],
      ),
    ),
  );
}


Widget actionBtn({bool active=true, void Function()? onTap}){
  return GestureDetector(
    onTap: ()=>onTap?.call(),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: active?const Color(0xff58c6c6):const Color(0xffdddddd),
          borderRadius: const BorderRadius.all(Radius.circular(40))
      ),
      child: const Text("登录",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xffffffff)),
      ),
    ),
  );
}

/// 其他登录方式
Widget otherLogin() {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 30,
          child: Divider(
            height: 20,
            color: Color(0xffdddddd),
          ),
        ),
        const Text("其他登录方式", style: TextStyle(color: Color(0xff999999)),),
        const SizedBox(
          width: 30,
          child: Divider(
            height: 20,
            color: Color(0xffdddddd),
          ),
        ),
      ].span(size: 6),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xff32c774))
          ),
          child: const Icon(
            Remix.wechat_fill,
            color: Color(0xff32c774),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xff000000))
          ),
          child: const Icon(
            Remix.apple_fill,
            color: Color(0xff000000),
          ),
        )
      ].span(size: 80),
    )
  ].span(size: 20, vertical: true),);
}

/// 登录页面同统一头部组件
Widget header({String? actionText, String title="Hi, 同学你好!", void Function()? actionTextOnTap}){
  return Column(
    children: [
      AppBar(
        actions: [
          GestureDetector(
            onTap: actionTextOnTap,
            child: Text(actionText??"", style: const TextStyle(color: Color(0xff858585)),).margin(right: 20)
          )
        ],
      ),
      Container(
        padding: const EdgeInsets.only(left: 24, right: 16, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 26,fontWeight: FontWeight.bold, color: Color(0xff222222))),
          ],
        ),
      ),
    ],
  );
}

/// 合约
Widget contract({required bool selected, void Function(bool)? onTap, double span=4}) => Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    RoundCheckbox(selected: selected, onTap: onTap,),
    RichText(text: TextSpan(
      children: [
        const TextSpan(text: "我已阅读并同意", style: TextStyle(color: Color(0xff989ba1))),
        TextSpan(
            text: "《中国移动认证服务》",
            style: const TextStyle(color: Color(0xff32b7b3)),
            recognizer:TapGestureRecognizer()..onTap=()=>{
              // TODO 协议
            }
        )
      ]
    ))
  ].span(size: span),
);

/// 其他操作
Widget optionAction(){
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text("随便逛逛", style: TextStyle(color: Color(0xff58c6c6), fontSize: 16),),
      Text("|", style: TextStyle(color: Color(0xff58c6c6))),
      Text("找回密码", style: TextStyle(color: Color(0xff58c6c6), fontSize: 16))
    ],
  );
}
