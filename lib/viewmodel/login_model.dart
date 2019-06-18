import 'dart:convert';

import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class LoginModel extends BaseModel {
  final ApiService _api = ApiService();
  final TrakrefAPIService _trakrefApi = TrakrefAPIService();
  final CachingAPIService _cachingApi = CachingAPIService();
  
  InfoUser user;
  String errorMessage;

  fetchDropdowns() {
    _cachingApi.fetchCachedDropdowns();
  }

  Future<bool> login(String username, String password) async {
    setState(ViewState.Busy);
    dynamic response =
        await _api.getLoginResponse(ApiService.getLoginURL, username, password);

    setState(ViewState.Idle);
    print("infoUser ${response}");
    final res = response.body;
    try {
      dynamic resultMap = jsonDecode(res);
      print("resultMap $resultMap");
      user = InfoUser.fromJson(resultMap);

      if (user.errorMessage != null) {
        errorMessage = user.errorMessage;
      } else {
        // Save the login keys
        _trakrefApi.setAuthentificationToken(user.token.token);
        _trakrefApi.setInstanceID((user.user.instanceID == 0)
            ? "248"
            : user.user.instanceID.toString());
        _trakrefApi.setProfile(user);

        // Caching
        // CachingAPIService _cachingService = CachingAPIService();
        // _cachingService.getCachedDropdowns();
        // _cachingService.getCachedAccount();

        return true;
      }
    } catch (error) {
      print("LoginModel catch exception error $error");
      return false;
    }
  }
}
