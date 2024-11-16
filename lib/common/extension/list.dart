

import 'package:flutter/material.dart';


extension ListExtend on List<Widget> {

  List<Widget> span({required double size, bool vertical=false}){
    List<Widget> result = [];
    List<Widget> list = toList();
    for (var i=0;i<length;i++){
      result.add(list[i]);
      if(i+1<length){
        if(vertical){
          result.add(SizedBox(height: size,));
        }else{
          result.add(SizedBox(width: size,));
        }
      }
    }
    return result;
  }

  List<Widget> spanWidget({required Widget child}){
    List<Widget> result = [];
    List<Widget> list = toList();
    for (var i=0;i<length;i++){
      result.add(list[i]);
      if(i+1<length){
        result.add(child);
      }
    }
    return result;
  }

  Widget row({MainAxisAlignment mainAxisAlignment=MainAxisAlignment.start}){
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: this,
    );
  }

}