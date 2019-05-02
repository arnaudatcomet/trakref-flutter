import 'dart:async';
import 'dart:convert';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc implements BlocBase {
  InfoUser _user;
  ApiService _apiService = ApiService();
  TrakrefAPIService _trakrefService = TrakrefAPIService();
  final JsonDecoder _decoder = new JsonDecoder();

  // To save the preferences
  SharedPreferences preferences;

  // Stream to handle the login / password
  StreamController<InfoUser> _submitLoginController = StreamController<InfoUser>.broadcast();
  Sink<InfoUser> get submitLogin => _submitLoginController.sink;
  Stream<InfoUser> get resultLogin => _submitLoginController.stream;

  // Stream to handle pushing to a new screen if the login was successful
  StreamController<InfoUser> _goingNextScreenController = StreamController<InfoUser>.broadcast();
  Stream<InfoUser> get nextScreen => _goingNextScreenController.stream;

  LoginBloc() {
    _submitLoginController.stream.listen(_onSubmitLogin);
  }

  void _onSubmitLogin(InfoUser user) {
    print('logged username ${user.user.username}');
    print('logged password ${user.user.password}');
    String username = user.user.username;
    String password = user.user.password;

    _apiService.getLoginResponse(ApiService.getLoginURL, username, password).then((response){
      print("infoUser ${response}");
      final res = response.body;
      dynamic resultMap = jsonDecode(res);
      InfoUser user = InfoUser.fromJson(resultMap);
      print("resultMap $resultMap");

      if (user.errorMessage != null) {
        _submitLoginController.addError(user.errorMessage);
      }
      else {
        String fullName = user.user?.fullName;
        String company = user.user?.company;
        String preferredLeakDetectionMethod = user.user?.preferredLeakDetectionMethod;
        String phone = user.user?.phone;
        String email = user.user?.email;

        print("Fullname $fullName");
        print("Company $company");
        print("PreferredLeakDetectionMethod $preferredLeakDetectionMethod");
        print("Phone $phone");
        print("email $email");

        print("Fullname $fullName");
        print("Fullname $fullName");
        _user = user;

        // Save the login keys
        _trakrefService.setAuthentificationToken(user.token.token);
        _trakrefService.setInstanceID((user.user.instanceID == 0) ? "248" : user.user.instanceID.toString());
        _trakrefService.setProfile(user);

        // Notify to go to the next screen
        _goingNextScreenController.add(user);
      }
    }).catchError((error){
      _submitLoginController.addError(error);
      print('_loginService caught an error : $error');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _submitLoginController.close();
    _goingNextScreenController.close();
  }
}