class RoomLatestLog {
  String? status;
  String? message;
  RoomLog? data;

  RoomLatestLog({this.status, this.message, this.data});

  RoomLatestLog.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RoomLog.fromJson(json['data']) : null;
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

class RoomLog {
  Room? room;
  Location? location;
  Zone? zone;
  int? timestamp;
  bool? available;

  RoomLog(
      {this.room, this.location, this.zone, this.timestamp, this.available});

  RoomLog.fromJson(Map<String, dynamic> json) {
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;
    timestamp = json['timestamp'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (room != null) {
      data['room'] = room!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
    data['timestamp'] = timestamp;
    data['available'] = available;
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

class Location {
  String? id;
  String? locationId;
  String? name;
  String? info;
  String? zoneId;

  Location({this.id, this.locationId, this.name, this.info, this.zoneId});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['locationId'];
    name = json['name'];
    info = json['info'];
    zoneId = json['zoneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['locationId'] = locationId;
    data['name'] = name;
    data['info'] = info;
    data['zoneId'] = zoneId;
    return data;
  }
}

class Zone {
  String? id;
  String? name;
  String? info;
  String? blockId;

  Zone({this.id, this.name, this.info, this.blockId});

  Zone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    blockId = json['blockId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['info'] = info;
    data['blockId'] = blockId;
    return data;
  }
}
