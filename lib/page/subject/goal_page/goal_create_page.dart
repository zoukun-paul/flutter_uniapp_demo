

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/extension/widget.dart';
import 'package:flutter_uniapp_demo/common/widget/switch.dart';
import 'package:flutter_uniapp_demo/page/subject/model/target_schedule.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';
import 'package:scroll_datetime_picker/src/entities/enums.dart';
class GoalCreatePage extends StatelessWidget {

  GoalCreatePage({super.key});

  final _planType = TargetSchedulePlanType.custom.obs;
  TargetSchedulePlanType get planType => _planType.value;
  set planType(TargetSchedulePlanType val) => _planType.value=val;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: const Text("创建计划", style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("计划内容", style: TextStyle(fontSize: 15,color: Color(0xff222222)),),
                    const SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xffE5E5E5))
                      ),
                      child: TextField(
                        minLines: 2,
                        maxLines: 2,
                        maxLength: 24,
                        buildCounter: (ctx, {required int currentLength, int? maxLength, required bool isFocused}){
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 10),
                            child: Text("已输入$currentLength/$maxLength", style: const TextStyle(color: Color(0xffC9C9C9), fontSize: 12),),
                          );
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入计划内容，设定了就要坚持执行下去哦！",
                          hintStyle: TextStyle(color: Color(0xff999999),)
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text("备注", style: TextStyle(fontSize: 15,color: Color(0xff222222)),),
                    const SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Color(0xffE5E5E5))
                      ),
                      child: TextField(
                        minLines: 2,
                        maxLines: 2,
                        maxLength: 300,
                        buildCounter: (ctx, {required int currentLength, int? maxLength, required bool isFocused}){
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 10),
                            child: Text("已输入$currentLength/$maxLength", style: const TextStyle(color: Color(0xffC9C9C9), fontSize: 12),),
                          );
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "填写备注，也记录一下其他事项吧（选填）",
                            hintStyle: TextStyle(color: Color(0xff999999),)
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text("计划模式：", style: TextStyle(fontSize: 15,color: Color(0xff222222)),),
                    const SizedBox(height: 8,),
                    Obx(
                      ()=>Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlanTag(tagName: "自定义", isActive: planType==TargetSchedulePlanType.custom,onTap: (status)=>planType=TargetSchedulePlanType.custom,),
                          PlanTag(tagName: "每日", isActive: planType==TargetSchedulePlanType.everyDay,onTap: (status)=>planType=TargetSchedulePlanType.everyDay,),
                          PlanTag(tagName: "每周", isActive: planType==TargetSchedulePlanType.everyWeek,onTap: (status)=>planType=TargetSchedulePlanType.everyWeek,),
                          PlanTag(tagName: "每月", isActive: planType==TargetSchedulePlanType.everyMonth,onTap: (status)=>planType=TargetSchedulePlanType.everyMonth,),
                          PlanTag(tagName: "每年", isActive: planType==TargetSchedulePlanType.everyYear,onTap: (status)=>planType=TargetSchedulePlanType.everyYear,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8,),
                    dimePicker(),
                    const SizedBox(height: 8,),
                    externalDateOption(context)                ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget externalDateOption(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffE5E5E5))
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("全天"),
              SimpleSwitch()
            ],
          ),
          const SizedBox(height: 16,),
          const Divider(height: 2, color: Color(0xffE5E5E5),),
          const SizedBox(height: 16,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("具体时间"),
              Icon(Icons.keyboard_arrow_right_sharp, color: Color(0xffC9C9C9),)
            ],
          ).onTap((){
            // 选择具体时间
            showTimeSelectorSheet(context);
          })
        ],
      ),
    );
  }

  Widget dimePicker(){
    return ScrollDateTimePicker(
      itemExtent: 42,
      visibleItem: 3,
      infiniteScroll: false,
      markOutOfRangeDateInvalid: false,
      dateOption: DateTimePickerOption(
        dateFormat: DateFormat('yyyy年MMdd'),
        minDate: DateTime(DateTime.now().year, 2),
        maxDate: DateTime(DateTime.now().year, 12),
        initialDate: DateTime.now(),
      ),
      onChange: (datetime) => {},
    );
  }

  void showTimeSelectorSheet(BuildContext context){
    showMaterialModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 322,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("取消",style: TextStyle(color: Color(0xff777777)),),
                    Text("选择时间",style: TextStyle(color: Color(0xff222222), fontSize: 17, fontWeight: FontWeight.w500),),
                    Text("完成",style: TextStyle(color: Color(0xff32B7B3)),),
                  ],
                ),
                const SizedBox(height: 24,),
                ScrollDateTimePicker(
                  itemExtent: 42,
                  visibleItem: 5,
                  infiniteScroll: false,
                  markOutOfRangeDateInvalid: false,
                  dateOption: DateTimePickerOption(
                    dateFormat: DateFormat('HHmm'),
                    minDate: DateTime(DateTime.now().year, 2),
                    maxDate: DateTime(DateTime.now().year, 12),
                    initialDate: DateTime.now(),
                  ),

                  onChange: (datetime) => {},
                  itemBuilder: (context, String pattern, String text, bool isActive, bool isDisabled)=>Container(
                    alignment: Alignment.center,
                    child: _timeSelector(DateTimeType.fromPattern(pattern), text),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  Widget _timeSelector(DateTimeType dt, String text, {TextStyle? style}){
    if(dt==DateTimeType.hour24 || dt==DateTimeType.hour12) {
      return Text("$text点", style: style,);
    }
    if(dt==DateTimeType.minute){
      return Text("$text分");
    }
    return Text(text, style:style);
  }

}


class PlanTag extends StatelessWidget {

  const PlanTag({super.key, required this.tagName, required this.isActive, this.onTap});

  final String tagName;
  final bool isActive;
  final void Function(bool isActive)? onTap;
  Color color(bool isActive) {
    return  isActive?Colors.white:const Color(0xff32b7b3);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color(!isActive),
        border: Border.all(color: color(false), ),
        borderRadius: const BorderRadius.all(Radius.circular(4))
      ),
      child: Text(tagName, style: TextStyle(color: color(isActive)),),
    ).onTap(condition: onTap!=null, (){
      onTap?.call(isActive);
    });
  }
}

