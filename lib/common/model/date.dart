

import 'package:flutter_uniapp_demo/common/model/week.dart';

class Date {

    late DateTime dateTime;

    Date({required int year, required int month, required int day}){
      dateTime = DateTime(year, month, day);
    }

    Date.dateTime(DateTime dateTime):this(year: dateTime.year, month:dateTime.month, day: dateTime.day);

    Date add({required int days}){
      dateTime.add(Duration(days: days));
      return this;
    }

    Weekday weekday(){
      return Weekday.of(dateTime.weekday)!;
    }

}