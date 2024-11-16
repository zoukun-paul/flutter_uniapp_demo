import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/direction.dart';

Widget divider({
  bool horizontal=false,
  BuildContext? context,
  required Color bgColor,
  double size=3,
  double margin=0,
  double padding=0}) {
  final direction = horizontal?Direction.horizontal:Direction.vertical;
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: direction==Direction.vertical?margin/2:0,
        horizontal: direction==Direction.horizontal?margin/2:0
    ),
    padding: EdgeInsets.symmetric(
        vertical: direction==Direction.vertical?padding/2:0,
        horizontal: direction==Direction.horizontal?padding/2:0
    ),
    height: direction==Direction.horizontal?size:double.infinity,
    width: direction==Direction.vertical?size:double.infinity,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}
