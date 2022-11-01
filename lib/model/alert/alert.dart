class AlertLogs {
  String? status;
  String? message;
  AlertDetails? data;

  AlertLogs({this.status, this.message, this.data});

  AlertLogs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AlertDetails.fromJson(json['data']) : null;
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

class AlertDetails {
  int? total;
  List<Alerts>? alerts;

  AlertDetails({this.total, this.alerts});

  AlertDetails.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) {
        alerts!.add(Alerts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (alerts != null) {
      data['alerts'] = alerts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '{ total: $total, alerts: $alerts }';
  }
}

class Alerts {
  int? id;
  String? type;
  String? roomId;
  String? siteId;
  int? timestamp;
  AcknowledgedBy? acknowledgedBy;
  int? acknowledgedTimestamp;
  String? message;
  String? title;

  Alerts(
      {this.id,
      this.type,
      this.roomId,
      this.siteId,
      this.timestamp,
      this.acknowledgedBy,
      this.acknowledgedTimestamp,
      this.message,
      this.title});

  Alerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    roomId = json['roomId'];
    siteId = json['siteId'];
    timestamp = json['timestamp'];
    acknowledgedBy = json['acknowledgedBy'] != null
        ? AcknowledgedBy.fromJson(json['acknowledgedBy'])
        : null;
    acknowledgedTimestamp = json['acknowledgedTimestamp'];
    message = json['message'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['roomId'] = roomId;
    data['siteId'] = siteId;
    data['timestamp'] = timestamp;
    if (acknowledgedBy != null) {
      data['acknowledgedBy'] = acknowledgedBy!.toJson();
    }
    data['acknowledgedTimestamp'] = acknowledgedTimestamp;
    data['message'] = message;
    data['title'] = title;
    return data;
  }

  @override
  String toString() {
    return '{ id: $id, type: $type, roomId: $roomId, siteId: $siteId, timestamp: $timestamp, message: $message, title: $title }';
  }
}

class AcknowledgedBy {
  String? uuid;
  String? name;
  String? email;

  AcknowledgedBy({this.uuid, this.name, this.email});

  AcknowledgedBy.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['email'] = email;
    return data;
  }

  @override
  String toString() {
    return '{ uuid: $uuid, name: $name, email: $email }';
  }
}
