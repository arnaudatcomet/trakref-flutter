import 'dart:async';
import 'package:codable/codable.dart';
import 'package:trakref_app/models/logged_user_entity.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/constants.dart';

class LoginBloc implements BlocBase {
  LoggedUser _user = LoggedUser.empty();
  LoginService _loginService = LoginService();

  // Stream to handle the login / password
  StreamController<LoggedUser> _submitLoginController = StreamController<LoggedUser>.broadcast();
  Sink<LoggedUser> get submitLogin => _submitLoginController.sink;
  Stream<LoggedUser> get resultLogin => _submitLoginController.stream;

  // Stream to handle pushing to a new screen if the login was successful
  StreamController<LoggedUser> _goingNextScreenController = StreamController<LoggedUser>.broadcast();
  Stream<LoggedUser> get nextScreen => _goingNextScreenController.stream;

  LoginBloc() {
    _submitLoginController.stream.listen(_onSubmitLogin);
  }

  void _onSubmitLogin(LoggedUser user) {
    print('logged username ${user.username}');
    print('logged password ${user.password}');
    String username = user.username;
    String password = user.password;

    /*
    ApiService().get(accountsURL).then((accountsJSON) {
      for (var i = 0; i < accountsJSON.length; i++) {
        final Map<String, dynamic> accountJSON = Map<String, dynamic>.from(accountsJSON[i]);
        final archive = KeyedArchive.unarchive(accountJSON);
        Account account = Account();
        account.decode(archive);
        print('ApiService<Account> account ${account.name} ${account.accountType} ${account.instanceID}');
      }
    });
    */

    _loginService.login(username, password).then((result){
        LoggedUser user = LoggedUser.fromJson(result);
        print(user.toString());
        _user = user;
        _goingNextScreenController.add(user);
    }).catchError((error) {
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