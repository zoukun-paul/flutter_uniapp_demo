import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/theme.dart';
import 'package:remixicon/remixicon.dart';


class RoundCheckbox extends StatelessWidget {
  bool selected;
  final double size;
  void Function(bool selected) ? onTap;
  RoundCheckbox({super.key, required this.selected, this.size=20, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap?.call(selected),
      child: selected?Icon(
        Remix.checkbox_circle_fill,
        size: size,
        color: const Color(0xff58c6c6),
      ): Icon(
        Remix.checkbox_blank_circle_line,
        size: size,
        color: AppTheme.fontColor[50],
      )
    );
  }
}
