import 'package:location/location.dart';
import 'package:flutter/services.dart';

class GeolocationService {
  static final GeolocationService _shared = new GeolocationService._internal();
  Location _locationService = new Location();

  factory GeolocationService() {
    return _shared;
  }

  GeolocationService._internal();

  // Need to
  initPlatformState() async {
  }

  getCurrentLocation() async {
//    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
//
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      LocationData location;
//      await currentLocation.getLocation();
//    } on PlatformException catch (e) {
//      if (e.code == 'PERMISSION_DENIED') {
//        error = 'Permission denied';
//      }
//      currentLocation = null;
//    }
  }
}