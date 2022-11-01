class RoomTimeSpent {
  String? status;
  String? message;
  List<TimeSpentPerRoom>? data;

  RoomTimeSpent({this.status, this.message, this.data});

  RoomTimeSpent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TimeSpentPerRoom>[];
      json['data'].forEach((v) {
        data!.add(TimeSpentPerRoom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "status": "$status", "message": "$message", "data": $data }';
  }
}

class TimeSpentPerRoom {
  Contractor? contractor;
  int? active;
  int? idle;
  int? away;
  List? overallData;

  TimeSpentPerRoom(
      {this.contractor, this.active, this.idle, this.away, this.overallData});

  TimeSpentPerRoom.fromJson(Map<String, dynamic> json) {
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
    active = json['active'];
    idle = json['idle'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }
    data['active'] = active;
    data['idle'] = idle;
    data['away'] = away;
    return data;
  }

  @override
  String toString() {
    return '{ "contractor": $contractor, "active": $active, "idle": $idle, "away": $away, "overallData": $overallData }';
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
