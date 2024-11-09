

import 'package:flutter/material.dart';

class AppTheme {

  static const white  = Color(0xfffafafb);
  static const primaryColor  = Color(0xff32b7b3);
  static const secondaryColor  = Color(0xfffdbf15);
  static const waringColor  = Color(0xfff77800);
  static const errorColor  = Color(0xffff4e4e);

  static const fontColor = MaterialColor(
    0xffc9c9c9,
    <int, Color>{
      50: Color(0xffc9c9c9),
      100: Color(0xff999999),
      200: Color(0xff777777),
      300: Color(0xff555555),
      400: Color(0xff222222),
    },
  );

  static const grayColor = MaterialColor(
    0xffdddddd,
    <int, Color>{
      50: Color(0xfff7f7f7),
      100: Color(0xfff1f1f1),
      200: Color(0xffe5e5e5),
      300: Color(0xffdddddd),
    },
  );

  static ThemeData themeData() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        buttonTheme: null,
        colorScheme: ColorScheme.fromSwatch(
          errorColor: errorColor
        ),
        // 文字
        // textTheme: const TextTheme(
        //   displayLarge: TextStyle(color: Colors.black87),
        //   displayMedium: TextStyle(color: Colors.black87),
        //   displaySmall: TextStyle(color: Colors.black87),
        //   bodyLarge: TextStyle(color: Colors.black87),
        //   bodyMedium: TextStyle(color: Colors.black87),
        //   bodySmall: TextStyle(color: Colors.black87),
        // )
      // 点击时水波颜色
      splashColor: Colors.transparent,
      // 点击时背景高亮颜色
      highlightColor: Colors.transparent,
    );
  }

}

/// 是否深色模式
bool isDarkMode(BuildContext context) {
  return View.of(context).platformDispatcher.platformBrightness == Brightness.dark;
}

