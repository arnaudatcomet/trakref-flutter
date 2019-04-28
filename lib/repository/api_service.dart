import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';

class ApiService {
  ApiService();
  final JsonDecoder _decoder = new JsonDecoder();

  static String baseURL = "http://apitest.trakref.com";

  // By default for our test
  String _userID = 'echappell';
  String _token = '5d5ac1ae-0213-4e77-9ee7-e3a76e614909';
  String _instanceID = '6';

  initialize(String userID, String token, String instanceID) {
    this._token = token;
    this._userID = userID;
    this._instanceID = instanceID;
  }

  Future<dynamic> get(String url) async {
    String apiKey = 'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';
    final headers = {"Content-Type": "application/json", "Userid":"$_userID", "Api-Key":"$apiKey", "Authentication-Token":"$_token", "Instance-Id":"$_instanceID"};
    return http.get(url, headers: headers).then((http.Response response) {
      final res = response.body;
      List resJson = _decoder.convert(res);
      return resJson;
    });
  }

  Future<dynamic> post<T>(T item, String url) async {
    String apiKey = 'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';
    final headers = {
      "Content-Type": "application/json",
      "Userid": "$_userID",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$_token",
      "Instance-Id": "$_instanceID"
    };

    return await http.post(url, headers: headers).then((http.Response response){
      final res = response.body;
      print("post $url, result $res");
    });
  }

  Future<dynamic> postWorkOrder(WorkOrder order, String url) async {
    String apiKey = 'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';
    final headers = {
      "Content-Type": "application/json",
      "Userid": "$_userID",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$_token",
      "Instance-Id": "$_instanceID"
    };

    String jsonString = json.encode([order.toJson()]);

    return await http.post(url, headers: headers, body: jsonString, encoding: utf8).then((http.Response response){
      final res = response.body;
      print("post $url, result $res");
    });
  }

  Future<dynamic> getLoginResponse(String url, String username, String password) async {

    String basicAuth = 'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print('basicAuth $basicAuth');
    return http.get(url, headers: {"API-Key": "$apiKey", "authorization":"$basicAuth"}
    );
  }

  Future<List> getLocationAroundMe(double lat, double long, double range) async {
    String getLocationURL = "${ApiService.baseURL}/v3.21/geolocation?latitude=$lat&longitude=$long&range=$range";
    return await getResult<Location>(getLocationURL);
  }

  Future<List> getResult<T>(String url) async {
    String apiKey = 'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';
    final headers = {
      "Content-Type": "application/json",
      "Userid": "$_userID",
      "Api-Key": "$apiKey",
      "Authentication-Token": "$_token",
      "Instance-Id": "$_instanceID"
    };

    return await http.get(url, headers: headers).then((http.Response response) {
      final res = response.body;
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
    });
  }

  Future<dynamic> getStandard(String url) async {
    String apiKey = 'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';
    final headers = {"Content-Type": "application/json", "Userid":"$_userID", "Api-Key":"$apiKey", "Authentication-Token":"$_token", "Instance-Id":"$_instanceID"};
    return http.get(url, headers: headers).then((http.Response response) {
      final res = response.body;
      return res;
    });
  }
}

// Service to login user
class LoginService {
  LoginService();

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> login(String username, String password) async {
    String basicAuth = 'Basic '+ base64Encode(utf8.encode('$username:$password'));
    print('basicAuth $basicAuth');
    return http.get(loginURL, headers: {"API-Key": "$apiKey", "authorization":"$basicAuth"}
    ).then((http.Response response) {
      print('this is the login response $response');
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("statusCode : $statusCode");
      if (statusCode == 401) {
        return throw ("Error : request not authorized (username / password not matching)");
      }
      else if (statusCode < 200 || statusCode > 400) {
        print("Error while fetching datas");
        return throw ("Error while fetching datas");
      }
      // In case username and password don't match
      try {
        print('Try to convert $res');
        return _decoder.convert(res);
      }
      catch(e) {
        print("Error username and password don't match");
        throw new Exception("Error username and password don't match");
      }
    });
  }
}

