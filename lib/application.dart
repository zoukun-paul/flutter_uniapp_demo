

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uniapp_demo/common/store/user_store.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'common/theme.dart';
import 'plug/channel/uni_app_event_channel.dart';
import 'router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      // android 平台
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      ));
    }
    UniAppEventChannel().init();
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('zh', 'CH'),],
      initialRoute: UserStore.hasLogin?Routers.home:Routers.loginByPhone,
      getPages: Routers.pages,
      builder: FToastBuilder(),
      title: '章鱼同学',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
    );
  }


}