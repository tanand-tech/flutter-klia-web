class OverallLocation {
  String? status;
  String? message;
  String? siteId;
  OverallLocationData? data;

  OverallLocation({this.status, this.message, this.data});

  OverallLocation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? OverallLocationData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "status": "$status", "message": "$message", "siteId": "$siteId", "data": $data}';
  }
}

class OverallLocationData {
  int? normal;
  int? oversupply;
  int? shortage;
  int? unavailable;

  OverallLocationData(
      {this.normal, this.oversupply, this.shortage, this.unavailable});

  OverallLocationData.fromJson(Map<String, dynamic> json) {
    normal = json['normal'];
    oversupply = json['oversupply'];
    shortage = json['shortage'];
    unavailable = json['unavailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['normal'] = normal;
    data['oversupply'] = oversupply;
    data['shortage'] = shortage;
    data['unavailable'] = unavailable;
    return data;
  }

  @override
  String toString() {
    return '{ "normal": $normal,"oversupply": $oversupply,"shortage": $shortage, "unavailable": $unavailable }';
  }
}
