

import 'package:get_storage/get_storage.dart';

/// 用户数据持久化
class UserStore {
  static final GetStorage _userStore = GetStorage('UserStore');

  /// 是否支持快速登录
  static bool get quickLoginSupport => _userStore.read("quickLoginSupport") ?? false;
  static set quickLoginSupport(bool value) => _userStore.writeInMemory("quickLoginSupport", value);

  ///  token
  static String? get token => _userStore.read("token");
  static set token(String? value) => _userStore.write("token", value);

  /// 用户状态判断
  static bool get hasLogin => token!=null;

}