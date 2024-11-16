
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'common/theme.dart';
import 'page/login/phone_login/phone_login_page.dart';
import 'router/router.dart';

void main() {
  runApp(const MyApp());
}

const MethodChannel nativeChannelTx = MethodChannel('native_msg');
const MethodChannel uniAppChannelTx = MethodChannel('uniapp_msg');



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routers.loginByPhone,
      getPages: Routers.pages,
      builder: FToastBuilder(),
      title: 'Flutter UniAPP Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
    );
  }
}

