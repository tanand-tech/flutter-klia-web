class EmployeeSite {
  String? status;
  String? message;
  EmployeeDetails? data;

  EmployeeSite({this.status, this.message, this.data});

  EmployeeSite.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? EmployeeDetails.fromJson(json['data']) : null;
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
    return '{ "status": $status, "message": $message , "EmployeeDetails": $data}';
  }
}

class EmployeeDetails {
  int? total;
  List<Employees>? employees;

  EmployeeDetails({this.total, this.employees});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(Employees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (employees != null) {
      data['employees'] = employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "total": $total, "employees": $employees }';
  }
}

class Employees {
  String? id;
  String? employeeId;
  String? name;
  String? beaconId;
  String? identity;
  String? nationality;
  bool? isMale;
  Contractor? contractor;
  String? designation;
  bool? blacklisted;
  int? lastDetected;
  int? createdAt;
  String? status;
  Room? room;

  Employees(
      {this.id,
      this.employeeId,
      this.name,
      this.beaconId,
      this.identity,
      this.nationality,
      this.isMale,
      this.contractor,
      this.designation,
      this.blacklisted,
      this.lastDetected,
      this.createdAt,
      this.status,
      this.room});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    name = json['name'];
    beaconId = json['beaconId'];
    identity = json['identity'];
    nationality = json['nationality'];
    isMale = json['isMale'];
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
    designation = json['designation'];
    blacklisted = json['blacklisted'];
    lastDetected = json['lastDetected'];
    createdAt = json['createdAt'];
    status = json['status'];
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['name'] = name;
    data['beaconId'] = beaconId;
    data['identity'] = identity;
    data['nationality'] = nationality;
    data['isMale'] = isMale;
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }
    data['designation'] = designation;
    data['blacklisted'] = blacklisted;
    data['lastDetected'] = lastDetected;
    data['createdAt'] = createdAt;
    data['status'] = status;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "id": $id, "employeeId": $employeeId , "name": $name , "beaconId": $beaconId , "identity": $identity , "nationality": $nationality , "isMale": $isMale , "contractor": $contractor , "designation": $designation , "blacklisted": $blacklisted , "lastDetected": $lastDetected , "createdAt": $createdAt , "status": $status , "room": $room }';
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

  @override
  String toString() {
    return '{ "id": $id, "contractorId": $contractorId , "name": $name , "info": $info , "siteId": $siteId }';
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

  @override
  String toString() {
    return '{ "id": $id, "roomId": $roomId , "name": $name , "info": $info , "locationId": $locationId , "minEmployee": $minEmployee , "maxEmployee": $maxEmployee }';
  }
}
