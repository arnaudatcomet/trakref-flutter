import 'dart:async';
import 'package:geolocator/geolocator.dart' as geolocation;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class GeolocationService {
  static final GeolocationService _shared = new GeolocationService._internal();
  Location locationService = new Location();
  LocationData currentLocation;
  bool _permission = false;

  factory GeolocationService() {
    return _shared;
  }

  GeolocationService._internal();

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await locationService.getLocation();
          _locationSubscription = locationService.onLocationChanged().listen((LocationData result) async {
            // print("latitude : ${result.latitude}");
            // print("longitude : ${result.longitude}");
            currentLocation = result;
          });
        }
      } else {
        bool serviceStatusResult = await locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        // Need to print that error
//        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        // Need to print that error
//        error = e.message;
      }
      location = null;
    }

    _startLocation = location;
  }

  Future<double> calculateDistance(double distantLat, double distantLong) async {
    if (currentLocation == null) {
      return 0;
    }
    return await geolocation.Geolocator().distanceBetween(currentLocation.latitude, currentLocation.longitude,
        distantLat, distantLong);
  }
}