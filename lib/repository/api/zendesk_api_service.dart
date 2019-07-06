import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trakref_app/models/zdrequest.dart';

class ZendeskAPIService {
  http.Client _client = http.Client();
  static String _baseURL = "https://trakref.zendesk.com/api/v2";
  static String _requestEndpoint = "/requests.json";

  static final ZendeskAPIService _shared = new ZendeskAPIService._internal();

  String get getRequestEndPoint => _baseURL + _requestEndpoint;

  factory ZendeskAPIService() {
    return _shared;
  }

  ZendeskAPIService._internal();

  // POST a new request
  Future<dynamic> postNewRequest(ZDRequestPost newRequest) async {
    String requestString = json.encode(newRequest.toJson());
    final headers = {
      "Content-Type": "application/json",
    };
    return _client.post(getRequestEndPoint,
        body: requestString, headers: headers);
  }
}
