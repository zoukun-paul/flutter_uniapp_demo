import 'dart:async';

import 'package:flutter/services.dart';

class QuickpassFlutterPlugin {
  final String flutter_log = "| JVER | Flutter | " /*!*/;

  /// 错误码
  final String j_flutter_code_key = "code" /*!*/;

  /// 回调的提示信息
  final String j_flutter_msg_key = "message" /*!*/;

  /// 重复请求
  final int j_flutter_error_code_repeat = -1 /*!*/;

  final List<String> requestQueue = [] /*!*/;

  static const MethodChannel _channel =
      const MethodChannel('quicklogin_flutter_plugin');

  Map<dynamic, dynamic>? isRepeatRequest({required String method}) {
    bool isContain = requestQueue.any((element) => (element == method)) /*!*/;
    if (isContain) {
      Map map = {
        j_flutter_code_key: j_flutter_error_code_repeat,
        j_flutter_msg_key: method + " is requesting, please try again later."
      } /*!*/;
      print(flutter_log + map.toString());
      return map;
    } else {
      requestQueue.add(method);
      return null;
    }
  }

  /*
   * 获取 SDK 初始化是否成功标识
   *
   * return Map
   *          key = "success"
   *          vlue = bool,是否成功
   * */
  Future<Map<dynamic, dynamic>?> /*!*/ init(String businessId /*!*/,
      [int? timeout, bool? isDebug]) async {
    print("$flutter_log" + "init");
    return await _channel.invokeMethod("init",
        {"businessId": businessId, "timeout": timeout, "isDebug": isDebug});
  }

  /*
   * SDK判断网络环境是否支持
   *
   * return Map
   *          key = "success"
   *          vlue = bool,是否支持
   * */
  Future<Map<dynamic, dynamic>?> /*!*/ checkVerifyEnable() async {
    print("$flutter_log" + "checkVerifyEnable");
    return await _channel.invokeMethod("checkVerifyEnable");
  }

  /*
   * SDK 一键登录预取号
   * */
  Future<Map<dynamic, dynamic>?> /*!*/ preFetchNumber() async {
    // var para = new Map();
    // if (timeOut != null) {
    //   if (timeOut >= 3000 && timeOut <= 10000) {
    //     para["timeOut"] = timeOut;
    //   }
    // }
    print("$flutter_log" + "preFetchNumber" + "");

    String method = "preFetchNumber";
    var repeatError = isRepeatRequest(method: method);
    if (repeatError == null) {
      var result = await _channel.invokeMethod(method);
      requestQueue.remove(method);
      return result;
    } else {
      return repeatError;
    }
  }

  /*
  * SDK请求授权一键登录（异步接口）
  * animated,授权页弹出是否有动画
  * */
  Future<Map<dynamic, dynamic>?> /*!*/ onePassLogin(
      {bool animated = true}) async {
    print("$flutter_log" + "onePassLogin");

    String method = "onePassLogin";
    var result = await _channel.invokeMethod(method, {"animated": animated});
    requestQueue.remove(method);
    return result;
  }

  /*
  * 关闭授权页面
  * */
  void closeLoginAuthView() {
    print(flutter_log + "closeLoginAuthView");
    _channel.invokeMethod("closeLoginAuthView");
  }

  /*
  * 自动登录
  *
  */
  void authLoginButtonClick() {
    print(flutter_log + "authLoginButtonClick");
    _channel.invokeMethod("authLoginButtonClick");
  }

  /*
  * 复选框勾选状态
  *
  */
  void checkedSelected(String selected) async {
    print("$flutter_log" + "checkedSelected");

    String method = "checkedSelected";
    _channel.invokeMethod(method, selected);
  }

  /*
  * 设置授权页面
  *
  * @para portraitConfig    UI 配置， 相关UI配置请移步到 asserts/ios-light-config.json中修改
  * */
  void setUiConfig(var configMap) {
    _channel.invokeMethod("setUiConfig", configMap);
  }

  /*
   * 本机校验验证手机号码
   *
   * return Map
   *          key = "success"
   *          vlue = bool,是否成功
   * */
  Future<Map<dynamic, dynamic>?> /*!*/ verifyPhoneNumber(
      String businessId /*!*/, String phoneNumber) async {
    print("$flutter_log" + "verifyPhoneNumber");
    return await _channel.invokeMethod("verifyPhoneNumber",
        {"businessId": businessId, "phoneNumber": phoneNumber});
  }
}
