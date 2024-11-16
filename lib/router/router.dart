import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_uniapp_demo/home.dart';
import 'package:flutter_uniapp_demo/page/explore/explore_page.dart';
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
      GetPage(name: loginByPhone, page: () => PhoneLoginPage(), binding: PhoneLoginBinding()),
      GetPage(name: loginByPwd, page: () => PwdLoginPage(), binding: PwdLoginBinding()),
      GetPage(name: home, page: () => HomeScreen()),
    ];
  }

  static toHomePage({RouteType type = RouteType.replaceAll}) {
    toPage(HomeScreen());
  }

  static toPhoneLoginPage({RouteType type = RouteType.push}) {
    toPage(PhoneLoginPage(), binding: PhoneLoginBinding());
  }

  static toPwdLoginPage({RouteType type = RouteType.push}) {
    toPage(PwdLoginPage(), binding: PwdLoginBinding());
  }

  static toPage(dynamic page,
      {Bindings? binding,
      RouteType type = RouteType.push,
      Transition transition = Transition.rightToLeft}) {
    if (type == RouteType.replace) {
      Get.off(page, binding: binding, transition: transition);
    } else if (type == RouteType.replaceAll) {
      Get.offAll(page, binding: binding, transition: transition);
    } else {
      Get.to(page, binding: binding, transition: transition);
    }
  }

  /// main screen pages
  static List<ScreenPage> screenPages({required int currIndex,double tabIconSize=20, EdgeInsets? iconMargin=const EdgeInsets.only(bottom: 10)}) => [
        ScreenPage(
            page: SubjectPage(),
            tab: Tab(
              key: const Key('tab_home'),
              text: "计划",
              iconMargin: iconMargin,
              icon: currIndex==0?SvgPicture.asset("assets/bar/plain_selected.svg"):SvgPicture.asset("assets/bar/plain.svg"),
            )
        ),
        ScreenPage(
            page: MorePage(),
            tab: Tab(
              key: const Key('tab_home'),
              text: "更多",
              iconMargin: iconMargin,
              icon: currIndex==1?SvgPicture.asset("assets/bar/more_selected.svg"):SvgPicture.asset("assets/bar/more.svg"),
            )
        ),
        ScreenPage(
            page: ExplorePage(),
            tab: Tab(
              key: const Key('tab_home'),
              text: "发现",
              iconMargin: iconMargin,
              icon: currIndex==2?SvgPicture.asset("assets/bar/explore_selected.svg"):SvgPicture.asset("assets/bar/explore.svg"),
            )
        ),
        ScreenPage(
            page: ProfilePage(),
            tab: Tab(
              key: const Key('tab_home'),
              text: "我的",
              iconMargin: iconMargin,
              icon: currIndex==3?SvgPicture.asset("assets/bar/profile_selected.svg"):SvgPicture.asset("assets/bar/profile.svg"),
            )
        )
      ];
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
