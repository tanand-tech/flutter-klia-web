class EmployeeLatestLog {
  String? status;
  String? message;
  LatestLogData? data;

  EmployeeLatestLog({this.status, this.message, this.data});

  EmployeeLatestLog.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LatestLogData.fromJson(json['data']) : null;
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

class LatestLogData {
  Employee? employee;
  int? timestamp;
  String? status;

  LatestLogData({this.employee, this.timestamp, this.status});

  LatestLogData.fromJson(Map<String, dynamic> json) {
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    data['timestamp'] = timestamp;
    data['status'] = status;
    return data;
  }
}

class Employee {
  String? id;
  String? employeeId;
  String? name;
  String? beaconId;
  String? identity;
  String? nationality;
  String? designation;
  bool? isMale;
  Contractor? contractor;
  bool? blacklisted;

  Employee(
      {this.id,
      this.employeeId,
      this.name,
      this.beaconId,
      this.identity,
      this.nationality,
      this.designation,
      this.isMale,
      this.contractor,
      this.blacklisted});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    name = json['name'];
    beaconId = json['beaconId'];
    identity = json['identity'];
    nationality = json['nationality'];
    designation = json['designation'];
    isMale = json['isMale'];
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
    blacklisted = json['blacklisted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['name'] = name;
    data['beaconId'] = beaconId;
    data['identity'] = identity;
    data['nationality'] = nationality;
    data['designation'] = designation;
    data['isMale'] = isMale;
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }
    data['blacklisted'] = blacklisted;
    return data;
  }
}

class Contractor {
  String? id;
  String? contractorId;
  String? name;
  String? info;
  String? siteId;

  Contractor({this.id, this.contractorId, this.name, this.info, this.siteId});

  Contractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorId = json['contractorId'];
    name = json['name'];
    info = json['info'];
    siteId = json['siteId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contractorId'] = contractorId;
    data['name'] = name;
    data['info'] = info;
    data['siteId'] = siteId;
    return data;
  }
}
