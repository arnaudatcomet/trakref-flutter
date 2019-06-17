import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/location_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class LocationsModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  GeolocationService _geolocation = GeolocationService();
  List<Location> locations;
  TextEditingController controller;

  startGeolocation() {
    print("startGeolocation");
    _geolocation.initPlatformState();
    print("${GeolocationService().currentLocation}");
    
  }

  Future fetchLocations() async {
    setState(ViewState.Busy);
    locations = await _api.getLocations();
    for (Location loc in locations) {
      GeolocationService()
          .calculateDistance(loc.lat, loc.long)
          .then((distance) {
        loc.distance = distance;
        locations.sort((loc1, loc2) {
          if (loc1.distance == null || loc2.distance == null) return 0;
          if (loc1.distance > loc2.distance) return 1;
          if (loc1.distance < loc2.distance) return -1;
          return 0;
        });
      });
    }
    setState(ViewState.Idle);
  }

  Future fetchLocationsAroundMe() async {
    setState(ViewState.Busy);
    print("_geolocation.currentLocation is ${_geolocation.currentLocation}");
    if (_geolocation.currentLocation == null) {
      setState(ViewState.Error);
    } else {
      double currentLatitude = _geolocation.currentLocation?.latitude;
      double currentLongitude = _geolocation.currentLocation?.longitude;
      locations = await _api.getLocationAroundMe(
          currentLatitude, currentLongitude, 100);
      setState(ViewState.Idle);
    }
  }

  List<Location> fetchLocationsFromSearch(String searchedText) {
    if (locations == null) return [];

    List<Location> _filteredLocationsResult = [];

    locations.forEach((location) {
      String physicalAddress1 = location.physicalAddress1 ?? "";
      String physicalCity = location.physicalCity ?? "";
      String name = location.name ?? "";
      String physicalState = location.physicalState ?? "";

      if (physicalAddress1.toLowerCase().contains(searchedText) ||
          physicalCity.toLowerCase().contains(searchedText) ||
          name.toLowerCase().contains(searchedText) ||
          physicalState.toLowerCase().contains(searchedText)) {
        _filteredLocationsResult.add(location);
      }
    });

    return _filteredLocationsResult;
  }
}
