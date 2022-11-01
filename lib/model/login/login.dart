class Login {
  String? status;
  String? message;
  LoginData? data;

  Login({this.status, this.message, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
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
    return '{ "status": $status,"message": $message,"data": $data }';
  }
}

class LoginData {
  UserDetails? userDetails;
  List<Authorities>? authorities;
  Tokens? tokens;

  LoginData({this.userDetails, this.authorities, this.tokens});

  LoginData.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(Authorities.fromJson(v));
      });
    }
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    if (authorities != null) {
      data['authorities'] = authorities!.map((v) => v.toJson()).toList();
    }
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "userDetails": $userDetails,"authorities": $authorities,"tokens": $tokens }';
  }
}

class UserDetails {
  String? uuid;
  String? name;
  String? email;

  UserDetails({this.uuid, this.name, this.email});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    return '{ "uuid": $uuid,"name": $name,"email": $email }';
  }
}

class Authorities {
  AccessLevel? accessLevel;
  Site? site;

  Authorities({this.accessLevel, this.site});

  Authorities.fromJson(Map<String, dynamic> json) {
    accessLevel = json['accessLevel'] != null
        ? AccessLevel.fromJson(json['accessLevel'])
        : null;
    site = json['site'] != null ? Site.fromJson(json['site']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accessLevel != null) {
      data['accessLevel'] = accessLevel!.toJson();
    }
    if (site != null) {
      data['site'] = site!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{ "accessLevel": $accessLevel,"site": $site }';
  }
}

class AccessLevel {
  int? accessLevel;
  String? name;
  String? description;

  AccessLevel({this.accessLevel, this.name, this.description});

  AccessLevel.fromJson(Map<String, dynamic> json) {
    accessLevel = json['accessLevel'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessLevel'] = accessLevel;
    data['name'] = name;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return '{ "accessLevel": $accessLevel, "name": $name, "description": $description }';
  }
}

class Site {
  String? id;
  String? name;
  String? filename;
  bool? offline;

  Site({this.id, this.name, this.filename, this.offline});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    filename = json['filename'];
    offline = json['offline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['filename'] = filename;
    data['offline'] = offline;
    return data;
  }

  @override
  String toString() {
    return '{ "id": $id, "name": $name, "filename": $filename, "offline":$offline }';
  }
}

class Tokens {
  String? idToken;
  String? accessToken;
  String? refreshToken;

  Tokens({this.idToken, this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idToken'] = idToken;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }

  @override
  String toString() {
    return '{ "idToken": $idToken, "accessToken": $accessToken, "refreshToken": $refreshToken }';
  }
}
