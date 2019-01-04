import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trakref_app/constants.dart';
import 'package:codable/codable.dart';

class Account extends Coding {
  String name; // Name
  int instanceID; // InstanceID
  int accountTypeID; // AccountTypeID
  String accountType; // AccountType
  String statusName; // StatusName

  @override
  void decode(KeyedArchive object) {
    // TODO: implement decode
    super.decode(object);

    name = object.decode('Name');
    instanceID = object.decode('InstanceID');
    accountTypeID = object.decode('AccountTypeID');
    accountType = object.decode('AccountType');
    statusName = object.decode('StatusName');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('Name', name);
    object.encode('InstanceID', instanceID);
    object.encode('AccountTypeID', accountTypeID);
    object.encode('AccountType', accountType);
    object.encode('StatusName', statusName);
  }
}

class ApiService {
  ApiService();
  final JsonDecoder _decoder = new JsonDecoder();

  // By default for our test
  String _userID = 'echappell';
  String _token = '5d5ac1ae-0213-4e77-9ee7-e3a76e614909';
  String _instanceID = '6';

  initialize(String userID, String token, String instanceID) {
    this._token = token;
    this._userID = userID;
    this._instanceID = instanceID;
  }

  Future<dynamic> get(String url) async {
    String apiKey = 'eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=';
    final headers = {"Content-Type": "application/json", "Userid":"$_userID", "Api-Key":"$apiKey", "Authentication-Token":"$_token", "Instance-Id":"$_instanceID"};
    print('Arnaud::headers : $headers');
    return http.get(url, headers: headers).then((http.Response response) {
      final res = response.body;
      print('res : $res');
      List resJson = _decoder.convert(res);
      print('resJson : $resJson');
      return resJson;
    });
  }
}

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