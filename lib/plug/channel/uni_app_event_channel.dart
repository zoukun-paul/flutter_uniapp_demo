import 'dart:convert';

import 'package:flutter/services.dart';

import 'event_resp.dart';
import 'handler/location_event_channel_handler.dart';

class UniAppEventChannel {
  final locationEventChannelHandler = LocationEventChannelHandler();

  late Map<String,UniAppEventChannelHandler> handlersMap = {
    locationEventChannelHandler.getCommand() : locationEventChannelHandler,
  };

  static const _channel = BasicMessageChannel('uni_app_event', JSONMessageCodec());

  void init() {
    _channel.setMessageHandler((msg) async {
      try {
        if (msg is String) {
          var event = _Event.fromJson(jsonDecode(msg));
          var data = event.data;
          EventParameter? eventParameter;
          if (data is Map<String, dynamic>) {
            if (data['command'] == null) {
              return EventResp.error("missing command parameter").toJsonString();
            }
            eventParameter = EventParameter.fromJson(data);
          } else if (data is String) {
            eventParameter = EventParameter.fromJson(jsonDecode(data));
          }
          if (eventParameter == null) {
            return EventResp.invalidFormat().toJsonString();
          }
          // handler
          if (handlersMap[eventParameter.command] == null) {
            return EventResp.notFound(
                msg: "not found the ${eventParameter.command} command handler ").toJsonString();
          }
          return handlersMap[eventParameter.command]!.handler(eventParameter).toJsonString();
        }
        return EventResp.invalidFormat().toJsonString();
      }catch(e){
        return EventResp.sysError().toJsonString();
      }
    });
  }

}


abstract class UniAppEventChannelHandler<T> {

  String getCommand();

  EventResp<T> handler(EventParameter parameter);

}

class _Event {
  final String appId;
  final Object? data;
  final String eventId;

  _Event(this.appId, this.data, this.eventId);

  _Event.fromJson(Map<String, dynamic> json)
      : appId = json['appId'],
        data = json.containsKey("data") ? json['data'] : null,
        eventId = json['eventId'];

  Map<String, dynamic> toJson() => {
        'appId': appId,
        'data': data,
        'eventId': eventId,
      };
}

class EventParameter {

  final String command;

  final Object? data;

  EventParameter(this.command, this.data);

  EventParameter.fromJson(Map<String, dynamic> json):
      command = json['command'],
      data = json.containsKey('data')?json['data']:null;

}