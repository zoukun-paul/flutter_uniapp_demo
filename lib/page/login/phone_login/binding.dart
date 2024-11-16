
import 'package:flutter_uniapp_demo/page/login/phone_login/phone_login_style.dart';
import 'package:get/get.dart';

import 'phone_login_controller.dart';

class PhoneLoginBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<PhoneLoginController>(() => PhoneLoginController());
    Get.lazyPut<PhoneLoginStyle>(() => PhoneLoginStyle());
  }

}