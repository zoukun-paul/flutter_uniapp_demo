

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';

class SimpleSwitch extends StatefulWidget {

  SimpleSwitch({super.key, this.onChange, this.initStatus=false});

  void Function(bool active)? onChange;

  @override
  State<SimpleSwitch> createState() => _SimpleSwitchState();

  Color bgColor=const Color(0xffDDDDDD);

  Color activeBgColor= const Color(0xff32B7B3);

  Color circleColor=Colors.white;

  bool initStatus;

}

class _SimpleSwitchState extends State<SimpleSwitch> {

  late bool isActive;

  Color get bgColor=> isActive?widget.activeBgColor:widget.bgColor;

  AlignmentGeometry get alignment=> isActive?Alignment.centerRight:Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      padding: const EdgeInsets.all(1),
      alignment: alignment,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          color: widget.circleColor,
          borderRadius: const BorderRadius.all(Radius.circular(999))
        ),
      ),
    ).onTap(()=>setState(() {
      isActive=!isActive;
    }));
  }

  @override
  void initState() {
    super.initState();
    isActive = widget.initStatus;
  }
}
