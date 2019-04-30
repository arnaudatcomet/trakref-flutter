import 'dart:async';
import 'dart:convert';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';

class LoginBloc implements BlocBase {
//  LoggedUser _user = LoggedUser.empty();
//  LoginService _loginService = LoginService();
  InfoUser _user;

  ApiService _apiService = ApiService();
  final JsonDecoder _decoder = new JsonDecoder();

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