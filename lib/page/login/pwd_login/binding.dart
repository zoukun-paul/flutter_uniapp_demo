
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_controller.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_style.dart';
import 'package:get/get.dart';


class PwdLoginBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<PwdLoginController>(() => PwdLoginController());
    Get.lazyPut<PwdLoginStyle>(() => PwdLoginStyle());
  }

}