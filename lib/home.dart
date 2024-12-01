

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/const.dart';
import 'package:flutter_uniapp_demo/common/store/user_store.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:get/get.dart';

import 'page/subject/subject_controller.dart';
import 'page/subject/subject_style.dart';

class HomeScreen extends StatefulWidget{
  final bool checkUserLogin;
  HomeScreen({super.key, required this.checkUserLogin});

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
          child: SafeArea(child: Obx(()=>bottomTabBar),),
        )
    );
  }

  Widget get bottomTabBar => TabBar(
    enableFeedback: true,
    indicatorColor: Colors.transparent,
    controller: tabController,
    labelStyle: const TextStyle(height: 0.5, fontSize: Const.bottomTabFontSize, fontWeight: FontWeight.bold, color: Color(0xff32b7b3)),
    unselectedLabelStyle: const TextStyle(height: 0.5,fontSize: Const.bottomTabFontSize, fontWeight: FontWeight.bold,),
    tabs: tabs,
    onTap: (index)=>currentIndex=index,
  );

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState()  {
    super.initState();
    if(widget.checkUserLogin && UserStore.token==null){
      Routers.toPhoneLoginPage();
    }
  }
}

/// init bindings
class SubjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectController>(() => SubjectController());
    Get.lazyPut<SubjectStyle>(() => SubjectStyle());
  }
}
