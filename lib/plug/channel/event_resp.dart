
import 'dart:convert';

class EventResp<T> {

  final String msg;

  final T? data;

  final int status;

  EventResp.success(this.data):msg="success", status=200;

  EventResp.error(this.msg, {this.status=500}):data=null;

  EventResp.notFound({this.msg="not found command"}):status=404,data=null;

  EventResp.invalidFormat({this.msg="invalid format"}):status=501,data=null;

  EventResp.sysError({this.msg="client system exception"}):status=502,data=null;

  Map<String, dynamic> toJson() => {
    'msg': msg,
    'data': data,
    'status': status,
  };

  String toJsonString(){
    return jsonEncode(this);
  }

}

