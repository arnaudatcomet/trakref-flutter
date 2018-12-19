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
      print('response $response');
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching datas");
      }
      return _decoder.convert(res);
    }).catchError((Exception error) {
      print('Exception $error');
    });
  }
}