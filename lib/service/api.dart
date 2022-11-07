import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/config.dart' as config;

final HttpServieManager = HttpService();
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

class HttpService {
  var isRetryRequest = false;

  // static var authToken =
  //     'eyJraWQiOiJoNVloWEhaWDVDR3ZZNERGN0ppbVFGYXA1NUt6NXYrRjhIZmUyXC9Cd05Vbz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI0NGFjOTc1ZC1jZmM1LTQ1ZDEtYjBkMS00ODg4ODY0NjcyN2EiLCJjb2duaXRvOmdyb3VwcyI6WyJTVVBFUl9BRE1JTiIsIkFETUlOX0tMSUEtMSJdLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb21cL2FwLXNvdXRoZWFzdC0xX0ZCZE9Cd25MWiIsImNvZ25pdG86dXNlcm5hbWUiOiI0NGFjOTc1ZC1jZmM1LTQ1ZDEtYjBkMS00ODg4ODY0NjcyN2EiLCJhdWQiOiI2bTUwMDl1dTdsZ2kxc2sxcXYzMGYxNDZjYyIsImV2ZW50X2lkIjoiNDNkZDQwMmYtN2IyMC00OWE0LWE5ZDMtNDYzOTYwYTZhNGRhIiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2NjYzMjgzMjYsIm5hbWUiOiJVc2VyIiwiZXhwIjoxNjY2MzM5MzQ4LCJpYXQiOjE2NjYzMzU3NDgsImVtYWlsIjoidXNlckB0YW5hbmQuY29tLm15In0.GjNhD-JvU3d_nTt4sZzb1bHxyJdMLA9Jidb98zRMhqeNuOtazKJkY8S_bFbrbSjf3vqWYtA36-57saLGfxsf6pUzkZOhnVPrZk9EPZ9QYTkTfuNJvvApoUwLqDDxSL9UmMRXUZ4pbIODw65Ilfoqz2emXnifonu44dAlJ2tbM79QwKWOzkKsFHBjzUeIa9Lps2JOCIwNHBvfMAHcSFgSaMYgJh-eu_wzpYOZhYeAhYQYcFLvdDR5JX2W8ZJ18c27pqYejIpAf97t_WPqrP9JEGyEUNcdwM65Zh9u7xF1BOEcqOHuqXODxqp1Hko1hDjyM2w1mjKTeeZfXInPsObO8g';

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
    print(url);
    http.Response res = await http.get(
      Uri.parse(url),
      headers: headerNew,
    );
    return res;
  }

  Future<http.Response> getPost(api, body) async {
    String url = config.baseUrl + api;
    print(url);
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
    print(url);
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
