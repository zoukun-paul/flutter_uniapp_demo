

/// 大学目标数据模型类
class TargetSchedule {

  /// 截至日期
  final DateTime? deadline;

  /// 标题名称
  final String title;

  /// 备注
  final String? note;

  /// 地点
  final String? location;

  TargetSchedule({this.deadline, required this.title, this.note, this.location});

}
