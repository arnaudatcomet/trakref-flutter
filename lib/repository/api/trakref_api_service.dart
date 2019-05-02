import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/models/info_user.dart';

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

  // Access to different API services endpoint
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
    return await api.getResult<Account>(ApiService.getAccountsURL);
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