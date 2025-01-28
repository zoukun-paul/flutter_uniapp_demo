
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/page/subject/model/target_schedule.dart';

class TargetBox extends StatelessWidget {

  const  TargetBox({super.key, required this.target, this.colors});

  final TargetSchedule target;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors??target.planType.bgColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              targetPlanTimeTag(target.planType),
              Row(
                children: [
                  const Text("删除", style: TextStyle(color: Color(0xffFF4E4E)),),
                  const SizedBox(width: 10,),
                  Container(
                    color: const Color(0xffDDDDDD),
                    width: 1,
                    height: 16,
                  ),
                  const SizedBox(width: 10,),
                  const Text("完成"),
                ],
              )
            ],
          ),
          const SizedBox(height: 8,),
          Text(target.title, style: TextStyle(color: target.planType.color, fontSize: 15,fontWeight: FontWeight.w500),),
          const SizedBox(height: 8,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: target.planType.color, width: 0.4)
            ),
            child: Text(
              "还有${DateTime.now().difference(target.deadline).inDays.abs()}天",
              style: TextStyle(color:target.planType.color ),
            ),
          ),
          const SizedBox(height: 8,),
          Text(target.note??"无备注", style: const TextStyle(color: Color(0xff999999), fontSize: 12),)
        ],
      ),
    );
  }

  Widget targetPlanTimeTag(TargetSchedulePlanType type){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: const BorderRadius.all(Radius.circular(4))
      ),
      child: Text(type.desc, style: const TextStyle(color: Colors.white, fontSize: 12),),
    );
  }
}
