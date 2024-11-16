

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget{

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  /// 当前页下标
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index)=>_currentIndex.value=index;

  late TabController tabController;

  /// 主页面
  List<ScreenPage> get screenPages => Routers.screenPages(currIndex: currentIndex);
  List<Widget> get screens => screenPages.map((e)=>e.page).toList();
  List<Tab> get tabs => screenPages.map((e)=>e.tab).toList();

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: screens.length, vsync: this);
    return Scaffold(
        body: Obx(()=>screens[currentIndex]),
        bottomNavigationBar: DecoratedBox(
          decoration:  BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24),],
          ),
          child: SafeArea(child: Obx(()=>tabBar),),
        )
    );
  }

  Widget get tabBar => TabBar(
    enableFeedback: true,
    indicatorColor: Colors.transparent,
    controller: tabController,
    labelStyle: const TextStyle(height: 0.5, fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff32b7b3)),
    unselectedLabelStyle: const TextStyle(height: 0.5,fontSize: 10, fontWeight: FontWeight.bold,),
    tabs: tabs,
    onTap: (index)=>currentIndex=index,
  );

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

}
