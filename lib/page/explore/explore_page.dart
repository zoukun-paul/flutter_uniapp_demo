

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/const.dart';
import 'package:flutter_uniapp_demo/plug/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  double? longitude;
  double? latitude;
  List<Position> positions = [];
  var location = Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(child: SizedBox(height: Const.statusBarHeight,)),
          TextButton(onPressed: () async {
            var pos = await determinePosition();
            print("pos $pos");
            setState(() {
              latitude = pos.latitude;
              longitude = pos.longitude;
            });
          }, child: const Text("获取位置-flutter")),
          Text("location $longitude, $latitude"),

          TextButton(onPressed: () async {
            var stream = await determinePositionStream();
            var listen = stream.listen((pos){
              setState(() {
                positions.add(pos);
              });
            });
            listen.onError((e){
              print("error $e");
            });
            listen.onData((e){
              print("data $e");
            });
            listen.onDone((){
              print("finish");
            });
          }, child: const Text("track")),
          Expanded(
            child: ListView(
              children: [
                ...positions.map((f){
                  return Text("(${f.altitude}, ${f.longitude})");
                })
              ],
            ),
          )
        ],
      ),
    );
  }


}
