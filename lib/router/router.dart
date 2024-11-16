

import 'package:flutter_uniapp_demo/page/login/phone_login/binding.dart';
import 'package:flutter_uniapp_demo/page/login/phone_login/phone_login_page.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/binding.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_page.dart';
import 'package:get/get.dart';

class Routers {
  static const loginByPhone = "/login/phone";
  static const loginByPwd = "/login/password";

  /// 命名路由
  static List<GetPage>?  get pages {
    return [
      GetPage(name: loginByPhone, page: ()=>PhoneLoginPage(), binding: PhoneLoginBinding()),
      GetPage(name: loginByPwd, page: ()=>PwdLoginPage(), binding: PwdLoginBinding())
    ];
  }

  static toPhoneLoginPage({RouteType type=RouteType.push}){
    toPage(PhoneLoginPage(), binding: PhoneLoginBinding());
  }

  static toPwdLoginPage({RouteType type=RouteType.push}){
    toPage(PwdLoginPage(), binding: PwdLoginBinding());
  }

  static toPage(dynamic page, {Bindings? binding, RouteType type=RouteType.push, Transition transition=Transition.rightToLeft}){
    if(type==RouteType.replace){
      Get.off(page, binding: binding, transition: transition);
    } else if(type==RouteType.replaceAll){
      Get.offAll(page, binding: binding, transition: transition);
    } else{
      Get.to(page, binding: binding, transition: transition);
    }
  }

}


enum RouteType {
  push,
  replace,
  replaceAll,
  ;
}