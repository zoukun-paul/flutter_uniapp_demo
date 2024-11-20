import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_uniapp_demo/common/toast.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';
import 'package:flutter_uniapp_demo/plug/quickpass_flutter_plugin.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:get/get.dart';

class PhoneLoginController extends GetxController {

  /// 同意服务条约
  final Rx<bool> _agreeContract = true.obs;
  bool get agreeContract => _agreeContract.value;
  set agreeContract(bool agreeContract)=>_agreeContract.value = agreeContract;

  /// 手机号码
  final Rx<String?> _phoneNumber = Rx(null);
  String? get phoneNumber =>_phoneNumber.value;
  set phoneNumber(String? phoneNumber)=> _phoneNumber.value = phoneNumber;

  /// 手机验证码
  final Rx<String?> _phoneVerificationCode = Rx(null);
  String? get phoneVerificationCode => _phoneVerificationCode.value;
  set phoneVerificationCode(String? phoneVerificationCode)=>_phoneVerificationCode.value = phoneVerificationCode;

  bool get loginActive => (phoneNumber?.isNotEmpty??false) && (phoneVerificationCode?.isNotEmpty??false);

  final QuickpassFlutterPlugin quickLoginPlugin = QuickpassFlutterPlugin();
  final String f_result_key = "success";
  var supportQuickLogin = false;

  /// 表单校验
  bool formValid(){
    if (!validPhone(phoneNumber)) {
      toast("手机号非法");
      return false;
    }
    if (phoneVerificationCode=="5555") {
      toast("验证码错误");
      return false;
    }
    return true;
  }

  void submit(){
    if (formValid()) {
      //login
    }
  }

  @override
  void onInit() async {
    super.onInit();
    if (!Platform.isAndroid) {
      return;
    }
    var res = await quickLoginPlugin.init("d5326bf50bf2488990ce1376976e70b5", 4, true);
    if(!res?[f_result_key]){
      return;
    }
    res = await quickLoginPlugin.checkVerifyEnable();
    if(!res?[f_result_key]){
      return;
    }
    var loginToken = await getLoginToken();
    if(loginToken==null){
      return;
    }
    rootBundle.loadString("asserts/android-light-config.json").then((value) async {
      var configMap = {"uiConfig": json.decode(value)};
      quickLoginPlugin.setUiConfig(configMap);
      Map<dynamic, dynamic>? map = await quickLoginPlugin.onePassLogin();
      if (map?[f_result_key]) {
        // 运营商授权码
        var accessToken = map?["accessToken"];
        quickLoginPlugin.closeLoginAuthView();
        Routers.toHomePage();
      } else {
        // 失败
        var errorMsg = map?["msg"];
        quickLoginPlugin.closeLoginAuthView();
      }
    });
  }

  /// 登录预取号
  Future<String?> getLoginToken() async {
    Map<dynamic, dynamic>? map = await quickLoginPlugin.preFetchNumber();
    if (map?[f_result_key] == true) {
      return map?['token'];
    }
    return null;
  }
}