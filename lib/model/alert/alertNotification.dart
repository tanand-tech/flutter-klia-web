class AlertsNotification {
  int? oversupply;
  int? shortage;
  int? longIdle;
  int? total;

  AlertsNotification(
      {this.oversupply, this.shortage, this.longIdle, this.total});

  AlertsNotification.fromJson(Map<String, dynamic> json) {
    oversupply = json['oversupply'];
    shortage = json['shortage'];
    longIdle = json['longIdle'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oversupply'] = oversupply;
    data['shortage'] = shortage;
    data['longIdle'] = longIdle;
    data['total'] = total;
    return data;
  }
}
