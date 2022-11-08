import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/config.dart' as config;

final HttpServieManager = HttpService();
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

class HttpService {
  var isRetryRequest = false;

  static var headerPost = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };

  Future getHeaderGET() async {
    final SharedPreferences preferences = await prefs;
    var header = {
      HttpHeaders.authorizationHeader: preferences.getString('idToken')!,
      HttpHeaders.accessControlAllowCredentialsHeader: 'TRUE',
      HttpHeaders.accessControlAllowMethodsHeader: 'GET, POST, DELETE, OPTIONS',
      HttpHeaders.accessControlAllowOriginHeader: 'http://localhost:1632/',
      HttpHeaders.accessControlAllowHeadersHeader: 'Content-Type',
      HttpHeaders.accessControlExposeHeadersHeader: 'X-My-Custom-Header',
      HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
    };
    return header;
  }

  Future getHeaderPUT() async {
    final SharedPreferences preferences = await prefs;
    var header = {
      HttpHeaders.authorizationHeader: preferences.getString('idToken')!,
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    return header;
  }

  Future<http.Response> getData(api) async {
    var headerNew = await getHeaderGET();
    String url = config.baseUrl + api;
    // print(url);
    http.Response res = await http.get(
      Uri.parse(url),
      headers: headerNew,
    );
    return res;
  }

  Future<http.Response> getPost(api, body) async {
    String url = config.baseUrl + api;
    // print(url);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headerPost,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<http.Response> getPut(api, body) async {
    var headerNew = await getHeaderPUT();
    String url = config.baseUrl + api;
    // print(url);
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: headerNew,
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
