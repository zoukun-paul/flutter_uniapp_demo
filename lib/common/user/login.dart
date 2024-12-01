
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_uniapp_demo/plug/quickpass_flutter_plugin.dart';
import 'package:flutter_uniapp_demo/router/router.dart';

/// 快速登录业务ID
String _businessId = "d5326bf50bf2488990ce1376976e70b5";
final QuickpassFlutterPlugin _quickLoginPlugin = QuickpassFlutterPlugin();
const String _resultKey = "success";
var eventChannel = const EventChannel("yd_quicklogin_flutter_event_channel");
/// 判断当前环境是否支持 快速登录
Future<bool> quickLoginSupport() async{
  if (!Platform.isAndroid) {
    // TODO IOS 待集成
    return false;
  }
  eventChannel.receiveBroadcastStream().listen(_onData);
  var res =  await _quickLoginPlugin.init(_businessId, 4, true);
  if(!res?[_resultKey]){
    return false;
  }
  var uiConfig = await rootBundle.loadString("asserts/android-light-config.json");
  var configMap = {"uiConfig": json.decode(uiConfig)};
  _quickLoginPlugin.setUiConfig(configMap);
  return true;
}

/// 登录预取号
Future<String?> getLoginToken() async {
  Map<dynamic, dynamic>? map = await _quickLoginPlugin.preFetchNumber();
  if (map?[_resultKey] == true) {
    return map?['token'];
  }
  return null;
}

Future<Map<dynamic, dynamic>?> toQuickLoginPage() async {
  var map = await _quickLoginPlugin.onePassLogin();
  if (map?[_resultKey]) {
    var accessToken = map?["accessToken"];
    _quickLoginPlugin.closeLoginAuthView();
    Routers.toHomePage(checkUserLogin: false);
  } else {
    var errorMsg = map?["msg"];
    // TODO 登录失败
    _quickLoginPlugin.closeLoginAuthView();
  }
}


void _onData(response) {
  if (response is Map) {
    var action = response["action"];
    if("otherLogin" == action){
      Routers.toPhoneLoginPage(autoQuickLoginPage: false);
      _quickLoginPlugin.closeLoginAuthView();
    }
  }
}