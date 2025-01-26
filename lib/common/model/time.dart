


import 'package:intl/intl.dart';

class Time implements Comparable<Time>{

  final int _year = 2000;
  final int _month = 1;
  final int _day = 1;

  late DateTime dateTime;

  Time({required int hour, required int minute, int second=0, int millisecond=0,  int microsecond=0}){
    dateTime = DateTime(_year, _month, _day,  hour,  minute, millisecond, microsecond);
  }

  Time add(Duration dur){
    dateTime.add(dur);
    return this;
  }

  String format(DateFormat df){
    return df.format(dateTime);
  }

  int get hour => dateTime.hour;
  int get minute => dateTime.minute;
  int get second => dateTime.second;
  int get millisecond => dateTime.millisecond;
  int get microsecond => dateTime.microsecond;

  @override
  int compareTo(Time other) => compareTo(other);

}