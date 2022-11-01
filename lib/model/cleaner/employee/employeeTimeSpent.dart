class EmployeeTimeSpent {
  String? status;
  String? message;
  List<EmployeeTSData>? data;

  EmployeeTimeSpent({this.status, this.message, this.data});

  EmployeeTimeSpent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EmployeeTSData>[];
      json['data'].forEach((v) {
        data!.add(EmployeeTSData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeTSData {
  String? roomId;
  String? status;
  int? duration;

  EmployeeTSData({this.roomId, this.status, this.duration});

  EmployeeTSData.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    status = json['status'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomId'] = roomId;
    data['status'] = status;
    data['duration'] = duration;
    return data;
  }
}
