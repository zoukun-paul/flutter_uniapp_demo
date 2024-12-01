

import 'package:flutter/material.dart';
import 'package:flutter_uniapp_demo/common/const.dart';
import 'package:flutter_uniapp_demo/plug/geolocator.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  double? altitude;
  double? latitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: SizedBox(height: Const.statusBarHeight,)),
          TextButton(onPressed: () async {
            var pos = await determinePosition();
            setState(() {
              altitude = pos.altitude;
              latitude = pos.latitude;
            });
          }, child: const Text("获取位置-flutter")),
          Text("location $altitude, $latitude")
        ],
      ),
    );
  }

}
