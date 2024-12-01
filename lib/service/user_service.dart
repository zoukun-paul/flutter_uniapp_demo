

class UserService {

  static UserService? _instance;
  factory UserService() => _instance ??= UserService._();
  UserService._();



}