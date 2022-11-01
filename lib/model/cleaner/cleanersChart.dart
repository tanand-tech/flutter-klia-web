class CleanersChart {
  String? status;
  String? message;
  List<CleanersChartData>? data;

  CleanersChart({this.status, this.message, this.data});

  CleanersChart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CleanersChartData>[];
      json['data'].forEach((v) {
        data!.add(CleanersChartData.fromJson(v));
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

class CleanersChartData {
  Contractor? contractor;
  int? active;
  int? idle;
  int? away;
  int? total;

  CleanersChartData(
      {this.contractor, this.active, this.idle, this.away, this.total});

  CleanersChartData.fromJson(Map<String, dynamic> json) {
    contractor = json['contractor'] != null
        ? Contractor.fromJson(json['contractor'])
        : null;
    active = json['active'];
    idle = json['idle'];
    away = json['away'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contractor != null) {
      data['contractor'] = contractor!.toJson();
    }
    data['active'] = active;
    data['idle'] = idle;
    data['away'] = away;
    data['total'] = total;
    return data;
  }

  @override
  String toString() {
    return '{ "contractor": $contractor, "active": $active, "idle": $idle, "away": $away, "total": $total }';
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
    return '{ "id": "$id", "contractorId": "$contractorId", "name": "$name", "info": "$info", "siteId": "$siteId" }';
  }
}
