

import 'dart:async';

import 'package:geolocator/geolocator.dart';
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  await checkPermission();
  var setting = AndroidSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    forceLocationManager: true,
    timeLimit: const Duration(seconds: 3)
  );
  return await Geolocator.getCurrentPosition(
    locationSettings: setting,
  );
}

Future<Stream<Position>> determinePositionStream() async {
  await checkPermission();
  var locationServiceEnabled =await Geolocator.isLocationServiceEnabled();
  var locationAccuracy =await Geolocator.getLocationAccuracy();
  var setting = AndroidSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      forceLocationManager: true,
      distanceFilter: 0,
      intervalDuration: const Duration(seconds: 1),
      timeLimit: const Duration(seconds: 6),
      foregroundNotificationConfig:const ForegroundNotificationConfig(
        notificationTitle: 'locatin',
        notificationText: '1231',
        enableWakeLock: true,
      )
  );
  return Geolocator.getPositionStream(
      locationSettings: setting,
  );
}

Future checkPermission() async{
  bool serviceEnabled;
  LocationPermission permission;
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return Future.value();
}
