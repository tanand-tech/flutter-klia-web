class EmployeeTrailLogs {
  String? status;
  String? message;
  List<TrailLogsCleaners>? data;

  EmployeeTrailLogs({this.status, this.message, this.data});

  EmployeeTrailLogs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrailLogsCleaners>[];
      json['data'].forEach((v) {
        data!.add(TrailLogsCleaners.fromJson(v));
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

  @override
  String toString() {
    return '{ "status": $status, "message": $message, "data": $data }';
  }
}

class TrailLogsCleaners {
  EmployeeTL? employee;
  int? timestamp;
  int? endTimestamp;
  String? status;
  RoomTL? room;

  TrailLogsCleaners(
      {this.employee,
      this.timestamp,
      this.endTimestamp,
      this.status,
      this.room});

  TrailLogsCleaners.fromJson(Map<String, dynamic> json) {
    employee =
        json['employee'] != null ? EmployeeTL.fromJson(json['employee']) : null;
    timestamp = json['timestamp'];
    endTimestamp = json['endTimestamp'];
    status = json['status'];
    room = json['room'] != null ? RoomTL.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    data['timestamp'] = timestamp;
    data['endTimestamp'] = endTimestamp;
    data['status'] = status;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "employee": $employee, "timestamp": $timestamp, "endTimestamp": $endTimestamp, "status": $status, "room": $room  }';
  }
}

class EmployeeTL {
  String? id;
  String? employeeId;
  String? name;
  String? beaconId;
  String? identity;
  String? nationality;
  String? designation;
  bool? isMale;
  ContractorTL? contractor;
  bool? blacklisted;

  EmployeeTL(
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

  EmployeeTL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    name = json['name'];
    beaconId = json['beaconId'];
    identity = json['identity'];
    nationality = json['nationality'];
    designation = json['designation'];
    isMale = json['isMale'];
    contractor = json['contractor'] != null
        ? ContractorTL.fromJson(json['contractor'])
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

  @override
  String toString() {
    return '{ "id": $id, "employeeId": $employeeId, "name": $name, "beaconId": $beaconId, "identity": $identity, "nationality": $nationality, "designation": $designation, "isMale": $isMale, "contractor": $contractor, "blacklisted": $blacklisted  }';
  }
}

class ContractorTL {
  String? id;
  String? contractorId;
  String? name;
  String? info;
  String? siteId;

  ContractorTL({this.id, this.contractorId, this.name, this.info, this.siteId});

  ContractorTL.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return '{ "id": $id, "contractorId": $contractorId, "name": $name, "info": $info, "siteId": $siteId }';
  }
}

class RoomTL {
  String? id;
  String? roomId;
  String? name;
  String? info;
  String? locationId;
  int? minEmployee;
  int? maxEmployee;

  RoomTL(
      {this.id,
      this.roomId,
      this.name,
      this.info,
      this.locationId,
      this.minEmployee,
      this.maxEmployee});

  RoomTL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['roomId'];
    name = json['name'];
    info = json['info'];
    locationId = json['locationId'];
    minEmployee = json['minEmployee'];
    maxEmployee = json['maxEmployee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roomId'] = roomId;
    data['name'] = name;
    data['info'] = info;
    data['locationId'] = locationId;
    data['minEmployee'] = minEmployee;
    data['maxEmployee'] = maxEmployee;
    return data;
  }

  @override
  String toString() {
    return '{ "id": $id, "contractorId": $roomId, "name": $name, "info": $info, "siteId": $locationId, "minEmployee": $minEmployee, "maxEmployee": $maxEmployee }';
  }
}
