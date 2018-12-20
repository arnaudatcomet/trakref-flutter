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

  // Stream to handle the login / password
  StreamController<LoggedUser> _submitLoginController = StreamController<LoggedUser>.broadcast();
  Sink<LoggedUser> get submitLogin => _submitLoginController.sink;
  Stream<LoggedUser> get resultLogin => _submitLoginController.stream;

  LoginBloc() {
    _submitLoginController.stream.listen(_onSubmitLogin);
  }

  void _onSubmitLogin(LoggedUser user) {
    print('logged username ${user.username}');
    print('logged password ${user.password}');
    String username = user.username;
    String password = user.password;

    _loginService.login(username, password).then((result){
        LoggedUser user = LoggedUser.fromJson(result);
        print(user.toString());
        _user = user;
    }).catchError((error) {
      _submitLoginController.addError(error);
        print('_loginService caught an error : $error');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _submitLoginController.close();
  }
}