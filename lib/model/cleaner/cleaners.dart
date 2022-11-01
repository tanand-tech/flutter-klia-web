class Cleaners {
  String? status;
  String? message;
  CleanerData? data;

  Cleaners({this.status, this.message, this.data});

  Cleaners.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CleanerData.fromJson(json['data']) : null;
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
}

class CleanerData {
  int? active;
  int? idle;
  int? away;
  int? total;

  CleanerData({this.active, this.idle, this.away, this.total});

  CleanerData.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    idle = json['idle'];
    away = json['away'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['idle'] = idle;
    data['away'] = away;
    data['total'] = total;
    return data;
  }

  @override
  String toString() {
    return '{ "active": $active, "idle": $idle, "away": $away, "total": $total }';
  }
}
