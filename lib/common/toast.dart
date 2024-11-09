


import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(String msg, {textColor=const Color(0xffffffff), backgroundColor=const Color(0xff0a2524),ToastGravity gravity=ToastGravity.BOTTOM}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0
  );

}