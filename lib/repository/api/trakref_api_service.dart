import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:path_provider/path_provider.dart';
import '../api_service.dart';

class TrakrefAPIService {
  static String ApiTRKey = "Api-Key";
  static String AuthenticationTokenTRKey = "Authentication-Token";
  static String InstanceIDTRKey = "Instance-Id";
  static String SelectedAccountTRKey = "Selected-Account";
  static String SelectedProfileTRKey = "Selected-Profile";
  static String SelectedWorkOrderTRKey = "Selected-WorkOrder";

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

  void setWorkOrder(WorkOrder workOrder) async {
    String workOrderString = jsonEncode(workOrder);
    _setValues(TrakrefAPIService.SelectedWorkOrderTRKey, workOrderString);
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

  Future<WorkOrder> getCurrentWorkOrder() async {
    String workOrderString = await _getValue(TrakrefAPIService.SelectedWorkOrderTRKey);
    if (workOrderString == null) {
      return Future.error("No Work Order found for selected Work Order");
    }
      Map workOrderMap = jsonDecode(workOrderString);
    WorkOrder workOrder = WorkOrder.fromJson(workOrderMap);
    return workOrder;
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

  // Save json to local path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/post_request.json');
  }

  Future<File> writeOnDisk<T>(List<T> item) async {
    final file = await _localFile;
    print("writeOrderOnDisk $file");
    // Write the file
    String itemString = jsonEncode(item);
    print("itemString $itemString");
    return file.writeAsString(itemString);
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
    print("getCylinders > for locations $locationIDs");

    if (locationIDs.length > 0) {
      List<String> locations = locationIDs.map((value) => "LocationID=${value.toString()}").toList();
      String locationParameters = locations.join("&");
      var baseUrl = "${ApiService.getAssetsURL}/GetLocationArray?$locationParameters";
      print("getCylinders > Show baseURL $baseUrl");

      return await api.getResults<Asset>(baseUrl).catchError((error) {
        print("getCylinder errors > $error");
        Future.error(error);
      });
    }
    else {
      var baseUrl = "${ApiService.getAssetsByInstanceURL}";
      print("getCylinders > Show baseURL $baseUrl");
      return await api.getResults<Asset>(baseUrl).catchError((error) {
        Future.error(error);
      });
    }
  }

  // POST
  Future<dynamic> post<T>(T item, String url) async {
    ApiService api = await getAPI();
    return await api.post(item, url);
  }

  Future<dynamic> postWorkOrder(WorkOrder order) async {
    String workOrderURL = ApiService.getWorkOrdersURL;
    ApiService api = await getAPI();
    return api.postWorkOrder(order, workOrderURL);
  }

  Future<dynamic> postCylinder(Asset cylinder) async {
    String assetsURL = ApiService.getCylindersURL;
    ApiService api = await getAPI();
    return api.postAsset(cylinder, assetsURL);
  }

  // For logging out
  void logout() async {
    setAuthentificationToken(null);
    setInstanceID(null);
    setSelectedAccount(null);
    setProfile(null);
    setWorkOrder(null);
  }

  close() {
    apiService.close();
  }
}