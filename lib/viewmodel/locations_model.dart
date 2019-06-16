import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/location_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class LocationsModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  List<Location> locations;
  TextEditingController controller;

  Future fetchLocations() async {
    setState(ViewState.Busy);
    locations = await _api.getLocations();
    for (Location loc in locations) {
      GeolocationService().calculateDistance(loc.lat, loc.long).then((distance) {
        loc.distance = distance;
        locations.sort((loc1, loc2) {
            if (loc1.distance == null || loc2.distance == null) return 0;
            if (loc1.distance > loc2.distance) return 1;
            if (loc1.distance < loc2.distance) return -1;
            return 0;
          });
      });
    }
    /*
        api.getLocations().then((results) {
      print("getLocations with count (${results.length})");
      _isLocationsLoaded = true;
      for (Location loc in results) {
        // Calculate the distance and sort the location by distance
        GeolocationService()
            .calculateDistance(loc.lat, loc.long)
            .then((distance) {
          loc.distance = distance;
          // Sort the locations by distance
          results.sort((loc1, loc2) {
            if (loc1.distance == null || loc2.distance == null) return 0;
            if (loc1.distance > loc2.distance) return 1;
            if (loc1.distance < loc2.distance) return -1;
            return 0;
          });

          setState(() {});
        });
      }
      setState(() {
        _locationsResult = results;
      });
    }).catchError((error) {
      _isLocationsLoaded = true;
      print("TrakrefAPIService catch error on 'getLocations'");
    });
    */

    setState(ViewState.Idle);
  }

  List<Location> fetchLocationsFromSearch(String searching) {
    if (locations == null) 
      return [];

    return locations.where((location) => location.name.contains(searching)).toList();
  }
  
}