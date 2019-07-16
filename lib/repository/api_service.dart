import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';

class ApiService {
  final JsonDecoder _decoder = new JsonDecoder();
  static String baseURL = "https://api.trakref.com";
  static String baseTestURL = "https://apitest.trakref.com";
  static String getWorkOrdersURL = "$baseURL/v3.21/WorkOrders";
  static String getWorkOrdersByInstanceURL = "$getWorkOrdersURL/GetByInstance";

  static String getAssetsURL = "$baseURL/v3.21/Assets";
  static String getAssetsByInstanceURL = "$getAssetsURL/GetByInstance";

  static String getCylindersURL = "$baseURL/v3.21/cylinders";

  static String getLoginURL = "$baseURL/v3.21/login";
  static String getDropdownsURL = "$baseURL/v3.21/dropdowns";
  static String getDropdownsTestURL = "$baseTestURL/v3.21/dropdowns";
  static String getAccountsURL = "$baseURL/v3.21/accounts";
  static String getLocationsURL = "$baseURL/v3.21/location";
  static String getGeolocationsURL = "$baseURL/v3.21/geolocation";

  http.Client client = http.Client();

  final String token;
  final String instanceID;
  String apiKey =
      'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';

  ApiService({this.token, this.instanceID});

  close() {
    client.close();
  }

  Future<dynamic> get(String url) async {
    final headers = {
      "Content-Type": "application/json",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID"
    };
    return client.get(url, headers: headers).then((http.Response response) {
      final res = response.body;
      List resJson = _decoder.convert(res);
      return resJson;
    });
  }

  Future<dynamic> post<T>(T item, String url) async {
    final headers = {
      "Content-Type": "application/json",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID",
      "Accept-Encoding": "gzip, deflate"
    };

    print("### post ### $item");
    print("### headers ### $headers");

    return await client
        .post(url, headers: headers)
        .then((http.Response response) {
      final res = response.body;
      print("post $url, result $res");
    });
  }

  Future<dynamic> postWorkOrder(WorkOrder order, String url) async {
    final headers = {
      "Content-Type": "application/json",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID"
    };

    String jsonString = json.encode([order.toJson()]);

    return await client
        .post(url, headers: headers, body: jsonString, encoding: utf8)
        .then((http.Response response) {
      final res = response.body;
      // Catch error
      try {
        Map resMap = json.decode(res);
        if (resMap['Message'] != null) {
          print("postWorkOrder $url, error ${resMap['Message']}");
          return Future.error(resMap['Message']);
        }
      } catch (error) {
        print("postWorkOrder > Didn't find error on expected error");
      }

      // Catch response
      try {
        Map resMap = json.decode(res).first;
        WorkOrder workOrder = WorkOrder.fromJson(resMap);
        print("postWorkOrder > workOrder:: $workOrder");
        return true;
      } catch (error) {
        return Future.error("Not found a work order as a response");
      }
    });
  }

  Future<dynamic> postAsset(Asset asset, String url) async {
    final headers = {
      "Content-Type": "application/json",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID"
    };

    String jsonString = json.encode([asset.toJson()]);

    return await client
        .post(url, headers: headers, body: jsonString, encoding: utf8)
        .then((http.Response response) {
      final res = response.body;
      print("post $url, result $res");
      try {
        List<Map> resListMap = json.decode(res);
        Map resMap = resListMap.first;
        // Look for error first
        if (resMap['Message'] != null) {
          return Future.error("${resMap['Message']}");
        }
        return resMap;
      }
      catch (error) {
          return Future.error(error);
      }
    });
  }

  Future<dynamic> getLoginResponse(
      String url, String username, String password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print('basicAuth $basicAuth');
    final headers = {"API-Key": "$apiKey", "authorization": "$basicAuth"};
    print("getLoginResponse $headers");
    return client.get(url, headers: headers);
  }

  Future<List> getLocationAroundMe(
      double lat, double long, double range) async {
    String getLocationURL =
        "${ApiService.baseURL}/v3.21/geolocation?latitude=$lat&longitude=$long&range=$range";
    print("getLocationURL $getLocationURL");
    return await getResults<Location>(getLocationURL);
  }

  Future<DropdownList> getDropdowns(String url) async {
    final headers = {
      "Content-Type": "application/json",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID"
    };

    // print("### getResults for DropdownList > URL $url");
    // print("### getResults for DropdownList > Headers $headers");

    return await client
        .get(url, headers: headers)
        .then((http.Response response) {
      final res = response.body;
      // print("#### response from $url : $res");
      try {
        dynamic resultMap = jsonDecode(res);
        DropdownList dropdowns = DropdownList.fromJson(resultMap);
        return dropdowns;
      } catch (error) {
        Future.error(error);
      }
    });
  }

  Future<List> getResults<T>(String url) async {
    final headers = {
      "Content-Type": "application/json",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID"
    };

    print("### getResults > URL $url");
    print("### getResults > Headers $headers");

    return await client
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 120))
        .then((http.Response response) {
      final res = response.body;
      print("#### response from $url : $res");
      try {
        List<dynamic> resultMap = jsonDecode(res);

        // For checking type of generic type T
        List<T> someList = new List<T>();
        String type = someList.runtimeType.toString();
        List<WorkOrder> workOrderList = new List<WorkOrder>();
        List<Asset> assetsList = new List<Asset>();
        List<Location> locationsList = new List<Location>();
        List<Account> accountsList = new List<Account>();

        // This is a type WorkOrder
        if (type.toString() == workOrderList.runtimeType.toString()) {
          List<WorkOrder> results = [];
          for (Map<String, dynamic> result in resultMap) {
            WorkOrder singleResult = WorkOrder.fromJson(result);
            results.add(singleResult);
          }
          return results;
        }

        // This is a type Assets
        if (type.toString() == assetsList.runtimeType.toString()) {
          List<Asset> results = [];
          for (Map<String, dynamic> result in resultMap) {
            Asset singleResult = Asset.fromJson(result);
            results.add(singleResult);
          }
          return results;
        }

        // This is a type Locations
        if (type.toString() == locationsList.runtimeType.toString()) {
          List<Location> results = [];
          for (Map<String, dynamic> result in resultMap) {
            Location singleResult = Location.fromJson(result);
            results.add(singleResult);
          }
          return results;
        }

        // This is a type Accounts
        if (type.toString() == accountsList.runtimeType.toString()) {
          List<Account> results = [];
          for (Map<String, dynamic> result in resultMap) {
            Account singleResult = Account.fromJson(result);
            results.add(singleResult);
          }
          return results;
        }

        // Nothing instead
        return [];
      } catch (error) {
        Future.error(error);
      }
    });
  }

  Future<dynamic> getStandard(String url) async {
    final headers = {
      "Content-Type": "application/json",
//      "Userid":"$_userID",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$token",
      "Instance-Id": "$instanceID"
    };
    print("#### getStandard url $url ####");
    print("apiKey $apiKey");
    print("token $token");
    print("instanceID $instanceID");
    print("#####################");

    return client.get(url, headers: headers).then((http.Response response) {
      final res = response.body;
      return res;
    });
  }
}
