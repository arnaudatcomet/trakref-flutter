import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

final String baseURL = "https://apitest.trakref.com/v3.21";
final String loginURL = "$baseURL/login";

class LoginService {
  LoginService();

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> login(String username, String password) async {
    return http.get(loginURL).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching datas");
      }
      return _decoder.convert(res);
    });
  }
}

class LoginBloc {
  String user;
  String token;

  LoginBloc(this.user, this.token);
}