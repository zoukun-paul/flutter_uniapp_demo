import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_uniapp_demo/common/extension/list.dart';
import 'package:flutter_uniapp_demo/page/subject/model/target_schedule.dart';
import 'package:flutter_uniapp_demo/page/subject/service/http.dart';
import 'package:flutter_uniapp_demo/page/subject/widget/target_box.dart';
import 'package:flutter_uniapp_demo/router/router.dart';
import 'package:get/get.dart';

import 'goal_create_page.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> with TickerProviderStateMixin {

  late TabController tabController = TabController(vsync: this, length: 2);

  final Rx<List<TargetSchedule>> goals = Rx([]);

  @override
  void initState() {
    super.initState();
    goals.value = SubjectHttpApi.instance.queryTargetSchedule();
  }

  Widget createGoalBtn(){
    return GestureDetector(
      onTap: ()=>Routers.toPage(GoalCreatePage()),
      child: DottedBorder(
        color: const Color(0xff32B7B3),
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: Container(
          height: 44,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/subject/add_circle.svg"),
              const SizedBox(width: 6,),
              const Text("创建计划", style: TextStyle(color: Color(0xff32B7B3)),)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text("目标计划", style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            TabBar(
              labelStyle: const TextStyle(fontSize: 15),
              labelColor: const Color(0xff32B7B3),
              controller: tabController,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xff32B7B3), // 下划线颜色
                  width: 4.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                insets: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              tabs: const [
                Tab(text: "执行中",),
                Tab(text: "已完成",),
              ],),
            Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 16,),
                          createGoalBtn(),
                          const SizedBox(height: 16,),
                          ...goals
                              .value
                              .map((e)=>targetBox(e)).toList()
                              .span(size: 16, vertical: true),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 16,),
                          ...goals
                              .value
                              .map((e)=>targetBox(e)).toList()
                              .span(size: 16, vertical: true),
                        ],
                      ),
                    ]
                )
            )
          ],
        ),
      ),
    );
  }

  Widget targetBox(TargetSchedule target){
    return Container(
      decoration: BoxDecoration(
        color: target.planType.color,
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: TargetBox(target: target),
    );
  }

}

