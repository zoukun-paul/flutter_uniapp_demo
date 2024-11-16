

import 'package:get/get.dart';

class PhoneBindController extends GetxController{

  /// 手机号码
  final Rx<String?> _phoneNumber = Rx(null);
  String? get phoneNumber =>_phoneNumber.value;
  set phoneNumber(String? phoneNumber)=> _phoneNumber.value = phoneNumber;

  /// 手机验证码
  final Rx<String?> _phoneVerificationCode = Rx(null);
  String? get phoneVerificationCode => _phoneVerificationCode.value;
  set phoneVerificationCode(String? phoneVerificationCode)=>_phoneVerificationCode.value = phoneVerificationCode;

  bool get loginActive => (phoneNumber?.isNotEmpty??false) && (phoneVerificationCode?.isNotEmpty??false);

  void submit(){

  }

}