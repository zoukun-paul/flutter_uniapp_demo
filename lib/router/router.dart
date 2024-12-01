import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_uniapp_demo/common/const.dart';
import 'package:flutter_uniapp_demo/common/user/login.dart';
import 'package:flutter_uniapp_demo/home.dart';
import 'package:flutter_uniapp_demo/page/explore/explore_page.dart';
import 'package:flutter_uniapp_demo/page/login/phone_bind_page/binding.dart';
import 'package:flutter_uniapp_demo/page/login/phone_bind_page/phone_bind_page.dart';
import 'package:flutter_uniapp_demo/page/login/phone_login/binding.dart';
import 'package:flutter_uniapp_demo/page/login/phone_login/phone_login_page.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/binding.dart';
import 'package:flutter_uniapp_demo/page/login/pwd_login/pwd_login_page.dart';
import 'package:flutter_uniapp_demo/page/more/more_page.dart';
import 'package:flutter_uniapp_demo/page/profile/profile_page.dart';
import 'package:flutter_uniapp_demo/page/subject/subject_page.dart';
import 'package:get/get.dart';

class Routers {
  static const home = "/home";

  /// 课程表
  static const subject = "/subject";
  static const more = "/more";
  static const explore = "/explore";
  static const profile = "/profile";

  static const loginByPhone = "/login/phone";
  static const loginByPwd = "/login/password";

  /// 命名路由
  static List<GetPage>? get pages {
    return [
      GetPage(
        name: loginByPhone,
        page: () => PhoneLoginPage(),
        binding: PhoneLoginBinding(),
        arguments: const {"autoQuickLoginPage":false},
        middlewares: []
      ),
      GetPage(name: loginByPwd, page: () => PwdLoginPage(), binding: PwdLoginBinding()),
      GetPage(name: home, page: () => HomeScreen(checkUserLogin: true,), middlewares: [LoginCheckMiddleware()],binding: SubjectBinding()),
    ];
  }

  static toHomePage({RouteType type = RouteType.replaceAll, checkUserLogin=true}) {
    toPage(HomeScreen(checkUserLogin: checkUserLogin,),type: type, binding: SubjectBinding());
  }

  static toPhoneLoginBindingPage({RouteType type = RouteType.replace}) async {
    toPage(PhoneBindPage(), binding: BindPhoneLoginBinding());
  }

  static toPhoneLoginPage({RouteType type = RouteType.push, bool autoQuickLoginPage=true}) async {
    if(autoQuickLoginPage){
      if(await quickLoginSupport()){
        var token = await getLoginToken();
        if(token!=null){
          toQuickLoginPage();
          return;
        }
      }
    }
    toPage(PhoneLoginPage(), binding: PhoneLoginBinding(), arguments: {"autoQuickLoginPage":autoQuickLoginPage});
  }

  static toPwdLoginPage({RouteType type = RouteType.push}) {
    toPage(PwdLoginPage(), binding: PwdLoginBinding());
  }

  static toPage(dynamic page,
      {Bindings? binding,
      RouteType type = RouteType.push,
      Transition transition = Transition.rightToLeft, dynamic arguments}) {
    if (type == RouteType.replace) {
      Get.off(page, binding: binding, transition: transition, arguments: arguments);
    } else if (type == RouteType.replaceAll) {
      Get.offAll(page, binding: binding, transition: transition, arguments:arguments);
    } else {
      Get.to(page, binding: binding, transition: transition, arguments:arguments);
    }
  }

  static back() {
    Get.back();
  }

  /// main screen pages
  static List<ScreenPage> screenPages({required int currIndex,double tabIconSize=20, EdgeInsets? iconMargin=const EdgeInsets.only(bottom: 10)}) => [
        ScreenPage(
            page: SubjectPage(),
            tab: _tab(
              text: "计划",
              iconMargin: iconMargin,
              icon: currIndex==0?_tabIcon("assets/bar/plain_selected.svg"):_tabIcon("assets/bar/plain.svg"),
            )
        ),
        ScreenPage(
            page: MorePage(),
            tab: _tab(
              text: "更多",
              iconMargin: iconMargin,
              icon: currIndex==1?_tabIcon("assets/bar/more_selected.svg"):_tabIcon("assets/bar/more.svg"),
            )
        ),
        ScreenPage(
            page: ExplorePage(),
            tab: _tab(
              text: "发现",
              iconMargin: iconMargin,
              icon: currIndex==2?_tabIcon("assets/bar/explore_selected.svg"):_tabIcon("assets/bar/explore.svg"),
            )
        ),
        ScreenPage(
            page: ProfilePage(),
            tab: _tab(
              text: "我的",
              iconMargin: iconMargin,
              icon: currIndex==3?_tabIcon("assets/bar/profile_selected.svg",):_tabIcon("assets/bar/profile.svg"),
            )
        )
      ];

  static Tab _tab({required String text,required Widget icon,double height=Const.bottomBarHeight, EdgeInsets? iconMargin}){
    return Tab(
      text: text,
      height: height,
      icon: icon,
      iconMargin: iconMargin,
    );
  }

  static _tabIcon(String iconUri, {double size=Const.bottomTabIconSize}){
    return SizedBox(
        height: size,
        width: size,
        child: SvgPicture.asset(iconUri),
    );
  }

}

enum RouteType {
  push,
  replace,
  replaceAll,
  ;
}

class ScreenPage {
  final Tab tab;
  final Widget page;
  ScreenPage({required this.page, required this.tab});
}

class LoginCheckMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    return super.redirect(route);
  }
}