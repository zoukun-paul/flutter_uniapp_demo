
import 'package:get/get.dart';
import 'phone_bind_controller.dart';
import 'phone_bind_style.dart';

class BindPhoneLoginBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<PhoneBindController>(() => PhoneBindController());
    Get.lazyPut<PhoneBindStyle>(() => PhoneBindStyle());
  }

}