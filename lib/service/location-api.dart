import 'package:http/http.dart' as http;
import 'package:web_dashboard/config.dart' as config;
import 'api.dart' as api;

Future<http.Response> getStatusCount() async {
  http.Response res = await api.HttpService()
      .getData('/api/latest/${config.siteid}/status/count');
  return res;
}

// Cleaners
Future<http.Response> getContractorStatusCount() async {
  http.Response res = await api.HttpService()
      .getData('/api/latest/${config.siteid}/status/count/contractors');
  return res;
}

Future<http.Response> getEmployeeListBySite(int page, int limit) async {
  http.Response res = await api.HttpService()
      .getData('/api/employee/${config.siteid}/list/$page/$limit');
  return res;
}

Future<http.Response> getRoomsStatusCount() async {
  http.Response res = await api.HttpService()
      .getData('/api/latest/${config.siteid}/status/count/rooms');
  return res;
}

Future<http.Response> getRoomsStatusCountByBlock(blockId) async {
  http.Response res = await api.HttpService()
      .getData('/api/latest/${config.siteid}/$blockId/status/count/rooms');
  return res;
}

Future<http.Response> getTrailLogsGroupByRoomsByBlock(blockId) async {
  http.Response res = await api.HttpService()
      .getData('/api/latest/${config.siteid}/$blockId/rooms/trail');
  return res;
}

// Location-service
Future<http.Response> getRoomLatestLog(roomId) async {
  http.Response res = await api.HttpService()
      .getData('/api/latest/${config.siteid}/room/$roomId/availability');
  return res;
}

Future<http.Response> getRoomTrailLogs(roomId, start, end) async {
  http.Response res = await api.HttpService()
      .getData('/api/trail/${config.siteid}/room/trail/$roomId/$start/$end');
  return res;
}

Future<http.Response> getRoomTimeSpent(roomId, start, end) async {
  http.Response res = await api.HttpService().getData(
      '/api/trail/${config.siteid}/room/contractor/trail/summary/$roomId/$start/$end');
  return res;
}

// Cleaner-service
Future<http.Response> getEmployeeLatestLog(employeeId) async {
  http.Response res = await api.HttpService()
      .getData('/api/trail/${config.siteid}/employee/trail/latest/$employeeId');
  return res;
}

Future<http.Response> getEmployeeSummary(employeeId, start, end) async {
  http.Response res = await api.HttpService().getData(
      '/api/trail/${config.siteid}/employee/status/summary/$employeeId/$start/$end');
  return res;
}

Future<http.Response> getEmployeeTrailLogs(employeeId, start, end) async {
  http.Response res = await api.HttpService().getData(
      '/api/trail/${config.siteid}/employee/trail/$employeeId/$start/$end');
  return res;
}

Future<http.Response> getEmployeeTimeSpent(employeeId, start, end) async {
  http.Response res = await api.HttpService().getData(
      '/api/trail/${config.siteid}/employee/status/room/$employeeId/$start/$end');
  return res;
}
