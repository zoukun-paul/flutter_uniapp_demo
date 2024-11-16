import 'package:flutter_uniapp_demo/common/toast.dart';
import 'package:flutter_uniapp_demo/page/login/common.dart';
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

}