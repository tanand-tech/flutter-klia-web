import 'package:http/http.dart' as http;
import 'package:web_dashboard/config.dart' as config;
import 'api.dart' as api;

Future<http.Response> downloadStaticData() async {
  http.Response res = await api.HttpService()
      .getData('/api/setting/${config.siteid}/static/data/download');
  return res;
}
