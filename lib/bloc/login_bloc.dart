import 'dart:async';
import 'package:trakref_app/models/logged_user_entity.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/models/logged_user_entity.dart';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.contains('@')) {
          sink.add(email);
        }
        else {
          sink.addError('Email is not valid');
        }
      }
    );
}

class LoginBloc implements BlocBase {
  LoggedUser _user = LoggedUser.empty();
  LoginService _loginService = LoginService();

  // Variable to be pushed for the login
  String _username = null;
  String _password = null;

  // Stream to handle the login / password
  StreamController<String> _setUsernameController = StreamController<String>.broadcast();
  Sink<String> get setUsernameLogin => _setUsernameController.sink;

  StreamController<String> _setPasswordController = StreamController.broadcast();
  Sink<String> get setPasswordLogin => _setPasswordController.sink;
  Stream<String> get outPasswordResult => _setPasswordController.stream;

  StreamController<LoggedUser> _submitLoginController = StreamController<LoggedUser>.broadcast();
  Sink<LoggedUser> get submitLogin => _submitLoginController.sink;
  Stream<LoggedUser> get onLoginResult => _submitLoginController.stream;

  LoginBloc() {
    _setUsernameController.stream.listen(_onSetUsername);
    _setPasswordController.stream.listen(_onSetPassword);
    _submitLoginController.stream.listen(_onSubmitLogin);
  }

  void _onSetUsername(String username) {
    _username = username;
    _setUsernameController.add(username);
  }

  void _onSetPassword(String password) {
    _password = password;
    _setPasswordController.add(password);
  }

  void _onSubmitLogin(LoggedUser user) {
    print('logged username ${user.username}');
    print('logged password ${user.password}');
    String username = user.username;
    String password = user.password;
//    _loginService.login(_username, _password).then((result) {
      _loginService.login(username, password).then((result) {
       print('result : $result');
//       Map<String, dynamic> userJson = result['user'];
//       print('userJson : $userJson');
//       User user = User.fromJson(result['user']);
//       print('user : $user');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _setUsernameController.close();
    _setPasswordController.close();
    _submitLoginController.close();
  }
}