class Download2 {
  String? siteId;
  String? name;
  List<Blocks>? blocks;
  List<Zones>? zones;
  List<Locations>? locations;
  List<Rooms>? rooms;
  List<Devices>? device;

  Download2(this.siteId, this.name,
      [this.blocks, this.zones, this.locations, this.rooms, this.device]);

  factory Download2.fromJson(Map<String, dynamic> json) {
    // Check 'blocks' in json
    if (json['blocks'] != null) {
      final Map<String, Blocks> data = <String, Blocks>{};
      json['blocks'].forEach(
        ((key, value) {
          String temp = key;
          data[temp] = Blocks.fromJson(value);
        }),
      );
      List<Blocks> blockList = data.entries.map((e) => e.value).toList();

      // Check 'zones' in json
      if (json['zones'] != null) {
        final Map<String, Zones> data = <String, Zones>{};
        json['zones'].forEach(
          ((key, value) {
            String temp = key;
            data[temp] = Zones.fromJson(value);
          }),
        );
        List<Zones> zoneList = data.entries.map((e) => e.value).toList();

        // Check 'locations' in json
        if (json['locations'] != null) {
          final Map<String, Locations> data = <String, Locations>{};
          json['locations'].forEach(
            ((key, value) {
              String temp = key;
              data[temp] = Locations.fromJson(value);
            }),
          );
          List<Locations> locationList =
              data.entries.map((e) => e.value).toList();

          // Check 'rooms' in json
          if (json['rooms'] != null) {
            final Map<String, Rooms> data = <String, Rooms>{};
            json['rooms'].forEach(
              ((key, value) {
                String temp = key;
                data[temp] = Rooms.fromJson(value);
              }),
            );
            List<Rooms> roomList = data.entries.map((e) => e.value).toList();

            // Check 'devices' in json
            if (json['devices'] != null) {
              final Map<String, Devices> data = <String, Devices>{};
              json['devices'].forEach(
                ((key, value) {
                  String temp = key;
                  data[temp] = Devices.fromJson(value);
                }),
              );
              List<Devices> deviceList =
                  data.entries.map((e) => e.value).toList();

              return Download2(
                json['siteId'] as String,
                json['name'] as String,
                blockList,
                zoneList,
                locationList,
                roomList,
                deviceList,
              );
            }

            return Download2(
              json['siteId'] as String,
              json['name'] as String,
              blockList,
              zoneList,
              locationList,
              roomList,
            );
          }
          return Download2(
            json['siteId'] as String,
            json['name'] as String,
            blockList,
            zoneList,
            locationList,
          );
        }

        return Download2(
          json['siteId'] as String,
          json['name'] as String,
          blockList,
          zoneList,
        );
      }

      return Download2(
        json['siteId'] as String,
        json['name'] as String,
        blockList,
      );
    } else {
      return Download2(
        json['siteId'] as String,
        json['name'] as String,
      );
    }
  }

  @override
  String toString() {
    return '{ $siteId, $name }';
  }
}

class Blocks {
  String? id;
  String? name;
  String? info;
  String? siteId;
  int? order;
  List<String>? zones;
  List<Zones>? zoneList;

  Blocks({this.id, this.name, this.info, this.siteId, this.order, this.zones});

  Blocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'].replaceAll(RegExp(r'[\r\n]+'), ' ');
    siteId = json['siteId'];
    order = json['order'];
    zones = json['zones'].cast<String>();
  }

  @override
  String toString() {
    return '{ $id, $name, $info, $siteId, $order, $zones }';
  }
}

class Zones {
  String? id;
  String? name;
  String? info;
  String? blockId;
  List<String>? locations;
  List<Locations>? locationList;

  Zones({this.id, this.name, this.info, this.blockId, this.locations});

  Zones.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    blockId = json['blockId'];
    locations = json['locations']?.cast<String>();
  }

  @override
  String toString() {
    return '{ $id, $name, $info, $blockId, $locations }';
  }
}

class Locations {
  String? id;
  String? locationId;
  String? name;
  String? info;
  String? zoneId;
  List<String>? rooms;
  List<Rooms>? roomList;

  Locations(
      {this.id,
      this.locationId,
      this.name,
      this.info,
      this.zoneId,
      this.rooms});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['locationId'];
    name = json['name'];
    info = json['info'];
    zoneId = json['zoneId'];
    rooms = json['rooms'].cast<String>();
  }

  @override
  String toString() {
    return '{ $id, $locationId, $name, $info, $zoneId, $rooms , $roomList }';
  }
}

class Rooms {
  String? id;
  String? roomId;
  String? name;
  String? info;
  String? locationId;
  String? locationName;
  int? minEmployee;
  int? maxEmployee;
  bool? available;
  List<String>? deviceIds;
  List<Devices>? deviceList;

  Rooms(
      {this.id,
      this.roomId,
      this.name,
      this.info,
      this.locationId,
      this.minEmployee,
      this.maxEmployee,
      this.available,
      this.deviceIds});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['roomId'];
    name = json['name'];
    info = json['info'];
    locationId = json['locationId'];
    minEmployee = json['minEmployee'];
    maxEmployee = json['maxEmployee'];
    available = json['available'];
    deviceIds = json['deviceIds'].cast<String>();
  }

  @override
  String toString() {
    return '{ $id, $roomId, $name, $info, $locationId, $minEmployee , $minEmployee , $maxEmployee , $available , $deviceIds }';
  }
}

class Devices {
  String? id;
  String? name;
  String? gatewayId;
  String? roomId;

  Devices({this.id, this.name, this.gatewayId, this.roomId});

  Devices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gatewayId = json['gatewayId'];
    roomId = json['roomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gatewayId'] = gatewayId;
    data['roomId'] = roomId;
    return data;
  }

  @override
  String toString() {
    return '{ $id, $name, $gatewayId, $roomId }';
  }
}
