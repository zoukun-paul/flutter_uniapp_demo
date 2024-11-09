import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Style<T> {
  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag)!;
}

abstract class GetStyleView<R extends Style<C>, C> extends GetView<C>{

  final String? styleTag = null;

  GetStyleView({super.key});

  R get style => GetInstance().find<R>(tag: styleTag);

  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    this.ctx = context;
   return proxyBuild(context);
  }

  Widget proxyBuild(BuildContext context);

}