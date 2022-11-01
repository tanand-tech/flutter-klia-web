class RoomTrailLogs {
  String? status;
  String? message;
  List<TrailLog>? data;

  RoomTrailLogs({this.status, this.message, this.data});

  RoomTrailLogs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrailLog>[];
      json['data'].forEach((v) {
        data!.add(TrailLog.fromJson(v));
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

class TrailLog {
  Employee? employee;
  Room? room;
  int? timestamp;
  int? endTimestamp;
  String? status;

  TrailLog(
      {this.employee,
      this.room,
      this.timestamp,
      this.endTimestamp,
      this.status});

  TrailLog.fromJson(Map<String, dynamic> json) {
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    timestamp = json['timestamp'];
    endTimestamp = json['endTimestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (room != null) {
      data['room'] = room!.toJson();
    }
    data['timestamp'] = timestamp;
    data['endTimestamp'] = endTimestamp;
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

class Room {
  String? id;
  String? roomId;
  String? name;
  String? info;
  String? locationId;
  int? minEmployee;
  int? maxEmployee;

  Room(
      {this.id,
      this.roomId,
      this.name,
      this.info,
      this.locationId,
      this.minEmployee,
      this.maxEmployee});

  Room.fromJson(Map<String, dynamic> json) {
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
}
