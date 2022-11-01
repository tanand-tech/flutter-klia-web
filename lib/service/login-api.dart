import 'package:http/http.dart' as http;
import 'api.dart' as api;

Future<http.Response> getLogin(Map body) async {
  http.Response? res = await api.HttpService().getPost(
    '/user/auth/login',
    body,
  );
  return res;
}

Future<http.Response> getRefresh(Map body) async {
  http.Response? res = await api.HttpService().getPost(
    '/user/auth/refresh',
    body,
  );
  return res;
}

Future<http.Response> changePassword(Map body) async {
  http.Response? res = await api.HttpService().getPut(
    '/user/api/change/password',
    body,
  );
  return res;
}

// Future<http.Response> requestPasswordReset(
//     String email, String password, String newPassword) async {
//   http.Response? res = await api.HttpService().getPost(
//     '/user/auth/forgot/password/request/{email}'
//     // email,
//     // password,
//     // newPassword,
//   );
//   return res;
// }

// Future<http.Response> getResetPassword(
//     String email, String password, String newPassword) async {
//   http.Response? res = await api.HttpService().getPost(
//     '/user/auth/forgot/password/reset'
//     // email,
//     // password,
//     // newPassword,
//   );
//   return res;
// }
