import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trakref_app/constants.dart';

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