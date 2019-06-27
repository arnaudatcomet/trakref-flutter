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

    print("infoUser ${response}");
    final res = response.body;
    setState(ViewState.Idle);
    try {
      dynamic resultMap = jsonDecode(res);
      print("resultMap $resultMap");
      user = InfoUser.fromJson(resultMap);

      if (user.errorMessage != null) {
        errorMessage = user.errorMessage;
        return false;
      } 
      else if (user.token.token == null || user.user.instanceID == null) {
        errorMessage = "Could not find Token or InstanceID associated to user account";
        return false;
      } else {
        // Save the login keys
        _trakrefApi.setAuthentificationToken(user.token.token);
        _trakrefApi.setInstanceID((user.user.instanceID == 0)
            ? "248"
            : user.user.instanceID.toString());
        _trakrefApi.setProfile(user);

        return true;
      }
    } catch (error) {
      print("LoginModel catch exception error $error");
      return false;
    }
  }
}
