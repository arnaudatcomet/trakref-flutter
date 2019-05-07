import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/get_service.dart';

import '../api_service.dart';

class TrakrefAPIService {
  static String ApiTRKey = "Api-Key";
  static String AuthenticationTokenTRKey = "Authentication-Token";
  static String InstanceIDTRKey = "Instance-Id";
  static String SelectedAccountTRKey = "Selected-Account";
  static String SelectedProfileTRKey = "Selected-Profile";

  static final TrakrefAPIService _shared = new TrakrefAPIService
      ._internal();

  // API to call the endpoint
  ApiService apiService = ApiService();

  // Preferences to store the current instanceID for example
  SharedPreferences apiPreference;

  factory TrakrefAPIService() {
    return _shared;
  }

  // Private method
  Future<bool> _setValues( String key, String val) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  Future<String> _getValue( String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // To set properties for right call to Trakref API
  void setAPIKey(String apiKey) async {
    _setValues(TrakrefAPIService.ApiTRKey, apiKey);
  }

  void setAuthentificationToken(String token) async {
    _setValues(TrakrefAPIService.AuthenticationTokenTRKey, token);
  }

  void setInstanceID(String instanceID) async {
    _setValues(TrakrefAPIService.InstanceIDTRKey, instanceID);
  }

  void setSelectedAccount(Account acc) async {
    String accountString = jsonEncode(acc);
    _setValues(TrakrefAPIService.SelectedAccountTRKey, accountString);
  }

  void setProfile(InfoUser user) async {
    String userString = jsonEncode(user);
    _setValues(TrakrefAPIService.SelectedProfileTRKey, userString);
  }

  Future<String> getAPIKey() async {
    return await _getValue(TrakrefAPIService.ApiTRKey);
  }

  Future<String> getAuthentificationToken() async {
    return await _getValue(TrakrefAPIService.AuthenticationTokenTRKey);
  }

  Future<String> getInstanceID() async {
    return await _getValue(TrakrefAPIService.InstanceIDTRKey);
  }

  Future<Account> getSelectedAccount() async {
    String accountString = await _getValue(TrakrefAPIService.SelectedAccountTRKey);
    Map accountMap = jsonDecode(accountString);
    Account account = Account.fromJson(accountMap);
    return account;
  }

  Future<InfoUser> getSelectedProfile() async {
    String userString = await _getValue(TrakrefAPIService.SelectedProfileTRKey);
    Map userMap = jsonDecode(userString);
    InfoUser user = InfoUser.fromJson(userMap);
    return user;
  }

  TrakrefAPIService._internal();

  // Get constructed API
  Future<ApiService> getAPI() async {
    String token = await getAuthentificationToken();
    String instanceID = await getInstanceID();
    if (token == null || instanceID == null) {
      Future.error("No token or no instanceID associated");
    }
    ApiService api = ApiService(
        instanceID: instanceID,
        token: token
    );
    return api;
  }
  // Access to different API services endpoint
  // Showing the GET Dropdowns
  Future<DropdownList> getDropdown() async {
    String token = await getAuthentificationToken();
    String instanceID = await getInstanceID();
    if (token == null || instanceID == null) {
      Future.error("No token or no instanceID associated");
    }
    ApiService api = ApiService(
        instanceID: instanceID,
        token: token
    );
    return await api.getDropdowns(ApiService.getDropdownsTestURL);
  }

  // Showing the GET Accounts
  Future<List<Account>> getAccounts() async {
    String token = await getAuthentificationToken();
    String instanceID = await getInstanceID();
    if (token == null || instanceID == null) {
      Future.error("No token or no instanceID associated");
    }
    ApiService api = ApiService(
      instanceID: instanceID,
      token: token
    );
    return await api.getResults<Account>(ApiService.getAccountsURL);
  }

  // Showing the GET Locations
  Future<List<Location>> getLocations() async {
    ApiService api = await getAPI();
    return await api.getResults<Location>(ApiService.getLocationsURL);
  }

  Future<List> getLocationAroundMe(double lat, double long, double range) async {
    String getGeolocationURL = "${ApiService.getGeolocationsURL}?latitude=$lat&longitude=$long&range=$range";
    print("getGeolocationURL $getGeolocationURL");
    ApiService api = await getAPI();
    return await api.getResults<Location>(getGeolocationURL);
  }

  // Showing the GET Work Orders
  Future<List<WorkOrder>> getServiceEvents(List<int> locationIDs) async {
    ApiService api = await getAPI();

    if (locationIDs.length > 0) {
      List<String> locations = locationIDs.map((value) => "LocationID=${value.toString()}").toList();
      String locationParameters = locations.join("&");
      var baseUrl = "${ApiService.getWorkOrdersURL}?GetLocationArray?$locationParameters";
      print("getServiceEvents > Show baseURL $baseUrl");

      return await api.getResults<WorkOrder>(baseUrl).catchError((error) {
        Future.error(error);
      });
    }
    else {
      var baseUrl = "${ApiService.getWorkOrdersByInstanceURL}";
      print("getServiceEvents > Show baseURL $baseUrl");
      return await api.getResults<WorkOrder>(baseUrl).catchError((error) {
        Future.error(error);
      });
    }
  }

  Future<List<Asset>> getCylinders(List<int> locationIDs) async {
    ApiService api = await getAPI();

    if (locationIDs.length > 0) {
      List<String> locations = locationIDs.map((value) => "LocationID=${value.toString()}").toList();
      String locationParameters = locations.join("&");
      var baseUrl = "${ApiService.getAssetsURL}?GetLocationArray?$locationParameters";
      print("getCylinders > Show baseURL $baseUrl");

      return await api.getResults<Asset>(baseUrl).catchError((error) {
        Future.error(error);
      });
    }
    else {
      var baseUrl = "${ApiService.getAssetsByInstanceURL}";
      print("getServiceEvents > Show baseURL $baseUrl");
      return await api.getResults<Asset>(baseUrl).catchError((error) {
        Future.error(error);
      });
    }
  }

  // For logging out
  void logout() async {
    await setAuthentificationToken(null);
    await setInstanceID(null);
  }

  close() {
    apiService.close();
  }
}