class EmployeeSummary {
  String? status;
  String? message;
  EmployeeCleaner? data;

  EmployeeSummary({this.status, this.message, this.data});

  EmployeeSummary.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? EmployeeCleaner.fromJson(json['data']) : null;
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

class EmployeeCleaner {
  EmployeeDetails? employee;
  Contractor? contractor;
  int? active;
  int? idle;
  int? away;

  EmployeeCleaner(
      {this.employee, this.contractor, this.active, this.idle, this.away});

  EmployeeCleaner.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? EmployeeDetails.fromJson(json['employee'])
        : null;
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
    active = json['active'];
    idle = json['idle'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }
    data['active'] = active;
    data['idle'] = idle;
    data['away'] = away;
    return data;
  }
}

class EmployeeDetails {
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

  EmployeeDetails(
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

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
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
