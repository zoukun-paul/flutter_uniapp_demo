

import 'package:flutter/cupertino.dart';

extension WidgetExtension on Widget{
    Widget margin({double left=0, double right=0, double top=0, double bottom=0}){
      return Container(
        margin: EdgeInsets.only(left: left,top: top,right: right,bottom: bottom),
        child: this,
      );
    }

    Widget center(){
      return Center(
        child: this,
      );
    }
}