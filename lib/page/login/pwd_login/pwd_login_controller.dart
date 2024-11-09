

import 'package:get/get.dart';

class PwdLoginController extends GetxController {

  /// 同意服务条约
  final _agreeContract = true.obs;
  bool get agreeContract => _agreeContract.value;
  set agreeContract(bool agreeContract)=>_agreeContract.value = agreeContract;


  /// 手机号码
  final Rx<String?> _phoneNumber = Rx(null);
  String? get phoneNumber =>_phoneNumber.value;
  set phoneNumber(String? phoneNumber)=> _phoneNumber.value = phoneNumber;

  /// 密码
  final Rx<String?> _password = Rx(null);
  String? get password =>_password.value;
  set password(String? pwd)=> _password.value = pwd;

  /// 密码显示控制
  final Rx<bool> _obscureText = false.obs;
  bool get obscureText => _obscureText.value;
  set obscureText(bool val) => _obscureText.value=val;

  bool get loginActive => (phoneNumber?.isNotEmpty??false) && (password?.isNotEmpty??false);

  /// 登录（表单提交）
  void submit(){

  }

}