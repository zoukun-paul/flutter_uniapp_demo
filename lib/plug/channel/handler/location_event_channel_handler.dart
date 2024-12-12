

import 'package:flutter_uniapp_demo/plug/channel/event_resp.dart';
import 'package:flutter_uniapp_demo/plug/channel/uni_app_event_channel.dart';

class LocationEventChannelHandler extends UniAppEventChannelHandler {

  @override
  String getCommand()  => "location.single";

  @override
  EventResp handler(EventParameter parameter) {
    return EventResp.success(LocationData(11,21));
  }

}

class LocationData{

  double? longitude;

  double? latitude;

  LocationData(this.longitude, this.latitude);
}