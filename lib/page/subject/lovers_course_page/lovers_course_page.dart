import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/key_value_pair.dart';
import 'package:flutter_uniapp_demo/common/toast.dart';
import 'package:get/get.dart';

class LoversCoursePage extends StatefulWidget {

  LoversCoursePage({super.key});

  @override
  State<LoversCoursePage> createState() => _LoversCoursePageState();
}

class _LoversCoursePageState extends State<LoversCoursePage> {
  TextEditingController invitationCodeIptController = TextEditingController();

  /// 邀请码
  Rx<KeyValuePair<String, DateTime>>? _invitationCode;

  String get invitationCode {
    _invitationCode ??= KeyValuePair(key: randomString(8), value: DateTime.now()).obs;
    if (DateTime
        .now()
        .difference(_invitationCode!.value.value)
        .inMinutes > 60) {
      _invitationCode = KeyValuePair(key: randomString(8), value: DateTime.now()).obs;
    }
    return _invitationCode!.value.key;
  }

  Rx<String> barHintText = "绑定成功后可查看对方本学期课程表".obs;
  Rx<Color> barHintTextColor = const Color(0xff32B7B3).obs;
  Rx<Color> barBgColor = const Color(0xffebf8f7).obs;

  /// 提示栏
  Widget bar() {
    return Obx(() {
      return Container(
        height: 33,
        color: barBgColor.value,
        alignment: Alignment.center,
        child: Text(barHintText.value,
            style: TextStyle(color: barHintTextColor.value, fontSize: 12)),
      );
    });
  }

  /// 确认按钮
  Widget actionBtn() {
    return Obx(() {
      return Container(
          height: 38,
          width: 82,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: invitationCodeVal.isEmpty ? const Color(0xffdddddd) : const Color(0xff32b7b3),
          ),
          child: const Text("确定", style: TextStyle(color: Color(0xffFFFFFF),),)
      ).onTap(condition: invitationCodeVal.isNotEmpty,() {
        /// check
        barHintText.value = "邀请码错误，请检查后重试！";
        barBgColor.value = const Color(0xffffeded);
        barHintTextColor.value = const Color(0xffFF4E4E);
      });
    });
  }

  /// 用户输入的 邀请码
  Rx<String> invitationCodeVal = "".obs;

  /// 邀请码输入框
  Widget invitationCodeIpt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
            child: TextField(
              onChanged: (e) => invitationCodeVal.value = e,
              style: const TextStyle(fontSize: 17, color: Color(0xff222222)),
              decoration: const InputDecoration(
                  hintText: "填写TA的邀请码",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color(0xff999999,), fontSize: 17)
              ),
            ),
          ),
        ),
        actionBtn()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "情侣课表", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bar(),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("我的邀请码", style: TextStyle(color: Color(0xff777777), fontSize: 15),),
                const SizedBox(width: 4,),
                SvgPicture.asset("assets/subject/copy.svg").onTap(() {
                  /// 将邀请码复制到剪切板
                  Clipboard.setData(ClipboardData(text: invitationCode)).then((e) =>
                      toast("复制成功"));
                }),
              ],
            ),
            const SizedBox(height: 8,),
            Text(invitationCode, style: const TextStyle(
                color: Color(0xff32B7B3), fontSize: 28, fontWeight: FontWeight.w500),),
            Container(
              height: 54,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffDDDDDD)),
                  borderRadius: const BorderRadius.all(Radius.circular(54))
              ),
              child: invitationCodeIpt(),
            )
          ],
        ),
      ),
    );
  }

  /// 随机字符串
  String randomString(int length) {
    const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length,
            (_) => charset.codeUnitAt(random.nextInt(charset.length))
    ));
  }
}
