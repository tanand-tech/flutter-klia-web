class TrailLogsGroup {
  String? status;
  String? message;
  List<DataTG>? data;

  TrailLogsGroup({this.status, this.message, this.data});

  TrailLogsGroup.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataTG>[];
      json['data'].forEach((v) {
        data!.add(DataTG.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '{ $status, $message, $data }';
}

class DataTG {
  String? name;
  String? id;
  String? status;
  String? statusName;
  bool? available;
  bool? online;
  List<TrailLogs>? trailLogs;

  DataTG({this.id, this.status, this.available, this.online, this.trailLogs});

  DataTG.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    available = json['available'];
    online = json['online'];
    if (json['trailLogs'] != null) {
      trailLogs = <TrailLogs>[];
      json['trailLogs'].forEach((v) {
        trailLogs!.add(TrailLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['available'] = this.available;
    data['online'] = this.online;
    if (this.trailLogs != null) {
      data['trailLogs'] = this.trailLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '{ $name, $id, $status, $available }';
}

class TrailLogs {
  Employee? employee;
  Room? room;
  int? timestamp;
  String? status;

  TrailLogs({this.employee, this.room, this.timestamp, this.status});

  TrailLogs.fromJson(Map<String, dynamic> json) {
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() => '{ $employee, $room, $timestamp, $status }';
}

class Employee {
  String? employeeId;
  String? name;
  Contractor? contractor;

  Employee({this.employeeId, this.name, this.contractor});

  Employee.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    name = json['name'];
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['name'] = this.name;
    if (this.contractor != null) {
      data['contractor'] = this.contractor!.toJson();
    }
    return data;
  }

  @override
  String toString() => '{ $employeeId, $name, $contractor }';
}

class Contractor {
  String? id;
  String? contractorId;
  String? name;

  Contractor({this.id, this.contractorId, this.name});

  Contractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorId = json['contractorId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['contractorId'] = this.contractorId;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() => '{ $id, $contractorId, $name }';
}

class Room {
  String? id;

  Room({this.id});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() => '{ $id }';
}
