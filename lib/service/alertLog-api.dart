import 'package:http/http.dart' as http;
import 'package:web_dashboard/config.dart' as config;
import 'api.dart' as api;

Future<http.Response> getAllAlertLogs(page, limit) async {
  http.Response res = await api.HttpService()
      .getData('/api/alert/${config.siteid}/all/$page/$limit');
  return res;
}

Future<http.Response> getUnacknowledgedAlerts(page, limit) async {
  http.Response res = await api.HttpService()
      .getData('/api/alert/${config.siteid}/active/$page/$limit');
  return res;
}

Future<http.Response> getAcknowledgedAlerts(page, limit) async {
  http.Response res = await api.HttpService()
      .getData('/api/alert/${config.siteid}/acknowledge/$page/$limit');
  return res;
}

Future<http.Response> putAcknowledgeAlert(alertId) async {
  Map body = {};
  http.Response res = await api.HttpService().getPut(
    '/api/alert/${config.siteid}/acknowledge/$alertId',
    body,
  );
  return res;
}
