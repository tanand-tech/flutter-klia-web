// class Downloads {
//   String? siteId;
//   String? name;
//   Blocks? blocks;
//   Zones? zones;
//   Locations? locations;
//   Rooms? rooms;
//   Devices? devices;

//   Downloads(
//       {this.siteId,
//       this.name,
//       this.blocks,
//       this.zones,
//       this.locations,
//       this.rooms,
//       this.devices});

//   Downloads.fromJson(Map<String, dynamic> json) {
//     siteId = json['siteId'];
//     name = json['name'];
//     if (json['blocks'] != null) {
//       blocks = Blocks.fromJson(json['blocks']);
//     } else {
//       blocks = null;
//     }
//     zones = json['zones'] != null ? Zones.fromJson(json['zones']) : null;
//     locations = json['locations'] != null
//         ? Locations.fromJson(json['locations'])
//         : null;
//     rooms = json['rooms'] != null ? Rooms.fromJson(json['rooms']) : null;
//     devices =
//         json['devices'] != null ? Devices.fromJson(json['devices']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['siteId'] = this.siteId;
//     data['name'] = this.name;
//     if (this.blocks != null) {
//       data['blocks'] = this.blocks!.toJson();
//     }
//     if (this.zones != null) {
//       data['zones'] = this.zones!.toJson();
//     }
//     if (this.locations != null) {
//       data['locations'] = this.locations!.toJson();
//     }
//     if (this.rooms != null) {
//       data['rooms'] = this.rooms!.toJson();
//     }
//     if (this.devices != null) {
//       data['devices'] = this.devices!.toJson();
//     }
//     return data;
//   }
// }

// class Blocks {
//   List<Block>? blockList;
//   Block? klia1Mtb;
//   Block? klia1Cp;
//   Block? klia1Sat;

//   Blocks({this.klia1Mtb, this.klia1Cp, this.klia1Sat, this.blockList});

//   Blocks.fromJson(Map<String, dynamic> json) {
//     // var m = ;
//     // Map<String, dynamic> map;
//     // json.keys[0];
//     // print(json.keys);
//     json.forEach(
//       ((key, value) {
//         // String tempN = key;
//         Block temp = Block.fromJson(json[key]);
//         blockList?.add(temp);
//         print(temp.id);
//       }),
//     );
//     print("The final list will be: $blockList");
//     if (json['klia-1-mtb'] != null) {
//       klia1Mtb = Block.fromJson(json['klia-1-mtb']);
//     } else {
//       klia1Mtb = null;
//     }
//     klia1Cp =
//         json['klia-1-cp'] != null ? Block.fromJson(json['klia-1-cp']) : null;
//     klia1Sat =
//         json['klia-1-sat'] != null ? Block.fromJson(json['klia-1-sat']) : null;
//   }

//   List<Block>? getBlockList() {
//     return blockList;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.klia1Mtb != null) {
//       data['klia-1-mtb'] = this.klia1Mtb!.toJson();
//     }
//     if (this.klia1Cp != null) {
//       data['klia-1-cp'] = this.klia1Cp!.toJson();
//     }
//     if (this.klia1Sat != null) {
//       data['klia-1-sat'] = this.klia1Sat!.toJson();
//     }
//     return data;
//   }
// }

// class Block {
//   String? id;
//   String? name;
//   String? info;
//   String? siteId;
//   int? order;
//   List<String>? zones;

//   Block({this.id, this.name, this.info, this.siteId, this.order, this.zones});

//   Block.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     info = json['info'];
//     siteId = json['siteId'];
//     order = json['order'];
//     zones = json['zones'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['info'] = this.info;
//     data['siteId'] = this.siteId;
//     data['order'] = this.order;
//     data['zones'] = this.zones;
//     return data;
//   }

//   String? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getInfo() {
//     return info;
//   }

//   String? getSiteId() {
//     return siteId;
//   }

//   int? getOrder() {
//     return order;
//   }

//   List<String>? getZones() {
//     return zones;
//   }
// }

// class Zones {
//   ZoneWithoutLocation? zN00010;
//   ZoneWithLocation? zN00011;
//   ZoneWithLocation? zN00005;
//   ZoneWithLocation? zN00006;
//   ZoneWithLocation? zN00007;
//   ZoneWithLocation? zN00008;
//   ZoneWithLocation? zN00001;
//   ZoneWithLocation? zN00012;
//   ZoneWithLocation? zN00002;
//   ZoneWithLocation? zN00013;
//   ZoneWithLocation? zN00003;
//   ZoneWithLocation? zN00014;
//   ZoneWithLocation? zN00004;
//   ZoneWithLocation? zN00009;

//   Zones(
//       {this.zN00010,
//       this.zN00011,
//       this.zN00005,
//       this.zN00006,
//       this.zN00007,
//       this.zN00008,
//       this.zN00001,
//       this.zN00012,
//       this.zN00002,
//       this.zN00013,
//       this.zN00003,
//       this.zN00014,
//       this.zN00004,
//       this.zN00009});

//   Zones.fromJson(Map<String, dynamic> json) {
//     zN00010 = json['ZN-00010'] != null
//         ? ZoneWithoutLocation.fromJson(json['ZN-00010'])
//         : null;
//     zN00011 = json['ZN-00011'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00011'])
//         : null;
//     zN00005 = json['ZN-00005'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00005'])
//         : null;
//     zN00006 = json['ZN-00006'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00006'])
//         : null;
//     zN00007 = json['ZN-00007'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00007'])
//         : null;
//     zN00008 = json['ZN-00008'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00008'])
//         : null;
//     zN00001 = json['ZN-00001'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00001'])
//         : null;
//     zN00012 = json['ZN-00012'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00012'])
//         : null;
//     zN00002 = json['ZN-00002'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00002'])
//         : null;
//     zN00013 = json['ZN-00013'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00013'])
//         : null;
//     zN00003 = json['ZN-00003'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00003'])
//         : null;
//     zN00014 = json['ZN-00014'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00014'])
//         : null;
//     zN00004 = json['ZN-00004'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00004'])
//         : null;
//     zN00009 = json['ZN-00009'] != null
//         ? ZoneWithLocation.fromJson(json['ZN-00009'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.zN00010 != null) {
//       data['ZN-00010'] = this.zN00010!.toJson();
//     }
//     if (this.zN00011 != null) {
//       data['ZN-00011'] = this.zN00011!.toJson();
//     }
//     if (this.zN00005 != null) {
//       data['ZN-00005'] = this.zN00005!.toJson();
//     }
//     if (this.zN00006 != null) {
//       data['ZN-00006'] = this.zN00006!.toJson();
//     }
//     if (this.zN00007 != null) {
//       data['ZN-00007'] = this.zN00007!.toJson();
//     }
//     if (this.zN00008 != null) {
//       data['ZN-00008'] = this.zN00008!.toJson();
//     }
//     if (this.zN00001 != null) {
//       data['ZN-00001'] = this.zN00001!.toJson();
//     }
//     if (this.zN00012 != null) {
//       data['ZN-00012'] = this.zN00012!.toJson();
//     }
//     if (this.zN00002 != null) {
//       data['ZN-00002'] = this.zN00002!.toJson();
//     }
//     if (this.zN00013 != null) {
//       data['ZN-00013'] = this.zN00013!.toJson();
//     }
//     if (this.zN00003 != null) {
//       data['ZN-00003'] = this.zN00003!.toJson();
//     }
//     if (this.zN00014 != null) {
//       data['ZN-00014'] = this.zN00014!.toJson();
//     }
//     if (this.zN00004 != null) {
//       data['ZN-00004'] = this.zN00004!.toJson();
//     }
//     if (this.zN00009 != null) {
//       data['ZN-00009'] = this.zN00009!.toJson();
//     }
//     return data;
//   }
// }

// class ZoneWithoutLocation {
//   String? id;
//   String? name;
//   String? info;
//   String? blockId;

//   ZoneWithoutLocation({this.id, this.name, this.info, this.blockId});

//   ZoneWithoutLocation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     info = json['info'];
//     blockId = json['blockId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['info'] = this.info;
//     data['blockId'] = this.blockId;
//     return data;
//   }

//   String? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getInfo() {
//     return info;
//   }

//   String? getBlockId() {
//     return blockId;
//   }
// }

// class ZoneWithLocation {
//   String? id;
//   String? name;
//   String? info;
//   String? blockId;
//   List<String>? locations;

//   ZoneWithLocation(
//       {this.id, this.name, this.info, this.blockId, this.locations});

//   ZoneWithLocation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     info = json['info'];
//     blockId = json['blockId'];
//     locations = json['locations']?.cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['info'] = this.info;
//     data['blockId'] = this.blockId;
//     data['locations'] = this.locations;
//     return data;
//   }

//   String? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getInfo() {
//     return info;
//   }

//   String? getBlockId() {
//     return blockId;
//   }

//   List<String>? getLocation() {
//     return locations;
//   }
// }

// class Locations {
//   Location? lOC00023;
//   Location? lOC00024;
//   Location? lOC00025;
//   Location? lOC00026;
//   Location? lOC00020;
//   Location? lOC00021;
//   Location? lOC00022;
//   Location? lOC00027;
//   Location? lOC00028;
//   Location? lOC00029;
//   Location? lOC00040;
//   Location? lOC00034;
//   Location? lOC00035;
//   Location? lOC00036;
//   Location? lOC00037;
//   Location? lOC00030;
//   Location? lOC00031;
//   Location? lOC00032;
//   Location? lOC00033;
//   Location? lOC00038;
//   Location? lOC00039;
//   Location? lOC00050;
//   Location? lOC00051;
//   Location? lOC00045;
//   Location? lOC00046;
//   Location? lOC00047;
//   Location? lOC00048;
//   Location? lOC00041;
//   Location? lOC00042;
//   Location? lOC00043;
//   Location? lOC00044;
//   Location? lOC00049;
//   Location? lOC00060;
//   Location? lOC00061;
//   Location? lOC00062;
//   Location? lOC00056;
//   Location? lOC00057;
//   Location? lOC00058;
//   Location? lOC00059;
//   Location? lOC00052;
//   Location? lOC00053;
//   Location? lOC00054;
//   Location? lOC00055;
//   Location? lOC00070;
//   Location? lOC00071;
//   Location? lOC00072;
//   Location? lOC00073;
//   Location? lOC00067;
//   Location? lOC00100;
//   Location? lOC00068;
//   Location? lOC00101;
//   Location? lOC00069;
//   Location? lOC00102;
//   Location? lOC00103;
//   Location? lOC00063;
//   Location? lOC00064;
//   Location? lOC00065;
//   Location? lOC00066;
//   Location? lOC00108;
//   Location? lOC00109;
//   Location? lOC00104;
//   Location? lOC00105;
//   Location? lOC00106;
//   Location? lOC00107;
//   Location? lOC00081;
//   Location? lOC00082;
//   Location? lOC00083;
//   Location? lOC00084;
//   Location? lOC00080;
//   Location? lOC00078;
//   Location? lOC00111;
//   Location? lOC00079;
//   Location? lOC00112;
//   Location? lOC00074;
//   Location? lOC00075;
//   Location? lOC00076;
//   Location? lOC00077;
//   Location? lOC00110;
//   Location? lOC00092;
//   Location? lOC00093;
//   Location? lOC00094;
//   Location? lOC00095;
//   Location? lOC00090;
//   Location? lOC00091;
//   Location? lOC00001;
//   Location? lOC00089;
//   Location? lOC00002;
//   Location? lOC00003;
//   Location? lOC00004;
//   Location? lOC00085;
//   Location? lOC00086;
//   Location? lOC00087;
//   Location? lOC00088;
//   Location? lOC00009;
//   Location? lOC00005;
//   Location? lOC00006;
//   Location? lOC00007;
//   Location? lOC00008;
//   Location? lOC00012;
//   Location? lOC00013;
//   Location? lOC00014;
//   Location? lOC00015;
//   Location? lOC00096;
//   Location? lOC00097;
//   Location? lOC00010;
//   Location? lOC00098;
//   Location? lOC00099;
//   Location? lOC00011;
//   Location? lOC00016;
//   Location? lOC00017;
//   Location? lOC00018;
//   Location? lOC00019;

//   Locations(
//       {this.lOC00023,
//       this.lOC00024,
//       this.lOC00025,
//       this.lOC00026,
//       this.lOC00020,
//       this.lOC00021,
//       this.lOC00022,
//       this.lOC00027,
//       this.lOC00028,
//       this.lOC00029,
//       this.lOC00040,
//       this.lOC00034,
//       this.lOC00035,
//       this.lOC00036,
//       this.lOC00037,
//       this.lOC00030,
//       this.lOC00031,
//       this.lOC00032,
//       this.lOC00033,
//       this.lOC00038,
//       this.lOC00039,
//       this.lOC00050,
//       this.lOC00051,
//       this.lOC00045,
//       this.lOC00046,
//       this.lOC00047,
//       this.lOC00048,
//       this.lOC00041,
//       this.lOC00042,
//       this.lOC00043,
//       this.lOC00044,
//       this.lOC00049,
//       this.lOC00060,
//       this.lOC00061,
//       this.lOC00062,
//       this.lOC00056,
//       this.lOC00057,
//       this.lOC00058,
//       this.lOC00059,
//       this.lOC00052,
//       this.lOC00053,
//       this.lOC00054,
//       this.lOC00055,
//       this.lOC00070,
//       this.lOC00071,
//       this.lOC00072,
//       this.lOC00073,
//       this.lOC00067,
//       this.lOC00100,
//       this.lOC00068,
//       this.lOC00101,
//       this.lOC00069,
//       this.lOC00102,
//       this.lOC00103,
//       this.lOC00063,
//       this.lOC00064,
//       this.lOC00065,
//       this.lOC00066,
//       this.lOC00108,
//       this.lOC00109,
//       this.lOC00104,
//       this.lOC00105,
//       this.lOC00106,
//       this.lOC00107,
//       this.lOC00081,
//       this.lOC00082,
//       this.lOC00083,
//       this.lOC00084,
//       this.lOC00080,
//       this.lOC00078,
//       this.lOC00111,
//       this.lOC00079,
//       this.lOC00112,
//       this.lOC00074,
//       this.lOC00075,
//       this.lOC00076,
//       this.lOC00077,
//       this.lOC00110,
//       this.lOC00092,
//       this.lOC00093,
//       this.lOC00094,
//       this.lOC00095,
//       this.lOC00090,
//       this.lOC00091,
//       this.lOC00001,
//       this.lOC00089,
//       this.lOC00002,
//       this.lOC00003,
//       this.lOC00004,
//       this.lOC00085,
//       this.lOC00086,
//       this.lOC00087,
//       this.lOC00088,
//       this.lOC00009,
//       this.lOC00005,
//       this.lOC00006,
//       this.lOC00007,
//       this.lOC00008,
//       this.lOC00012,
//       this.lOC00013,
//       this.lOC00014,
//       this.lOC00015,
//       this.lOC00096,
//       this.lOC00097,
//       this.lOC00010,
//       this.lOC00098,
//       this.lOC00099,
//       this.lOC00011,
//       this.lOC00016,
//       this.lOC00017,
//       this.lOC00018,
//       this.lOC00019});

//   Locations.fromJson(Map<String, dynamic> json) {
//     lOC00023 =
//         json['LOC-00023'] != null ? Location.fromJson(json['LOC-00023']) : null;
//     lOC00024 =
//         json['LOC-00024'] != null ? Location.fromJson(json['LOC-00024']) : null;
//     lOC00025 =
//         json['LOC-00025'] != null ? Location.fromJson(json['LOC-00025']) : null;
//     lOC00026 =
//         json['LOC-00026'] != null ? Location.fromJson(json['LOC-00026']) : null;
//     lOC00020 =
//         json['LOC-00020'] != null ? Location.fromJson(json['LOC-00020']) : null;
//     lOC00021 =
//         json['LOC-00021'] != null ? Location.fromJson(json['LOC-00021']) : null;
//     lOC00022 =
//         json['LOC-00022'] != null ? Location.fromJson(json['LOC-00022']) : null;
//     lOC00027 =
//         json['LOC-00027'] != null ? Location.fromJson(json['LOC-00027']) : null;
//     lOC00028 =
//         json['LOC-00028'] != null ? Location.fromJson(json['LOC-00028']) : null;
//     lOC00029 =
//         json['LOC-00029'] != null ? Location.fromJson(json['LOC-00029']) : null;
//     lOC00040 =
//         json['LOC-00040'] != null ? Location.fromJson(json['LOC-00040']) : null;
//     lOC00034 =
//         json['LOC-00034'] != null ? Location.fromJson(json['LOC-00034']) : null;
//     lOC00035 =
//         json['LOC-00035'] != null ? Location.fromJson(json['LOC-00035']) : null;
//     lOC00036 =
//         json['LOC-00036'] != null ? Location.fromJson(json['LOC-00036']) : null;
//     lOC00037 =
//         json['LOC-00037'] != null ? Location.fromJson(json['LOC-00037']) : null;
//     lOC00030 =
//         json['LOC-00030'] != null ? Location.fromJson(json['LOC-00030']) : null;
//     lOC00031 =
//         json['LOC-00031'] != null ? Location.fromJson(json['LOC-00031']) : null;
//     lOC00032 =
//         json['LOC-00032'] != null ? Location.fromJson(json['LOC-00032']) : null;
//     lOC00033 =
//         json['LOC-00033'] != null ? Location.fromJson(json['LOC-00033']) : null;
//     lOC00038 =
//         json['LOC-00038'] != null ? Location.fromJson(json['LOC-00038']) : null;
//     lOC00039 =
//         json['LOC-00039'] != null ? Location.fromJson(json['LOC-00039']) : null;
//     lOC00050 =
//         json['LOC-00050'] != null ? Location.fromJson(json['LOC-00050']) : null;
//     lOC00051 =
//         json['LOC-00051'] != null ? Location.fromJson(json['LOC-00051']) : null;
//     lOC00045 =
//         json['LOC-00045'] != null ? Location.fromJson(json['LOC-00045']) : null;
//     lOC00046 =
//         json['LOC-00046'] != null ? Location.fromJson(json['LOC-00046']) : null;
//     lOC00047 =
//         json['LOC-00047'] != null ? Location.fromJson(json['LOC-00047']) : null;
//     lOC00048 =
//         json['LOC-00048'] != null ? Location.fromJson(json['LOC-00048']) : null;
//     lOC00041 =
//         json['LOC-00041'] != null ? Location.fromJson(json['LOC-00041']) : null;
//     lOC00042 =
//         json['LOC-00042'] != null ? Location.fromJson(json['LOC-00042']) : null;
//     lOC00043 =
//         json['LOC-00043'] != null ? Location.fromJson(json['LOC-00043']) : null;
//     lOC00044 =
//         json['LOC-00044'] != null ? Location.fromJson(json['LOC-00044']) : null;
//     lOC00049 =
//         json['LOC-00049'] != null ? Location.fromJson(json['LOC-00049']) : null;
//     lOC00060 =
//         json['LOC-00060'] != null ? Location.fromJson(json['LOC-00060']) : null;
//     lOC00061 =
//         json['LOC-00061'] != null ? Location.fromJson(json['LOC-00061']) : null;
//     lOC00062 =
//         json['LOC-00062'] != null ? Location.fromJson(json['LOC-00062']) : null;
//     lOC00056 =
//         json['LOC-00056'] != null ? Location.fromJson(json['LOC-00056']) : null;
//     lOC00057 =
//         json['LOC-00057'] != null ? Location.fromJson(json['LOC-00057']) : null;
//     lOC00058 =
//         json['LOC-00058'] != null ? Location.fromJson(json['LOC-00058']) : null;
//     lOC00059 =
//         json['LOC-00059'] != null ? Location.fromJson(json['LOC-00059']) : null;
//     lOC00052 =
//         json['LOC-00052'] != null ? Location.fromJson(json['LOC-00052']) : null;
//     lOC00053 =
//         json['LOC-00053'] != null ? Location.fromJson(json['LOC-00053']) : null;
//     lOC00054 =
//         json['LOC-00054'] != null ? Location.fromJson(json['LOC-00054']) : null;
//     lOC00055 =
//         json['LOC-00055'] != null ? Location.fromJson(json['LOC-00055']) : null;
//     lOC00070 =
//         json['LOC-00070'] != null ? Location.fromJson(json['LOC-00070']) : null;
//     lOC00071 =
//         json['LOC-00071'] != null ? Location.fromJson(json['LOC-00071']) : null;
//     lOC00072 =
//         json['LOC-00072'] != null ? Location.fromJson(json['LOC-00072']) : null;
//     lOC00073 =
//         json['LOC-00073'] != null ? Location.fromJson(json['LOC-00073']) : null;
//     lOC00067 =
//         json['LOC-00067'] != null ? Location.fromJson(json['LOC-00067']) : null;
//     lOC00100 =
//         json['LOC-00100'] != null ? Location.fromJson(json['LOC-00100']) : null;
//     lOC00068 =
//         json['LOC-00068'] != null ? Location.fromJson(json['LOC-00068']) : null;
//     lOC00101 =
//         json['LOC-00101'] != null ? Location.fromJson(json['LOC-00101']) : null;
//     lOC00069 =
//         json['LOC-00069'] != null ? Location.fromJson(json['LOC-00069']) : null;
//     lOC00102 =
//         json['LOC-00102'] != null ? Location.fromJson(json['LOC-00102']) : null;
//     lOC00103 =
//         json['LOC-00103'] != null ? Location.fromJson(json['LOC-00103']) : null;
//     lOC00063 =
//         json['LOC-00063'] != null ? Location.fromJson(json['LOC-00063']) : null;
//     lOC00064 =
//         json['LOC-00064'] != null ? Location.fromJson(json['LOC-00064']) : null;
//     lOC00065 =
//         json['LOC-00065'] != null ? Location.fromJson(json['LOC-00065']) : null;
//     lOC00066 =
//         json['LOC-00066'] != null ? Location.fromJson(json['LOC-00066']) : null;
//     lOC00108 =
//         json['LOC-00108'] != null ? Location.fromJson(json['LOC-00108']) : null;
//     lOC00109 =
//         json['LOC-00109'] != null ? Location.fromJson(json['LOC-00109']) : null;
//     lOC00104 =
//         json['LOC-00104'] != null ? Location.fromJson(json['LOC-00104']) : null;
//     lOC00105 =
//         json['LOC-00105'] != null ? Location.fromJson(json['LOC-00105']) : null;
//     lOC00106 =
//         json['LOC-00106'] != null ? Location.fromJson(json['LOC-00106']) : null;
//     lOC00107 =
//         json['LOC-00107'] != null ? Location.fromJson(json['LOC-00107']) : null;
//     lOC00081 =
//         json['LOC-00081'] != null ? Location.fromJson(json['LOC-00081']) : null;
//     lOC00082 =
//         json['LOC-00082'] != null ? Location.fromJson(json['LOC-00082']) : null;
//     lOC00083 =
//         json['LOC-00083'] != null ? Location.fromJson(json['LOC-00083']) : null;
//     lOC00084 =
//         json['LOC-00084'] != null ? Location.fromJson(json['LOC-00084']) : null;
//     lOC00080 =
//         json['LOC-00080'] != null ? Location.fromJson(json['LOC-00080']) : null;
//     lOC00078 =
//         json['LOC-00078'] != null ? Location.fromJson(json['LOC-00078']) : null;
//     lOC00111 =
//         json['LOC-00111'] != null ? Location.fromJson(json['LOC-00111']) : null;
//     lOC00079 =
//         json['LOC-00079'] != null ? Location.fromJson(json['LOC-00079']) : null;
//     lOC00112 =
//         json['LOC-00112'] != null ? Location.fromJson(json['LOC-00112']) : null;
//     lOC00074 =
//         json['LOC-00074'] != null ? Location.fromJson(json['LOC-00074']) : null;
//     lOC00075 =
//         json['LOC-00075'] != null ? Location.fromJson(json['LOC-00075']) : null;
//     lOC00076 =
//         json['LOC-00076'] != null ? Location.fromJson(json['LOC-00076']) : null;
//     lOC00077 =
//         json['LOC-00077'] != null ? Location.fromJson(json['LOC-00077']) : null;
//     lOC00110 =
//         json['LOC-00110'] != null ? Location.fromJson(json['LOC-00110']) : null;
//     lOC00092 =
//         json['LOC-00092'] != null ? Location.fromJson(json['LOC-00092']) : null;
//     lOC00093 =
//         json['LOC-00093'] != null ? Location.fromJson(json['LOC-00093']) : null;
//     lOC00094 =
//         json['LOC-00094'] != null ? Location.fromJson(json['LOC-00094']) : null;
//     lOC00095 =
//         json['LOC-00095'] != null ? Location.fromJson(json['LOC-00095']) : null;
//     lOC00090 =
//         json['LOC-00090'] != null ? Location.fromJson(json['LOC-00090']) : null;
//     lOC00091 =
//         json['LOC-00091'] != null ? Location.fromJson(json['LOC-00091']) : null;
//     lOC00001 =
//         json['LOC-00001'] != null ? Location.fromJson(json['LOC-00001']) : null;
//     lOC00089 =
//         json['LOC-00089'] != null ? Location.fromJson(json['LOC-00089']) : null;
//     lOC00002 =
//         json['LOC-00002'] != null ? Location.fromJson(json['LOC-00002']) : null;
//     lOC00003 =
//         json['LOC-00003'] != null ? Location.fromJson(json['LOC-00003']) : null;
//     lOC00004 =
//         json['LOC-00004'] != null ? Location.fromJson(json['LOC-00004']) : null;
//     lOC00085 =
//         json['LOC-00085'] != null ? Location.fromJson(json['LOC-00085']) : null;
//     lOC00086 =
//         json['LOC-00086'] != null ? Location.fromJson(json['LOC-00086']) : null;
//     lOC00087 =
//         json['LOC-00087'] != null ? Location.fromJson(json['LOC-00087']) : null;
//     lOC00088 =
//         json['LOC-00088'] != null ? Location.fromJson(json['LOC-00088']) : null;
//     lOC00009 =
//         json['LOC-00009'] != null ? Location.fromJson(json['LOC-00009']) : null;
//     lOC00005 =
//         json['LOC-00005'] != null ? Location.fromJson(json['LOC-00005']) : null;
//     lOC00006 =
//         json['LOC-00006'] != null ? Location.fromJson(json['LOC-00006']) : null;
//     lOC00007 =
//         json['LOC-00007'] != null ? Location.fromJson(json['LOC-00007']) : null;
//     lOC00008 =
//         json['LOC-00008'] != null ? Location.fromJson(json['LOC-00008']) : null;
//     lOC00012 =
//         json['LOC-00012'] != null ? Location.fromJson(json['LOC-00012']) : null;
//     lOC00013 =
//         json['LOC-00013'] != null ? Location.fromJson(json['LOC-00013']) : null;
//     lOC00014 =
//         json['LOC-00014'] != null ? Location.fromJson(json['LOC-00014']) : null;
//     lOC00015 =
//         json['LOC-00015'] != null ? Location.fromJson(json['LOC-00015']) : null;
//     lOC00096 =
//         json['LOC-00096'] != null ? Location.fromJson(json['LOC-00096']) : null;
//     lOC00097 =
//         json['LOC-00097'] != null ? Location.fromJson(json['LOC-00097']) : null;
//     lOC00010 =
//         json['LOC-00010'] != null ? Location.fromJson(json['LOC-00010']) : null;
//     lOC00098 =
//         json['LOC-00098'] != null ? Location.fromJson(json['LOC-00098']) : null;
//     lOC00099 =
//         json['LOC-00099'] != null ? Location.fromJson(json['LOC-00099']) : null;
//     lOC00011 =
//         json['LOC-00011'] != null ? Location.fromJson(json['LOC-00011']) : null;
//     lOC00016 =
//         json['LOC-00016'] != null ? Location.fromJson(json['LOC-00016']) : null;
//     lOC00017 =
//         json['LOC-00017'] != null ? Location.fromJson(json['LOC-00017']) : null;
//     lOC00018 =
//         json['LOC-00018'] != null ? Location.fromJson(json['LOC-00018']) : null;
//     lOC00019 =
//         json['LOC-00019'] != null ? Location.fromJson(json['LOC-00019']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.lOC00023 != null) {
//       data['LOC-00023'] = this.lOC00023!.toJson();
//     }
//     if (this.lOC00024 != null) {
//       data['LOC-00024'] = this.lOC00024!.toJson();
//     }
//     if (this.lOC00025 != null) {
//       data['LOC-00025'] = this.lOC00025!.toJson();
//     }
//     if (this.lOC00026 != null) {
//       data['LOC-00026'] = this.lOC00026!.toJson();
//     }
//     if (this.lOC00020 != null) {
//       data['LOC-00020'] = this.lOC00020!.toJson();
//     }
//     if (this.lOC00021 != null) {
//       data['LOC-00021'] = this.lOC00021!.toJson();
//     }
//     if (this.lOC00022 != null) {
//       data['LOC-00022'] = this.lOC00022!.toJson();
//     }
//     if (this.lOC00027 != null) {
//       data['LOC-00027'] = this.lOC00027!.toJson();
//     }
//     if (this.lOC00028 != null) {
//       data['LOC-00028'] = this.lOC00028!.toJson();
//     }
//     if (this.lOC00029 != null) {
//       data['LOC-00029'] = this.lOC00029!.toJson();
//     }
//     if (this.lOC00040 != null) {
//       data['LOC-00040'] = this.lOC00040!.toJson();
//     }
//     if (this.lOC00034 != null) {
//       data['LOC-00034'] = this.lOC00034!.toJson();
//     }
//     if (this.lOC00035 != null) {
//       data['LOC-00035'] = this.lOC00035!.toJson();
//     }
//     if (this.lOC00036 != null) {
//       data['LOC-00036'] = this.lOC00036!.toJson();
//     }
//     if (this.lOC00037 != null) {
//       data['LOC-00037'] = this.lOC00037!.toJson();
//     }
//     if (this.lOC00030 != null) {
//       data['LOC-00030'] = this.lOC00030!.toJson();
//     }
//     if (this.lOC00031 != null) {
//       data['LOC-00031'] = this.lOC00031!.toJson();
//     }
//     if (this.lOC00032 != null) {
//       data['LOC-00032'] = this.lOC00032!.toJson();
//     }
//     if (this.lOC00033 != null) {
//       data['LOC-00033'] = this.lOC00033!.toJson();
//     }
//     if (this.lOC00038 != null) {
//       data['LOC-00038'] = this.lOC00038!.toJson();
//     }
//     if (this.lOC00039 != null) {
//       data['LOC-00039'] = this.lOC00039!.toJson();
//     }
//     if (this.lOC00050 != null) {
//       data['LOC-00050'] = this.lOC00050!.toJson();
//     }
//     if (this.lOC00051 != null) {
//       data['LOC-00051'] = this.lOC00051!.toJson();
//     }
//     if (this.lOC00045 != null) {
//       data['LOC-00045'] = this.lOC00045!.toJson();
//     }
//     if (this.lOC00046 != null) {
//       data['LOC-00046'] = this.lOC00046!.toJson();
//     }
//     if (this.lOC00047 != null) {
//       data['LOC-00047'] = this.lOC00047!.toJson();
//     }
//     if (this.lOC00048 != null) {
//       data['LOC-00048'] = this.lOC00048!.toJson();
//     }
//     if (this.lOC00041 != null) {
//       data['LOC-00041'] = this.lOC00041!.toJson();
//     }
//     if (this.lOC00042 != null) {
//       data['LOC-00042'] = this.lOC00042!.toJson();
//     }
//     if (this.lOC00043 != null) {
//       data['LOC-00043'] = this.lOC00043!.toJson();
//     }
//     if (this.lOC00044 != null) {
//       data['LOC-00044'] = this.lOC00044!.toJson();
//     }
//     if (this.lOC00049 != null) {
//       data['LOC-00049'] = this.lOC00049!.toJson();
//     }
//     if (this.lOC00060 != null) {
//       data['LOC-00060'] = this.lOC00060!.toJson();
//     }
//     if (this.lOC00061 != null) {
//       data['LOC-00061'] = this.lOC00061!.toJson();
//     }
//     if (this.lOC00062 != null) {
//       data['LOC-00062'] = this.lOC00062!.toJson();
//     }
//     if (this.lOC00056 != null) {
//       data['LOC-00056'] = this.lOC00056!.toJson();
//     }
//     if (this.lOC00057 != null) {
//       data['LOC-00057'] = this.lOC00057!.toJson();
//     }
//     if (this.lOC00058 != null) {
//       data['LOC-00058'] = this.lOC00058!.toJson();
//     }
//     if (this.lOC00059 != null) {
//       data['LOC-00059'] = this.lOC00059!.toJson();
//     }
//     if (this.lOC00052 != null) {
//       data['LOC-00052'] = this.lOC00052!.toJson();
//     }
//     if (this.lOC00053 != null) {
//       data['LOC-00053'] = this.lOC00053!.toJson();
//     }
//     if (this.lOC00054 != null) {
//       data['LOC-00054'] = this.lOC00054!.toJson();
//     }
//     if (this.lOC00055 != null) {
//       data['LOC-00055'] = this.lOC00055!.toJson();
//     }
//     if (this.lOC00070 != null) {
//       data['LOC-00070'] = this.lOC00070!.toJson();
//     }
//     if (this.lOC00071 != null) {
//       data['LOC-00071'] = this.lOC00071!.toJson();
//     }
//     if (this.lOC00072 != null) {
//       data['LOC-00072'] = this.lOC00072!.toJson();
//     }
//     if (this.lOC00073 != null) {
//       data['LOC-00073'] = this.lOC00073!.toJson();
//     }
//     if (this.lOC00067 != null) {
//       data['LOC-00067'] = this.lOC00067!.toJson();
//     }
//     if (this.lOC00100 != null) {
//       data['LOC-00100'] = this.lOC00100!.toJson();
//     }
//     if (this.lOC00068 != null) {
//       data['LOC-00068'] = this.lOC00068!.toJson();
//     }
//     if (this.lOC00101 != null) {
//       data['LOC-00101'] = this.lOC00101!.toJson();
//     }
//     if (this.lOC00069 != null) {
//       data['LOC-00069'] = this.lOC00069!.toJson();
//     }
//     if (this.lOC00102 != null) {
//       data['LOC-00102'] = this.lOC00102!.toJson();
//     }
//     if (this.lOC00103 != null) {
//       data['LOC-00103'] = this.lOC00103!.toJson();
//     }
//     if (this.lOC00063 != null) {
//       data['LOC-00063'] = this.lOC00063!.toJson();
//     }
//     if (this.lOC00064 != null) {
//       data['LOC-00064'] = this.lOC00064!.toJson();
//     }
//     if (this.lOC00065 != null) {
//       data['LOC-00065'] = this.lOC00065!.toJson();
//     }
//     if (this.lOC00066 != null) {
//       data['LOC-00066'] = this.lOC00066!.toJson();
//     }
//     if (this.lOC00108 != null) {
//       data['LOC-00108'] = this.lOC00108!.toJson();
//     }
//     if (this.lOC00109 != null) {
//       data['LOC-00109'] = this.lOC00109!.toJson();
//     }
//     if (this.lOC00104 != null) {
//       data['LOC-00104'] = this.lOC00104!.toJson();
//     }
//     if (this.lOC00105 != null) {
//       data['LOC-00105'] = this.lOC00105!.toJson();
//     }
//     if (this.lOC00106 != null) {
//       data['LOC-00106'] = this.lOC00106!.toJson();
//     }
//     if (this.lOC00107 != null) {
//       data['LOC-00107'] = this.lOC00107!.toJson();
//     }
//     if (this.lOC00081 != null) {
//       data['LOC-00081'] = this.lOC00081!.toJson();
//     }
//     if (this.lOC00082 != null) {
//       data['LOC-00082'] = this.lOC00082!.toJson();
//     }
//     if (this.lOC00083 != null) {
//       data['LOC-00083'] = this.lOC00083!.toJson();
//     }
//     if (this.lOC00084 != null) {
//       data['LOC-00084'] = this.lOC00084!.toJson();
//     }
//     if (this.lOC00080 != null) {
//       data['LOC-00080'] = this.lOC00080!.toJson();
//     }
//     if (this.lOC00078 != null) {
//       data['LOC-00078'] = this.lOC00078!.toJson();
//     }
//     if (this.lOC00111 != null) {
//       data['LOC-00111'] = this.lOC00111!.toJson();
//     }
//     if (this.lOC00079 != null) {
//       data['LOC-00079'] = this.lOC00079!.toJson();
//     }
//     if (this.lOC00112 != null) {
//       data['LOC-00112'] = this.lOC00112!.toJson();
//     }
//     if (this.lOC00074 != null) {
//       data['LOC-00074'] = this.lOC00074!.toJson();
//     }
//     if (this.lOC00075 != null) {
//       data['LOC-00075'] = this.lOC00075!.toJson();
//     }
//     if (this.lOC00076 != null) {
//       data['LOC-00076'] = this.lOC00076!.toJson();
//     }
//     if (this.lOC00077 != null) {
//       data['LOC-00077'] = this.lOC00077!.toJson();
//     }
//     if (this.lOC00110 != null) {
//       data['LOC-00110'] = this.lOC00110!.toJson();
//     }
//     if (this.lOC00092 != null) {
//       data['LOC-00092'] = this.lOC00092!.toJson();
//     }
//     if (this.lOC00093 != null) {
//       data['LOC-00093'] = this.lOC00093!.toJson();
//     }
//     if (this.lOC00094 != null) {
//       data['LOC-00094'] = this.lOC00094!.toJson();
//     }
//     if (this.lOC00095 != null) {
//       data['LOC-00095'] = this.lOC00095!.toJson();
//     }
//     if (this.lOC00090 != null) {
//       data['LOC-00090'] = this.lOC00090!.toJson();
//     }
//     if (this.lOC00091 != null) {
//       data['LOC-00091'] = this.lOC00091!.toJson();
//     }
//     if (this.lOC00001 != null) {
//       data['LOC-00001'] = this.lOC00001!.toJson();
//     }
//     if (this.lOC00089 != null) {
//       data['LOC-00089'] = this.lOC00089!.toJson();
//     }
//     if (this.lOC00002 != null) {
//       data['LOC-00002'] = this.lOC00002!.toJson();
//     }
//     if (this.lOC00003 != null) {
//       data['LOC-00003'] = this.lOC00003!.toJson();
//     }
//     if (this.lOC00004 != null) {
//       data['LOC-00004'] = this.lOC00004!.toJson();
//     }
//     if (this.lOC00085 != null) {
//       data['LOC-00085'] = this.lOC00085!.toJson();
//     }
//     if (this.lOC00086 != null) {
//       data['LOC-00086'] = this.lOC00086!.toJson();
//     }
//     if (this.lOC00087 != null) {
//       data['LOC-00087'] = this.lOC00087!.toJson();
//     }
//     if (this.lOC00088 != null) {
//       data['LOC-00088'] = this.lOC00088!.toJson();
//     }
//     if (this.lOC00009 != null) {
//       data['LOC-00009'] = this.lOC00009!.toJson();
//     }
//     if (this.lOC00005 != null) {
//       data['LOC-00005'] = this.lOC00005!.toJson();
//     }
//     if (this.lOC00006 != null) {
//       data['LOC-00006'] = this.lOC00006!.toJson();
//     }
//     if (this.lOC00007 != null) {
//       data['LOC-00007'] = this.lOC00007!.toJson();
//     }
//     if (this.lOC00008 != null) {
//       data['LOC-00008'] = this.lOC00008!.toJson();
//     }
//     if (this.lOC00012 != null) {
//       data['LOC-00012'] = this.lOC00012!.toJson();
//     }
//     if (this.lOC00013 != null) {
//       data['LOC-00013'] = this.lOC00013!.toJson();
//     }
//     if (this.lOC00014 != null) {
//       data['LOC-00014'] = this.lOC00014!.toJson();
//     }
//     if (this.lOC00015 != null) {
//       data['LOC-00015'] = this.lOC00015!.toJson();
//     }
//     if (this.lOC00096 != null) {
//       data['LOC-00096'] = this.lOC00096!.toJson();
//     }
//     if (this.lOC00097 != null) {
//       data['LOC-00097'] = this.lOC00097!.toJson();
//     }
//     if (this.lOC00010 != null) {
//       data['LOC-00010'] = this.lOC00010!.toJson();
//     }
//     if (this.lOC00098 != null) {
//       data['LOC-00098'] = this.lOC00098!.toJson();
//     }
//     if (this.lOC00099 != null) {
//       data['LOC-00099'] = this.lOC00099!.toJson();
//     }
//     if (this.lOC00011 != null) {
//       data['LOC-00011'] = this.lOC00011!.toJson();
//     }
//     if (this.lOC00016 != null) {
//       data['LOC-00016'] = this.lOC00016!.toJson();
//     }
//     if (this.lOC00017 != null) {
//       data['LOC-00017'] = this.lOC00017!.toJson();
//     }
//     if (this.lOC00018 != null) {
//       data['LOC-00018'] = this.lOC00018!.toJson();
//     }
//     if (this.lOC00019 != null) {
//       data['LOC-00019'] = this.lOC00019!.toJson();
//     }
//     return data;
//   }
// }

// class Location {
//   String? id;
//   String? locationId;
//   String? name;
//   String? info;
//   String? zoneId;
//   List<String>? rooms;

//   Location(
//       {this.id,
//       this.locationId,
//       this.name,
//       this.info,
//       this.zoneId,
//       this.rooms});

//   Location.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     locationId = json['locationId'];
//     name = json['name'];
//     info = json['info'];
//     zoneId = json['zoneId'];
//     rooms = json['rooms'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['locationId'] = this.locationId;
//     data['name'] = this.name;
//     data['info'] = this.info;
//     data['zoneId'] = this.zoneId;
//     data['rooms'] = this.rooms;
//     return data;
//   }

//   String? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getInfo() {
//     return info;
//   }

//   String? getZoneId() {
//     return zoneId;
//   }

//   List<String>? getRooms() {
//     return rooms;
//   }
// }

// class Rooms {
//   Room? rM00069;
//   Room? rM00068;
//   Room? rM00189;
//   Room? rM00070;
//   Room? rM00191;
//   Room? rM00190;
//   Room? rM00076;
//   Room? rM00197;
//   Room? rM00075;
//   Room? rM00196;
//   Room? rM00078;
//   Room? rM00199;
//   Room? rM00077;
//   Room? rM00198;
//   Room? rM00072;
//   Room? rM00193;
//   Room? rM00071;
//   Room? rM00192;
//   Room? rM00074;
//   Room? rM00195;
//   Room? rM00073;
//   Room? rM00194;
//   Room? rM00058;
//   Room? rM00179;
//   Room? rM00057;
//   Room? rM00178;
//   Room? rM00059;
//   Room? rM00180;
//   Room? rM00065;
//   Room? rM00186;
//   Room? rM00064;
//   Room? rM00185;
//   Room? rM00067;
//   Room? rM00188;
//   Room? rM00066;
//   Room? rM00187;
//   Room? rM00061;
//   Room? rM00182;
//   Room? rM00060;
//   Room? rM00181;
//   Room? rM00063;
//   Room? rM00184;
//   Room? rM00062;
//   Room? rM00183;
//   Room? rM00047;
//   Room? rM00168;
//   Room? rM00046;
//   Room? rM00167;
//   Room? rM00049;
//   Room? rM00048;
//   Room? rM00169;
//   Room? rM00054;
//   Room? rM00175;
//   Room? rM00053;
//   Room? rM00174;
//   Room? rM00056;
//   Room? rM00177;
//   Room? rM00055;
//   Room? rM00176;
//   Room? rM00050;
//   Room? rM00171;
//   Room? rM00170;
//   Room? rM00052;
//   Room? rM00173;
//   Room? rM00051;
//   Room? rM00172;
//   Room? rM00039;
//   Room? rM00157;
//   Room? rM00036;
//   Room? rM00156;
//   Room? rM00035;
//   Room? rM00159;
//   Room? rM00038;
//   Room? rM00158;
//   Room? rM00037;
//   Room? rM00043;
//   Room? rM00164;
//   Room? rM00042;
//   Room? rM00163;
//   Room? rM00045;
//   Room? rM00166;
//   Room? rM00044;
//   Room? rM00165;
//   Room? rM00160;
//   Room? rM00041;
//   Room? rM00162;
//   Room? rM00040;
//   Room? rM00161;
//   Room? rM00029;
//   Room? rM00149;
//   Room? rM00028;
//   Room? rM00146;
//   Room? rM00025;
//   Room? rM00145;
//   Room? rM00024;
//   Room? rM00148;
//   Room? rM00027;
//   Room? rM00147;
//   Room? rM00026;
//   Room? rM00153;
//   Room? rM00032;
//   Room? rM00152;
//   Room? rM00031;
//   Room? rM00155;
//   Room? rM00034;
//   Room? rM00154;
//   Room? rM00033;
//   Room? rM00151;
//   Room? rM00030;
//   Room? rM00150;
//   Room? rM00139;
//   Room? rM00018;
//   Room? rM00138;
//   Room? rM00017;
//   Room? rM00019;
//   Room? rM00135;
//   Room? rM00014;
//   Room? rM00134;
//   Room? rM00013;
//   Room? rM00137;
//   Room? rM00016;
//   Room? rM00136;
//   Room? rM00015;
//   Room? rM00142;
//   Room? rM00021;
//   Room? rM00141;
//   Room? rM00020;
//   Room? rM00144;
//   Room? rM00023;
//   Room? rM00143;
//   Room? rM00022;
//   Room? rM00140;
//   Room? rM00128;
//   Room? rM00007;
//   Room? rM00127;
//   Room? rM00006;
//   Room? rM00009;
//   Room? rM00129;
//   Room? rM00008;
//   Room? rM00124;
//   Room? rM00003;
//   Room? rM00123;
//   Room? rM00002;
//   Room? rM00126;
//   Room? rM00005;
//   Room? rM00125;
//   Room? rM00004;
//   Room? rM00131;
//   Room? rM00010;
//   Room? rM00130;
//   Room? rM00133;
//   Room? rM00012;
//   Room? rM00132;
//   Room? rM00011;
//   Room? rM00117;
//   Room? rM00116;
//   Room? rM00119;
//   Room? rM00118;
//   Room? rM00113;
//   Room? rM00112;
//   Room? rM00115;
//   Room? rM00114;
//   Room? rM00120;
//   Room? rM00122;
//   Room? rM00001;
//   Room? rM00121;
//   Room? rM00106;
//   Room? rM00105;
//   Room? rM00108;
//   Room? rM00107;
//   Room? rM00102;
//   Room? rM00101;
//   Room? rM00104;
//   Room? rM00103;
//   Room? rM00109;
//   Room? rM00111;
//   Room? rM00110;
//   Room? rM00100;
//   Room? rM00205;
//   Room? rM00204;
//   Room? rM00207;
//   Room? rM00206;
//   Room? rM00201;
//   Room? rM00200;
//   Room? rM00203;
//   Room? rM00202;
//   Room? rM00209;
//   Room? rM00208;
//   Room? rM00090;
//   Room? rM00092;
//   Room? rM00091;
//   Room? rM00098;
//   Room? rM00097;
//   Room? rM00099;
//   Room? rM00094;
//   Room? rM00093;
//   Room? rM00096;
//   Room? rM00095;
//   Room? rM00079;
//   Room? rM00081;
//   Room? rM00080;
//   Room? rM00087;
//   Room? rM00086;
//   Room? rM00089;
//   Room? rM00088;
//   Room? rM00083;
//   Room? rM00082;
//   Room? rM00085;
//   Room? rM00084;

//   Rooms(
//       {this.rM00069,
//       this.rM00068,
//       this.rM00189,
//       this.rM00070,
//       this.rM00191,
//       this.rM00190,
//       this.rM00076,
//       this.rM00197,
//       this.rM00075,
//       this.rM00196,
//       this.rM00078,
//       this.rM00199,
//       this.rM00077,
//       this.rM00198,
//       this.rM00072,
//       this.rM00193,
//       this.rM00071,
//       this.rM00192,
//       this.rM00074,
//       this.rM00195,
//       this.rM00073,
//       this.rM00194,
//       this.rM00058,
//       this.rM00179,
//       this.rM00057,
//       this.rM00178,
//       this.rM00059,
//       this.rM00180,
//       this.rM00065,
//       this.rM00186,
//       this.rM00064,
//       this.rM00185,
//       this.rM00067,
//       this.rM00188,
//       this.rM00066,
//       this.rM00187,
//       this.rM00061,
//       this.rM00182,
//       this.rM00060,
//       this.rM00181,
//       this.rM00063,
//       this.rM00184,
//       this.rM00062,
//       this.rM00183,
//       this.rM00047,
//       this.rM00168,
//       this.rM00046,
//       this.rM00167,
//       this.rM00049,
//       this.rM00048,
//       this.rM00169,
//       this.rM00054,
//       this.rM00175,
//       this.rM00053,
//       this.rM00174,
//       this.rM00056,
//       this.rM00177,
//       this.rM00055,
//       this.rM00176,
//       this.rM00050,
//       this.rM00171,
//       this.rM00170,
//       this.rM00052,
//       this.rM00173,
//       this.rM00051,
//       this.rM00172,
//       this.rM00039,
//       this.rM00157,
//       this.rM00036,
//       this.rM00156,
//       this.rM00035,
//       this.rM00159,
//       this.rM00038,
//       this.rM00158,
//       this.rM00037,
//       this.rM00043,
//       this.rM00164,
//       this.rM00042,
//       this.rM00163,
//       this.rM00045,
//       this.rM00166,
//       this.rM00044,
//       this.rM00165,
//       this.rM00160,
//       this.rM00041,
//       this.rM00162,
//       this.rM00040,
//       this.rM00161,
//       this.rM00029,
//       this.rM00149,
//       this.rM00028,
//       this.rM00146,
//       this.rM00025,
//       this.rM00145,
//       this.rM00024,
//       this.rM00148,
//       this.rM00027,
//       this.rM00147,
//       this.rM00026,
//       this.rM00153,
//       this.rM00032,
//       this.rM00152,
//       this.rM00031,
//       this.rM00155,
//       this.rM00034,
//       this.rM00154,
//       this.rM00033,
//       this.rM00151,
//       this.rM00030,
//       this.rM00150,
//       this.rM00139,
//       this.rM00018,
//       this.rM00138,
//       this.rM00017,
//       this.rM00019,
//       this.rM00135,
//       this.rM00014,
//       this.rM00134,
//       this.rM00013,
//       this.rM00137,
//       this.rM00016,
//       this.rM00136,
//       this.rM00015,
//       this.rM00142,
//       this.rM00021,
//       this.rM00141,
//       this.rM00020,
//       this.rM00144,
//       this.rM00023,
//       this.rM00143,
//       this.rM00022,
//       this.rM00140,
//       this.rM00128,
//       this.rM00007,
//       this.rM00127,
//       this.rM00006,
//       this.rM00009,
//       this.rM00129,
//       this.rM00008,
//       this.rM00124,
//       this.rM00003,
//       this.rM00123,
//       this.rM00002,
//       this.rM00126,
//       this.rM00005,
//       this.rM00125,
//       this.rM00004,
//       this.rM00131,
//       this.rM00010,
//       this.rM00130,
//       this.rM00133,
//       this.rM00012,
//       this.rM00132,
//       this.rM00011,
//       this.rM00117,
//       this.rM00116,
//       this.rM00119,
//       this.rM00118,
//       this.rM00113,
//       this.rM00112,
//       this.rM00115,
//       this.rM00114,
//       this.rM00120,
//       this.rM00122,
//       this.rM00001,
//       this.rM00121,
//       this.rM00106,
//       this.rM00105,
//       this.rM00108,
//       this.rM00107,
//       this.rM00102,
//       this.rM00101,
//       this.rM00104,
//       this.rM00103,
//       this.rM00109,
//       this.rM00111,
//       this.rM00110,
//       this.rM00100,
//       this.rM00205,
//       this.rM00204,
//       this.rM00207,
//       this.rM00206,
//       this.rM00201,
//       this.rM00200,
//       this.rM00203,
//       this.rM00202,
//       this.rM00209,
//       this.rM00208,
//       this.rM00090,
//       this.rM00092,
//       this.rM00091,
//       this.rM00098,
//       this.rM00097,
//       this.rM00099,
//       this.rM00094,
//       this.rM00093,
//       this.rM00096,
//       this.rM00095,
//       this.rM00079,
//       this.rM00081,
//       this.rM00080,
//       this.rM00087,
//       this.rM00086,
//       this.rM00089,
//       this.rM00088,
//       this.rM00083,
//       this.rM00082,
//       this.rM00085,
//       this.rM00084});

//   Rooms.fromJson(Map<String, dynamic> json) {
//     rM00069 = json['RM-00069'] != null ? Room.fromJson(json['RM-00069']) : null;
//     rM00068 = json['RM-00068'] != null ? Room.fromJson(json['RM-00068']) : null;
//     rM00189 = json['RM-00189'] != null ? Room.fromJson(json['RM-00189']) : null;
//     rM00070 = json['RM-00070'] != null ? Room.fromJson(json['RM-00070']) : null;
//     rM00191 = json['RM-00191'] != null ? Room.fromJson(json['RM-00191']) : null;
//     rM00190 = json['RM-00190'] != null ? Room.fromJson(json['RM-00190']) : null;
//     rM00076 = json['RM-00076'] != null ? Room.fromJson(json['RM-00076']) : null;
//     rM00197 = json['RM-00197'] != null ? Room.fromJson(json['RM-00197']) : null;
//     rM00075 = json['RM-00075'] != null ? Room.fromJson(json['RM-00075']) : null;
//     rM00196 = json['RM-00196'] != null ? Room.fromJson(json['RM-00196']) : null;
//     rM00078 = json['RM-00078'] != null ? Room.fromJson(json['RM-00078']) : null;
//     rM00199 = json['RM-00199'] != null ? Room.fromJson(json['RM-00199']) : null;
//     rM00077 = json['RM-00077'] != null ? Room.fromJson(json['RM-00077']) : null;
//     rM00198 = json['RM-00198'] != null ? Room.fromJson(json['RM-00198']) : null;
//     rM00072 = json['RM-00072'] != null ? Room.fromJson(json['RM-00072']) : null;
//     rM00193 = json['RM-00193'] != null ? Room.fromJson(json['RM-00193']) : null;
//     rM00071 = json['RM-00071'] != null ? Room.fromJson(json['RM-00071']) : null;
//     rM00192 = json['RM-00192'] != null ? Room.fromJson(json['RM-00192']) : null;
//     rM00074 = json['RM-00074'] != null ? Room.fromJson(json['RM-00074']) : null;
//     rM00195 = json['RM-00195'] != null ? Room.fromJson(json['RM-00195']) : null;
//     rM00073 = json['RM-00073'] != null ? Room.fromJson(json['RM-00073']) : null;
//     rM00194 = json['RM-00194'] != null ? Room.fromJson(json['RM-00194']) : null;
//     rM00058 = json['RM-00058'] != null ? Room.fromJson(json['RM-00058']) : null;
//     rM00179 = json['RM-00179'] != null ? Room.fromJson(json['RM-00179']) : null;
//     rM00057 = json['RM-00057'] != null ? Room.fromJson(json['RM-00057']) : null;
//     rM00178 = json['RM-00178'] != null ? Room.fromJson(json['RM-00178']) : null;
//     rM00059 = json['RM-00059'] != null ? Room.fromJson(json['RM-00059']) : null;
//     rM00180 = json['RM-00180'] != null ? Room.fromJson(json['RM-00180']) : null;
//     rM00065 = json['RM-00065'] != null ? Room.fromJson(json['RM-00065']) : null;
//     rM00186 = json['RM-00186'] != null ? Room.fromJson(json['RM-00186']) : null;
//     rM00064 = json['RM-00064'] != null ? Room.fromJson(json['RM-00064']) : null;
//     rM00185 = json['RM-00185'] != null ? Room.fromJson(json['RM-00185']) : null;
//     rM00067 = json['RM-00067'] != null ? Room.fromJson(json['RM-00067']) : null;
//     rM00188 = json['RM-00188'] != null ? Room.fromJson(json['RM-00188']) : null;
//     rM00066 = json['RM-00066'] != null ? Room.fromJson(json['RM-00066']) : null;
//     rM00187 = json['RM-00187'] != null ? Room.fromJson(json['RM-00187']) : null;
//     rM00061 = json['RM-00061'] != null ? Room.fromJson(json['RM-00061']) : null;
//     rM00182 = json['RM-00182'] != null ? Room.fromJson(json['RM-00182']) : null;
//     rM00060 = json['RM-00060'] != null ? Room.fromJson(json['RM-00060']) : null;
//     rM00181 = json['RM-00181'] != null ? Room.fromJson(json['RM-00181']) : null;
//     rM00063 = json['RM-00063'] != null ? Room.fromJson(json['RM-00063']) : null;
//     rM00184 = json['RM-00184'] != null ? Room.fromJson(json['RM-00184']) : null;
//     rM00062 = json['RM-00062'] != null ? Room.fromJson(json['RM-00062']) : null;
//     rM00183 = json['RM-00183'] != null ? Room.fromJson(json['RM-00183']) : null;
//     rM00047 = json['RM-00047'] != null ? Room.fromJson(json['RM-00047']) : null;
//     rM00168 = json['RM-00168'] != null ? Room.fromJson(json['RM-00168']) : null;
//     rM00046 = json['RM-00046'] != null ? Room.fromJson(json['RM-00046']) : null;
//     rM00167 = json['RM-00167'] != null ? Room.fromJson(json['RM-00167']) : null;
//     rM00049 = json['RM-00049'] != null ? Room.fromJson(json['RM-00049']) : null;
//     rM00048 = json['RM-00048'] != null ? Room.fromJson(json['RM-00048']) : null;
//     rM00169 = json['RM-00169'] != null ? Room.fromJson(json['RM-00169']) : null;
//     rM00054 = json['RM-00054'] != null ? Room.fromJson(json['RM-00054']) : null;
//     rM00175 = json['RM-00175'] != null ? Room.fromJson(json['RM-00175']) : null;
//     rM00053 = json['RM-00053'] != null ? Room.fromJson(json['RM-00053']) : null;
//     rM00174 = json['RM-00174'] != null ? Room.fromJson(json['RM-00174']) : null;
//     rM00056 = json['RM-00056'] != null ? Room.fromJson(json['RM-00056']) : null;
//     rM00177 = json['RM-00177'] != null ? Room.fromJson(json['RM-00177']) : null;
//     rM00055 = json['RM-00055'] != null ? Room.fromJson(json['RM-00055']) : null;
//     rM00176 = json['RM-00176'] != null ? Room.fromJson(json['RM-00176']) : null;
//     rM00050 = json['RM-00050'] != null ? Room.fromJson(json['RM-00050']) : null;
//     rM00171 = json['RM-00171'] != null ? Room.fromJson(json['RM-00171']) : null;
//     rM00170 = json['RM-00170'] != null ? Room.fromJson(json['RM-00170']) : null;
//     rM00052 = json['RM-00052'] != null ? Room.fromJson(json['RM-00052']) : null;
//     rM00173 = json['RM-00173'] != null ? Room.fromJson(json['RM-00173']) : null;
//     rM00051 = json['RM-00051'] != null ? Room.fromJson(json['RM-00051']) : null;
//     rM00172 = json['RM-00172'] != null ? Room.fromJson(json['RM-00172']) : null;
//     rM00039 = json['RM-00039'] != null ? Room.fromJson(json['RM-00039']) : null;
//     rM00157 = json['RM-00157'] != null ? Room.fromJson(json['RM-00157']) : null;
//     rM00036 = json['RM-00036'] != null ? Room.fromJson(json['RM-00036']) : null;
//     rM00156 = json['RM-00156'] != null ? Room.fromJson(json['RM-00156']) : null;
//     rM00035 = json['RM-00035'] != null ? Room.fromJson(json['RM-00035']) : null;
//     rM00159 = json['RM-00159'] != null ? Room.fromJson(json['RM-00159']) : null;
//     rM00038 = json['RM-00038'] != null ? Room.fromJson(json['RM-00038']) : null;
//     rM00158 = json['RM-00158'] != null ? Room.fromJson(json['RM-00158']) : null;
//     rM00037 = json['RM-00037'] != null ? Room.fromJson(json['RM-00037']) : null;
//     rM00043 = json['RM-00043'] != null ? Room.fromJson(json['RM-00043']) : null;
//     rM00164 = json['RM-00164'] != null ? Room.fromJson(json['RM-00164']) : null;
//     rM00042 = json['RM-00042'] != null ? Room.fromJson(json['RM-00042']) : null;
//     rM00163 = json['RM-00163'] != null ? Room.fromJson(json['RM-00163']) : null;
//     rM00045 = json['RM-00045'] != null ? Room.fromJson(json['RM-00045']) : null;
//     rM00166 = json['RM-00166'] != null ? Room.fromJson(json['RM-00166']) : null;
//     rM00044 = json['RM-00044'] != null ? Room.fromJson(json['RM-00044']) : null;
//     rM00165 = json['RM-00165'] != null ? Room.fromJson(json['RM-00165']) : null;
//     rM00160 = json['RM-00160'] != null ? Room.fromJson(json['RM-00160']) : null;
//     rM00041 = json['RM-00041'] != null ? Room.fromJson(json['RM-00041']) : null;
//     rM00162 = json['RM-00162'] != null ? Room.fromJson(json['RM-00162']) : null;
//     rM00040 = json['RM-00040'] != null ? Room.fromJson(json['RM-00040']) : null;
//     rM00161 = json['RM-00161'] != null ? Room.fromJson(json['RM-00161']) : null;
//     rM00029 = json['RM-00029'] != null ? Room.fromJson(json['RM-00029']) : null;
//     rM00149 = json['RM-00149'] != null ? Room.fromJson(json['RM-00149']) : null;
//     rM00028 = json['RM-00028'] != null ? Room.fromJson(json['RM-00028']) : null;
//     rM00146 = json['RM-00146'] != null ? Room.fromJson(json['RM-00146']) : null;
//     rM00025 = json['RM-00025'] != null ? Room.fromJson(json['RM-00025']) : null;
//     rM00145 = json['RM-00145'] != null ? Room.fromJson(json['RM-00145']) : null;
//     rM00024 = json['RM-00024'] != null ? Room.fromJson(json['RM-00024']) : null;
//     rM00148 = json['RM-00148'] != null ? Room.fromJson(json['RM-00148']) : null;
//     rM00027 = json['RM-00027'] != null ? Room.fromJson(json['RM-00027']) : null;
//     rM00147 = json['RM-00147'] != null ? Room.fromJson(json['RM-00147']) : null;
//     rM00026 = json['RM-00026'] != null ? Room.fromJson(json['RM-00026']) : null;
//     rM00153 = json['RM-00153'] != null ? Room.fromJson(json['RM-00153']) : null;
//     rM00032 = json['RM-00032'] != null ? Room.fromJson(json['RM-00032']) : null;
//     rM00152 = json['RM-00152'] != null ? Room.fromJson(json['RM-00152']) : null;
//     rM00031 = json['RM-00031'] != null ? Room.fromJson(json['RM-00031']) : null;
//     rM00155 = json['RM-00155'] != null ? Room.fromJson(json['RM-00155']) : null;
//     rM00034 = json['RM-00034'] != null ? Room.fromJson(json['RM-00034']) : null;
//     rM00154 = json['RM-00154'] != null ? Room.fromJson(json['RM-00154']) : null;
//     rM00033 = json['RM-00033'] != null ? Room.fromJson(json['RM-00033']) : null;
//     rM00151 = json['RM-00151'] != null ? Room.fromJson(json['RM-00151']) : null;
//     rM00030 = json['RM-00030'] != null ? Room.fromJson(json['RM-00030']) : null;
//     rM00150 = json['RM-00150'] != null ? Room.fromJson(json['RM-00150']) : null;
//     rM00139 = json['RM-00139'] != null ? Room.fromJson(json['RM-00139']) : null;
//     rM00018 = json['RM-00018'] != null ? Room.fromJson(json['RM-00018']) : null;
//     rM00138 = json['RM-00138'] != null ? Room.fromJson(json['RM-00138']) : null;
//     rM00017 = json['RM-00017'] != null ? Room.fromJson(json['RM-00017']) : null;
//     rM00019 = json['RM-00019'] != null ? Room.fromJson(json['RM-00019']) : null;
//     rM00135 = json['RM-00135'] != null ? Room.fromJson(json['RM-00135']) : null;
//     rM00014 = json['RM-00014'] != null ? Room.fromJson(json['RM-00014']) : null;
//     rM00134 = json['RM-00134'] != null ? Room.fromJson(json['RM-00134']) : null;
//     rM00013 = json['RM-00013'] != null ? Room.fromJson(json['RM-00013']) : null;
//     rM00137 = json['RM-00137'] != null ? Room.fromJson(json['RM-00137']) : null;
//     rM00016 = json['RM-00016'] != null ? Room.fromJson(json['RM-00016']) : null;
//     rM00136 = json['RM-00136'] != null ? Room.fromJson(json['RM-00136']) : null;
//     rM00015 = json['RM-00015'] != null ? Room.fromJson(json['RM-00015']) : null;
//     rM00142 = json['RM-00142'] != null ? Room.fromJson(json['RM-00142']) : null;
//     rM00021 = json['RM-00021'] != null ? Room.fromJson(json['RM-00021']) : null;
//     rM00141 = json['RM-00141'] != null ? Room.fromJson(json['RM-00141']) : null;
//     rM00020 = json['RM-00020'] != null ? Room.fromJson(json['RM-00020']) : null;
//     rM00144 = json['RM-00144'] != null ? Room.fromJson(json['RM-00144']) : null;
//     rM00023 = json['RM-00023'] != null ? Room.fromJson(json['RM-00023']) : null;
//     rM00143 = json['RM-00143'] != null ? Room.fromJson(json['RM-00143']) : null;
//     rM00022 = json['RM-00022'] != null ? Room.fromJson(json['RM-00022']) : null;
//     rM00140 = json['RM-00140'] != null ? Room.fromJson(json['RM-00140']) : null;
//     rM00128 = json['RM-00128'] != null ? Room.fromJson(json['RM-00128']) : null;
//     rM00007 = json['RM-00007'] != null ? Room.fromJson(json['RM-00007']) : null;
//     rM00127 = json['RM-00127'] != null ? Room.fromJson(json['RM-00127']) : null;
//     rM00006 = json['RM-00006'] != null ? Room.fromJson(json['RM-00006']) : null;
//     rM00009 = json['RM-00009'] != null ? Room.fromJson(json['RM-00009']) : null;
//     rM00129 = json['RM-00129'] != null ? Room.fromJson(json['RM-00129']) : null;
//     rM00008 = json['RM-00008'] != null ? Room.fromJson(json['RM-00008']) : null;
//     rM00124 = json['RM-00124'] != null ? Room.fromJson(json['RM-00124']) : null;
//     rM00003 = json['RM-00003'] != null ? Room.fromJson(json['RM-00003']) : null;
//     rM00123 = json['RM-00123'] != null ? Room.fromJson(json['RM-00123']) : null;
//     rM00002 = json['RM-00002'] != null ? Room.fromJson(json['RM-00002']) : null;
//     rM00126 = json['RM-00126'] != null ? Room.fromJson(json['RM-00126']) : null;
//     rM00005 = json['RM-00005'] != null ? Room.fromJson(json['RM-00005']) : null;
//     rM00125 = json['RM-00125'] != null ? Room.fromJson(json['RM-00125']) : null;
//     rM00004 = json['RM-00004'] != null ? Room.fromJson(json['RM-00004']) : null;
//     rM00131 = json['RM-00131'] != null ? Room.fromJson(json['RM-00131']) : null;
//     rM00010 = json['RM-00010'] != null ? Room.fromJson(json['RM-00010']) : null;
//     rM00130 = json['RM-00130'] != null ? Room.fromJson(json['RM-00130']) : null;
//     rM00133 = json['RM-00133'] != null ? Room.fromJson(json['RM-00133']) : null;
//     rM00012 = json['RM-00012'] != null ? Room.fromJson(json['RM-00012']) : null;
//     rM00132 = json['RM-00132'] != null ? Room.fromJson(json['RM-00132']) : null;
//     rM00011 = json['RM-00011'] != null ? Room.fromJson(json['RM-00011']) : null;
//     rM00117 = json['RM-00117'] != null ? Room.fromJson(json['RM-00117']) : null;
//     rM00116 = json['RM-00116'] != null ? Room.fromJson(json['RM-00116']) : null;
//     rM00119 = json['RM-00119'] != null ? Room.fromJson(json['RM-00119']) : null;
//     rM00118 = json['RM-00118'] != null ? Room.fromJson(json['RM-00118']) : null;
//     rM00113 = json['RM-00113'] != null ? Room.fromJson(json['RM-00113']) : null;
//     rM00112 = json['RM-00112'] != null ? Room.fromJson(json['RM-00112']) : null;
//     rM00115 = json['RM-00115'] != null ? Room.fromJson(json['RM-00115']) : null;
//     rM00114 = json['RM-00114'] != null ? Room.fromJson(json['RM-00114']) : null;
//     rM00120 = json['RM-00120'] != null ? Room.fromJson(json['RM-00120']) : null;
//     rM00122 = json['RM-00122'] != null ? Room.fromJson(json['RM-00122']) : null;
//     rM00001 = json['RM-00001'] != null ? Room.fromJson(json['RM-00001']) : null;
//     rM00121 = json['RM-00121'] != null ? Room.fromJson(json['RM-00121']) : null;
//     rM00106 = json['RM-00106'] != null ? Room.fromJson(json['RM-00106']) : null;
//     rM00105 = json['RM-00105'] != null ? Room.fromJson(json['RM-00105']) : null;
//     rM00108 = json['RM-00108'] != null ? Room.fromJson(json['RM-00108']) : null;
//     rM00107 = json['RM-00107'] != null ? Room.fromJson(json['RM-00107']) : null;
//     rM00102 = json['RM-00102'] != null ? Room.fromJson(json['RM-00102']) : null;
//     rM00101 = json['RM-00101'] != null ? Room.fromJson(json['RM-00101']) : null;
//     rM00104 = json['RM-00104'] != null ? Room.fromJson(json['RM-00104']) : null;
//     rM00103 = json['RM-00103'] != null ? Room.fromJson(json['RM-00103']) : null;
//     rM00109 = json['RM-00109'] != null ? Room.fromJson(json['RM-00109']) : null;
//     rM00111 = json['RM-00111'] != null ? Room.fromJson(json['RM-00111']) : null;
//     rM00110 = json['RM-00110'] != null ? Room.fromJson(json['RM-00110']) : null;
//     rM00100 = json['RM-00100'] != null ? Room.fromJson(json['RM-00100']) : null;
//     rM00205 = json['RM-00205'] != null ? Room.fromJson(json['RM-00205']) : null;
//     rM00204 = json['RM-00204'] != null ? Room.fromJson(json['RM-00204']) : null;
//     rM00207 = json['RM-00207'] != null ? Room.fromJson(json['RM-00207']) : null;
//     rM00206 = json['RM-00206'] != null ? Room.fromJson(json['RM-00206']) : null;
//     rM00201 = json['RM-00201'] != null ? Room.fromJson(json['RM-00201']) : null;
//     rM00200 = json['RM-00200'] != null ? Room.fromJson(json['RM-00200']) : null;
//     rM00203 = json['RM-00203'] != null ? Room.fromJson(json['RM-00203']) : null;
//     rM00202 = json['RM-00202'] != null ? Room.fromJson(json['RM-00202']) : null;
//     rM00209 = json['RM-00209'] != null ? Room.fromJson(json['RM-00209']) : null;
//     rM00208 = json['RM-00208'] != null ? Room.fromJson(json['RM-00208']) : null;
//     rM00090 = json['RM-00090'] != null ? Room.fromJson(json['RM-00090']) : null;
//     rM00092 = json['RM-00092'] != null ? Room.fromJson(json['RM-00092']) : null;
//     rM00091 = json['RM-00091'] != null ? Room.fromJson(json['RM-00091']) : null;
//     rM00098 = json['RM-00098'] != null ? Room.fromJson(json['RM-00098']) : null;
//     rM00097 = json['RM-00097'] != null ? Room.fromJson(json['RM-00097']) : null;
//     rM00099 = json['RM-00099'] != null ? Room.fromJson(json['RM-00099']) : null;
//     rM00094 = json['RM-00094'] != null ? Room.fromJson(json['RM-00094']) : null;
//     rM00093 = json['RM-00093'] != null ? Room.fromJson(json['RM-00093']) : null;
//     rM00096 = json['RM-00096'] != null ? Room.fromJson(json['RM-00096']) : null;
//     rM00095 = json['RM-00095'] != null ? Room.fromJson(json['RM-00095']) : null;
//     rM00079 = json['RM-00079'] != null ? Room.fromJson(json['RM-00079']) : null;
//     rM00081 = json['RM-00081'] != null ? Room.fromJson(json['RM-00081']) : null;
//     rM00080 = json['RM-00080'] != null ? Room.fromJson(json['RM-00080']) : null;
//     rM00087 = json['RM-00087'] != null ? Room.fromJson(json['RM-00087']) : null;
//     rM00086 = json['RM-00086'] != null ? Room.fromJson(json['RM-00086']) : null;
//     rM00089 = json['RM-00089'] != null ? Room.fromJson(json['RM-00089']) : null;
//     rM00088 = json['RM-00088'] != null ? Room.fromJson(json['RM-00088']) : null;
//     rM00083 = json['RM-00083'] != null ? Room.fromJson(json['RM-00083']) : null;
//     rM00082 = json['RM-00082'] != null ? Room.fromJson(json['RM-00082']) : null;
//     rM00085 = json['RM-00085'] != null ? Room.fromJson(json['RM-00085']) : null;
//     rM00084 = json['RM-00084'] != null ? Room.fromJson(json['RM-00084']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.rM00069 != null) {
//       data['RM-00069'] = this.rM00069!.toJson();
//     }
//     if (this.rM00068 != null) {
//       data['RM-00068'] = this.rM00068!.toJson();
//     }
//     if (this.rM00189 != null) {
//       data['RM-00189'] = this.rM00189!.toJson();
//     }
//     if (this.rM00070 != null) {
//       data['RM-00070'] = this.rM00070!.toJson();
//     }
//     if (this.rM00191 != null) {
//       data['RM-00191'] = this.rM00191!.toJson();
//     }
//     if (this.rM00190 != null) {
//       data['RM-00190'] = this.rM00190!.toJson();
//     }
//     if (this.rM00076 != null) {
//       data['RM-00076'] = this.rM00076!.toJson();
//     }
//     if (this.rM00197 != null) {
//       data['RM-00197'] = this.rM00197!.toJson();
//     }
//     if (this.rM00075 != null) {
//       data['RM-00075'] = this.rM00075!.toJson();
//     }
//     if (this.rM00196 != null) {
//       data['RM-00196'] = this.rM00196!.toJson();
//     }
//     if (this.rM00078 != null) {
//       data['RM-00078'] = this.rM00078!.toJson();
//     }
//     if (this.rM00199 != null) {
//       data['RM-00199'] = this.rM00199!.toJson();
//     }
//     if (this.rM00077 != null) {
//       data['RM-00077'] = this.rM00077!.toJson();
//     }
//     if (this.rM00198 != null) {
//       data['RM-00198'] = this.rM00198!.toJson();
//     }
//     if (this.rM00072 != null) {
//       data['RM-00072'] = this.rM00072!.toJson();
//     }
//     if (this.rM00193 != null) {
//       data['RM-00193'] = this.rM00193!.toJson();
//     }
//     if (this.rM00071 != null) {
//       data['RM-00071'] = this.rM00071!.toJson();
//     }
//     if (this.rM00192 != null) {
//       data['RM-00192'] = this.rM00192!.toJson();
//     }
//     if (this.rM00074 != null) {
//       data['RM-00074'] = this.rM00074!.toJson();
//     }
//     if (this.rM00195 != null) {
//       data['RM-00195'] = this.rM00195!.toJson();
//     }
//     if (this.rM00073 != null) {
//       data['RM-00073'] = this.rM00073!.toJson();
//     }
//     if (this.rM00194 != null) {
//       data['RM-00194'] = this.rM00194!.toJson();
//     }
//     if (this.rM00058 != null) {
//       data['RM-00058'] = this.rM00058!.toJson();
//     }
//     if (this.rM00179 != null) {
//       data['RM-00179'] = this.rM00179!.toJson();
//     }
//     if (this.rM00057 != null) {
//       data['RM-00057'] = this.rM00057!.toJson();
//     }
//     if (this.rM00178 != null) {
//       data['RM-00178'] = this.rM00178!.toJson();
//     }
//     if (this.rM00059 != null) {
//       data['RM-00059'] = this.rM00059!.toJson();
//     }
//     if (this.rM00180 != null) {
//       data['RM-00180'] = this.rM00180!.toJson();
//     }
//     if (this.rM00065 != null) {
//       data['RM-00065'] = this.rM00065!.toJson();
//     }
//     if (this.rM00186 != null) {
//       data['RM-00186'] = this.rM00186!.toJson();
//     }
//     if (this.rM00064 != null) {
//       data['RM-00064'] = this.rM00064!.toJson();
//     }
//     if (this.rM00185 != null) {
//       data['RM-00185'] = this.rM00185!.toJson();
//     }
//     if (this.rM00067 != null) {
//       data['RM-00067'] = this.rM00067!.toJson();
//     }
//     if (this.rM00188 != null) {
//       data['RM-00188'] = this.rM00188!.toJson();
//     }
//     if (this.rM00066 != null) {
//       data['RM-00066'] = this.rM00066!.toJson();
//     }
//     if (this.rM00187 != null) {
//       data['RM-00187'] = this.rM00187!.toJson();
//     }
//     if (this.rM00061 != null) {
//       data['RM-00061'] = this.rM00061!.toJson();
//     }
//     if (this.rM00182 != null) {
//       data['RM-00182'] = this.rM00182!.toJson();
//     }
//     if (this.rM00060 != null) {
//       data['RM-00060'] = this.rM00060!.toJson();
//     }
//     if (this.rM00181 != null) {
//       data['RM-00181'] = this.rM00181!.toJson();
//     }
//     if (this.rM00063 != null) {
//       data['RM-00063'] = this.rM00063!.toJson();
//     }
//     if (this.rM00184 != null) {
//       data['RM-00184'] = this.rM00184!.toJson();
//     }
//     if (this.rM00062 != null) {
//       data['RM-00062'] = this.rM00062!.toJson();
//     }
//     if (this.rM00183 != null) {
//       data['RM-00183'] = this.rM00183!.toJson();
//     }
//     if (this.rM00047 != null) {
//       data['RM-00047'] = this.rM00047!.toJson();
//     }
//     if (this.rM00168 != null) {
//       data['RM-00168'] = this.rM00168!.toJson();
//     }
//     if (this.rM00046 != null) {
//       data['RM-00046'] = this.rM00046!.toJson();
//     }
//     if (this.rM00167 != null) {
//       data['RM-00167'] = this.rM00167!.toJson();
//     }
//     if (this.rM00049 != null) {
//       data['RM-00049'] = this.rM00049!.toJson();
//     }
//     if (this.rM00048 != null) {
//       data['RM-00048'] = this.rM00048!.toJson();
//     }
//     if (this.rM00169 != null) {
//       data['RM-00169'] = this.rM00169!.toJson();
//     }
//     if (this.rM00054 != null) {
//       data['RM-00054'] = this.rM00054!.toJson();
//     }
//     if (this.rM00175 != null) {
//       data['RM-00175'] = this.rM00175!.toJson();
//     }
//     if (this.rM00053 != null) {
//       data['RM-00053'] = this.rM00053!.toJson();
//     }
//     if (this.rM00174 != null) {
//       data['RM-00174'] = this.rM00174!.toJson();
//     }
//     if (this.rM00056 != null) {
//       data['RM-00056'] = this.rM00056!.toJson();
//     }
//     if (this.rM00177 != null) {
//       data['RM-00177'] = this.rM00177!.toJson();
//     }
//     if (this.rM00055 != null) {
//       data['RM-00055'] = this.rM00055!.toJson();
//     }
//     if (this.rM00176 != null) {
//       data['RM-00176'] = this.rM00176!.toJson();
//     }
//     if (this.rM00050 != null) {
//       data['RM-00050'] = this.rM00050!.toJson();
//     }
//     if (this.rM00171 != null) {
//       data['RM-00171'] = this.rM00171!.toJson();
//     }
//     if (this.rM00170 != null) {
//       data['RM-00170'] = this.rM00170!.toJson();
//     }
//     if (this.rM00052 != null) {
//       data['RM-00052'] = this.rM00052!.toJson();
//     }
//     if (this.rM00173 != null) {
//       data['RM-00173'] = this.rM00173!.toJson();
//     }
//     if (this.rM00051 != null) {
//       data['RM-00051'] = this.rM00051!.toJson();
//     }
//     if (this.rM00172 != null) {
//       data['RM-00172'] = this.rM00172!.toJson();
//     }
//     if (this.rM00039 != null) {
//       data['RM-00039'] = this.rM00039!.toJson();
//     }
//     if (this.rM00157 != null) {
//       data['RM-00157'] = this.rM00157!.toJson();
//     }
//     if (this.rM00036 != null) {
//       data['RM-00036'] = this.rM00036!.toJson();
//     }
//     if (this.rM00156 != null) {
//       data['RM-00156'] = this.rM00156!.toJson();
//     }
//     if (this.rM00035 != null) {
//       data['RM-00035'] = this.rM00035!.toJson();
//     }
//     if (this.rM00159 != null) {
//       data['RM-00159'] = this.rM00159!.toJson();
//     }
//     if (this.rM00038 != null) {
//       data['RM-00038'] = this.rM00038!.toJson();
//     }
//     if (this.rM00158 != null) {
//       data['RM-00158'] = this.rM00158!.toJson();
//     }
//     if (this.rM00037 != null) {
//       data['RM-00037'] = this.rM00037!.toJson();
//     }
//     if (this.rM00043 != null) {
//       data['RM-00043'] = this.rM00043!.toJson();
//     }
//     if (this.rM00164 != null) {
//       data['RM-00164'] = this.rM00164!.toJson();
//     }
//     if (this.rM00042 != null) {
//       data['RM-00042'] = this.rM00042!.toJson();
//     }
//     if (this.rM00163 != null) {
//       data['RM-00163'] = this.rM00163!.toJson();
//     }
//     if (this.rM00045 != null) {
//       data['RM-00045'] = this.rM00045!.toJson();
//     }
//     if (this.rM00166 != null) {
//       data['RM-00166'] = this.rM00166!.toJson();
//     }
//     if (this.rM00044 != null) {
//       data['RM-00044'] = this.rM00044!.toJson();
//     }
//     if (this.rM00165 != null) {
//       data['RM-00165'] = this.rM00165!.toJson();
//     }
//     if (this.rM00160 != null) {
//       data['RM-00160'] = this.rM00160!.toJson();
//     }
//     if (this.rM00041 != null) {
//       data['RM-00041'] = this.rM00041!.toJson();
//     }
//     if (this.rM00162 != null) {
//       data['RM-00162'] = this.rM00162!.toJson();
//     }
//     if (this.rM00040 != null) {
//       data['RM-00040'] = this.rM00040!.toJson();
//     }
//     if (this.rM00161 != null) {
//       data['RM-00161'] = this.rM00161!.toJson();
//     }
//     if (this.rM00029 != null) {
//       data['RM-00029'] = this.rM00029!.toJson();
//     }
//     if (this.rM00149 != null) {
//       data['RM-00149'] = this.rM00149!.toJson();
//     }
//     if (this.rM00028 != null) {
//       data['RM-00028'] = this.rM00028!.toJson();
//     }
//     if (this.rM00146 != null) {
//       data['RM-00146'] = this.rM00146!.toJson();
//     }
//     if (this.rM00025 != null) {
//       data['RM-00025'] = this.rM00025!.toJson();
//     }
//     if (this.rM00145 != null) {
//       data['RM-00145'] = this.rM00145!.toJson();
//     }
//     if (this.rM00024 != null) {
//       data['RM-00024'] = this.rM00024!.toJson();
//     }
//     if (this.rM00148 != null) {
//       data['RM-00148'] = this.rM00148!.toJson();
//     }
//     if (this.rM00027 != null) {
//       data['RM-00027'] = this.rM00027!.toJson();
//     }
//     if (this.rM00147 != null) {
//       data['RM-00147'] = this.rM00147!.toJson();
//     }
//     if (this.rM00026 != null) {
//       data['RM-00026'] = this.rM00026!.toJson();
//     }
//     if (this.rM00153 != null) {
//       data['RM-00153'] = this.rM00153!.toJson();
//     }
//     if (this.rM00032 != null) {
//       data['RM-00032'] = this.rM00032!.toJson();
//     }
//     if (this.rM00152 != null) {
//       data['RM-00152'] = this.rM00152!.toJson();
//     }
//     if (this.rM00031 != null) {
//       data['RM-00031'] = this.rM00031!.toJson();
//     }
//     if (this.rM00155 != null) {
//       data['RM-00155'] = this.rM00155!.toJson();
//     }
//     if (this.rM00034 != null) {
//       data['RM-00034'] = this.rM00034!.toJson();
//     }
//     if (this.rM00154 != null) {
//       data['RM-00154'] = this.rM00154!.toJson();
//     }
//     if (this.rM00033 != null) {
//       data['RM-00033'] = this.rM00033!.toJson();
//     }
//     if (this.rM00151 != null) {
//       data['RM-00151'] = this.rM00151!.toJson();
//     }
//     if (this.rM00030 != null) {
//       data['RM-00030'] = this.rM00030!.toJson();
//     }
//     if (this.rM00150 != null) {
//       data['RM-00150'] = this.rM00150!.toJson();
//     }
//     if (this.rM00139 != null) {
//       data['RM-00139'] = this.rM00139!.toJson();
//     }
//     if (this.rM00018 != null) {
//       data['RM-00018'] = this.rM00018!.toJson();
//     }
//     if (this.rM00138 != null) {
//       data['RM-00138'] = this.rM00138!.toJson();
//     }
//     if (this.rM00017 != null) {
//       data['RM-00017'] = this.rM00017!.toJson();
//     }
//     if (this.rM00019 != null) {
//       data['RM-00019'] = this.rM00019!.toJson();
//     }
//     if (this.rM00135 != null) {
//       data['RM-00135'] = this.rM00135!.toJson();
//     }
//     if (this.rM00014 != null) {
//       data['RM-00014'] = this.rM00014!.toJson();
//     }
//     if (this.rM00134 != null) {
//       data['RM-00134'] = this.rM00134!.toJson();
//     }
//     if (this.rM00013 != null) {
//       data['RM-00013'] = this.rM00013!.toJson();
//     }
//     if (this.rM00137 != null) {
//       data['RM-00137'] = this.rM00137!.toJson();
//     }
//     if (this.rM00016 != null) {
//       data['RM-00016'] = this.rM00016!.toJson();
//     }
//     if (this.rM00136 != null) {
//       data['RM-00136'] = this.rM00136!.toJson();
//     }
//     if (this.rM00015 != null) {
//       data['RM-00015'] = this.rM00015!.toJson();
//     }
//     if (this.rM00142 != null) {
//       data['RM-00142'] = this.rM00142!.toJson();
//     }
//     if (this.rM00021 != null) {
//       data['RM-00021'] = this.rM00021!.toJson();
//     }
//     if (this.rM00141 != null) {
//       data['RM-00141'] = this.rM00141!.toJson();
//     }
//     if (this.rM00020 != null) {
//       data['RM-00020'] = this.rM00020!.toJson();
//     }
//     if (this.rM00144 != null) {
//       data['RM-00144'] = this.rM00144!.toJson();
//     }
//     if (this.rM00023 != null) {
//       data['RM-00023'] = this.rM00023!.toJson();
//     }
//     if (this.rM00143 != null) {
//       data['RM-00143'] = this.rM00143!.toJson();
//     }
//     if (this.rM00022 != null) {
//       data['RM-00022'] = this.rM00022!.toJson();
//     }
//     if (this.rM00140 != null) {
//       data['RM-00140'] = this.rM00140!.toJson();
//     }
//     if (this.rM00128 != null) {
//       data['RM-00128'] = this.rM00128!.toJson();
//     }
//     if (this.rM00007 != null) {
//       data['RM-00007'] = this.rM00007!.toJson();
//     }
//     if (this.rM00127 != null) {
//       data['RM-00127'] = this.rM00127!.toJson();
//     }
//     if (this.rM00006 != null) {
//       data['RM-00006'] = this.rM00006!.toJson();
//     }
//     if (this.rM00009 != null) {
//       data['RM-00009'] = this.rM00009!.toJson();
//     }
//     if (this.rM00129 != null) {
//       data['RM-00129'] = this.rM00129!.toJson();
//     }
//     if (this.rM00008 != null) {
//       data['RM-00008'] = this.rM00008!.toJson();
//     }
//     if (this.rM00124 != null) {
//       data['RM-00124'] = this.rM00124!.toJson();
//     }
//     if (this.rM00003 != null) {
//       data['RM-00003'] = this.rM00003!.toJson();
//     }
//     if (this.rM00123 != null) {
//       data['RM-00123'] = this.rM00123!.toJson();
//     }
//     if (this.rM00002 != null) {
//       data['RM-00002'] = this.rM00002!.toJson();
//     }
//     if (this.rM00126 != null) {
//       data['RM-00126'] = this.rM00126!.toJson();
//     }
//     if (this.rM00005 != null) {
//       data['RM-00005'] = this.rM00005!.toJson();
//     }
//     if (this.rM00125 != null) {
//       data['RM-00125'] = this.rM00125!.toJson();
//     }
//     if (this.rM00004 != null) {
//       data['RM-00004'] = this.rM00004!.toJson();
//     }
//     if (this.rM00131 != null) {
//       data['RM-00131'] = this.rM00131!.toJson();
//     }
//     if (this.rM00010 != null) {
//       data['RM-00010'] = this.rM00010!.toJson();
//     }
//     if (this.rM00130 != null) {
//       data['RM-00130'] = this.rM00130!.toJson();
//     }
//     if (this.rM00133 != null) {
//       data['RM-00133'] = this.rM00133!.toJson();
//     }
//     if (this.rM00012 != null) {
//       data['RM-00012'] = this.rM00012!.toJson();
//     }
//     if (this.rM00132 != null) {
//       data['RM-00132'] = this.rM00132!.toJson();
//     }
//     if (this.rM00011 != null) {
//       data['RM-00011'] = this.rM00011!.toJson();
//     }
//     if (this.rM00117 != null) {
//       data['RM-00117'] = this.rM00117!.toJson();
//     }
//     if (this.rM00116 != null) {
//       data['RM-00116'] = this.rM00116!.toJson();
//     }
//     if (this.rM00119 != null) {
//       data['RM-00119'] = this.rM00119!.toJson();
//     }
//     if (this.rM00118 != null) {
//       data['RM-00118'] = this.rM00118!.toJson();
//     }
//     if (this.rM00113 != null) {
//       data['RM-00113'] = this.rM00113!.toJson();
//     }
//     if (this.rM00112 != null) {
//       data['RM-00112'] = this.rM00112!.toJson();
//     }
//     if (this.rM00115 != null) {
//       data['RM-00115'] = this.rM00115!.toJson();
//     }
//     if (this.rM00114 != null) {
//       data['RM-00114'] = this.rM00114!.toJson();
//     }
//     if (this.rM00120 != null) {
//       data['RM-00120'] = this.rM00120!.toJson();
//     }
//     if (this.rM00122 != null) {
//       data['RM-00122'] = this.rM00122!.toJson();
//     }
//     if (this.rM00001 != null) {
//       data['RM-00001'] = this.rM00001!.toJson();
//     }
//     if (this.rM00121 != null) {
//       data['RM-00121'] = this.rM00121!.toJson();
//     }
//     if (this.rM00106 != null) {
//       data['RM-00106'] = this.rM00106!.toJson();
//     }
//     if (this.rM00105 != null) {
//       data['RM-00105'] = this.rM00105!.toJson();
//     }
//     if (this.rM00108 != null) {
//       data['RM-00108'] = this.rM00108!.toJson();
//     }
//     if (this.rM00107 != null) {
//       data['RM-00107'] = this.rM00107!.toJson();
//     }
//     if (this.rM00102 != null) {
//       data['RM-00102'] = this.rM00102!.toJson();
//     }
//     if (this.rM00101 != null) {
//       data['RM-00101'] = this.rM00101!.toJson();
//     }
//     if (this.rM00104 != null) {
//       data['RM-00104'] = this.rM00104!.toJson();
//     }
//     if (this.rM00103 != null) {
//       data['RM-00103'] = this.rM00103!.toJson();
//     }
//     if (this.rM00109 != null) {
//       data['RM-00109'] = this.rM00109!.toJson();
//     }
//     if (this.rM00111 != null) {
//       data['RM-00111'] = this.rM00111!.toJson();
//     }
//     if (this.rM00110 != null) {
//       data['RM-00110'] = this.rM00110!.toJson();
//     }
//     if (this.rM00100 != null) {
//       data['RM-00100'] = this.rM00100!.toJson();
//     }
//     if (this.rM00205 != null) {
//       data['RM-00205'] = this.rM00205!.toJson();
//     }
//     if (this.rM00204 != null) {
//       data['RM-00204'] = this.rM00204!.toJson();
//     }
//     if (this.rM00207 != null) {
//       data['RM-00207'] = this.rM00207!.toJson();
//     }
//     if (this.rM00206 != null) {
//       data['RM-00206'] = this.rM00206!.toJson();
//     }
//     if (this.rM00201 != null) {
//       data['RM-00201'] = this.rM00201!.toJson();
//     }
//     if (this.rM00200 != null) {
//       data['RM-00200'] = this.rM00200!.toJson();
//     }
//     if (this.rM00203 != null) {
//       data['RM-00203'] = this.rM00203!.toJson();
//     }
//     if (this.rM00202 != null) {
//       data['RM-00202'] = this.rM00202!.toJson();
//     }
//     if (this.rM00209 != null) {
//       data['RM-00209'] = this.rM00209!.toJson();
//     }
//     if (this.rM00208 != null) {
//       data['RM-00208'] = this.rM00208!.toJson();
//     }
//     if (this.rM00090 != null) {
//       data['RM-00090'] = this.rM00090!.toJson();
//     }
//     if (this.rM00092 != null) {
//       data['RM-00092'] = this.rM00092!.toJson();
//     }
//     if (this.rM00091 != null) {
//       data['RM-00091'] = this.rM00091!.toJson();
//     }
//     if (this.rM00098 != null) {
//       data['RM-00098'] = this.rM00098!.toJson();
//     }
//     if (this.rM00097 != null) {
//       data['RM-00097'] = this.rM00097!.toJson();
//     }
//     if (this.rM00099 != null) {
//       data['RM-00099'] = this.rM00099!.toJson();
//     }
//     if (this.rM00094 != null) {
//       data['RM-00094'] = this.rM00094!.toJson();
//     }
//     if (this.rM00093 != null) {
//       data['RM-00093'] = this.rM00093!.toJson();
//     }
//     if (this.rM00096 != null) {
//       data['RM-00096'] = this.rM00096!.toJson();
//     }
//     if (this.rM00095 != null) {
//       data['RM-00095'] = this.rM00095!.toJson();
//     }
//     if (this.rM00079 != null) {
//       data['RM-00079'] = this.rM00079!.toJson();
//     }
//     if (this.rM00081 != null) {
//       data['RM-00081'] = this.rM00081!.toJson();
//     }
//     if (this.rM00080 != null) {
//       data['RM-00080'] = this.rM00080!.toJson();
//     }
//     if (this.rM00087 != null) {
//       data['RM-00087'] = this.rM00087!.toJson();
//     }
//     if (this.rM00086 != null) {
//       data['RM-00086'] = this.rM00086!.toJson();
//     }
//     if (this.rM00089 != null) {
//       data['RM-00089'] = this.rM00089!.toJson();
//     }
//     if (this.rM00088 != null) {
//       data['RM-00088'] = this.rM00088!.toJson();
//     }
//     if (this.rM00083 != null) {
//       data['RM-00083'] = this.rM00083!.toJson();
//     }
//     if (this.rM00082 != null) {
//       data['RM-00082'] = this.rM00082!.toJson();
//     }
//     if (this.rM00085 != null) {
//       data['RM-00085'] = this.rM00085!.toJson();
//     }
//     if (this.rM00084 != null) {
//       data['RM-00084'] = this.rM00084!.toJson();
//     }
//     return data;
//   }
// }

// class Room {
//   String? id;
//   String? roomId;
//   String? name;
//   String? info;
//   String? locationId;
//   int? minEmployee;
//   int? maxEmployee;
//   bool? available;
//   List<String>? deviceIds;

//   Room(
//       {this.id,
//       this.roomId,
//       this.name,
//       this.info,
//       this.locationId,
//       this.minEmployee,
//       this.maxEmployee,
//       this.available,
//       this.deviceIds});

//   Room.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     roomId = json['roomId'];
//     name = json['name'];
//     info = json['info'];
//     locationId = json['locationId'];
//     minEmployee = json['minEmployee'];
//     maxEmployee = json['maxEmployee'];
//     available = json['available'];
//     deviceIds = json['deviceIds'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['roomId'] = this.roomId;
//     data['name'] = this.name;
//     data['info'] = this.info;
//     data['locationId'] = this.locationId;
//     data['minEmployee'] = this.minEmployee;
//     data['maxEmployee'] = this.maxEmployee;
//     data['available'] = this.available;
//     data['deviceIds'] = this.deviceIds;
//     return data;
//   }

//   String? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getInfo() {
//     return info;
//   }

//   String? getLocationId() {
//     return locationId;
//   }

//   int? getMinEmployee() {
//     return minEmployee;
//   }

//   int? getMaxEmployee() {
//     return maxEmployee;
//   }

//   bool? getavailable() {
//     return available;
//   }

//   List<String>? getDeviceId() {
//     return deviceIds;
//   }
// }

// class Devices {
//   Device? tRKR00200;
//   Device? tRKR00201;
//   Device? tRKR00202;
//   Device? tRKR00203;
//   Device? tRKR00204;
//   Device? tRKR00205;
//   Device? tRKR00206;
//   Device? tRKR00207;
//   Device? tRKR00208;
//   Device? tRKR00209;
//   Device? tRKR00120;
//   Device? tRKR00121;
//   Device? tRKR00001;
//   Device? tRKR00122;
//   Device? tRKR00002;
//   Device? tRKR00123;
//   Device? tRKR00003;
//   Device? tRKR00124;
//   Device? tRKR00125;
//   Device? tRKR00004;
//   Device? tRKR00126;
//   Device? tRKR00005;
//   Device? tRKR00127;
//   Device? tRKR00006;
//   Device? tRKR00007;
//   Device? tRKR00128;
//   Device? tRKR00008;
//   Device? tRKR00129;
//   Device? tRKR00009;
//   Device? tRKR00130;
//   Device? tRKR00010;
//   Device? tRKR00131;
//   Device? tRKR00011;
//   Device? tRKR00132;
//   Device? tRKR00012;
//   Device? tRKR00133;
//   Device? tRKR00013;
//   Device? tRKR00134;
//   Device? tRKR00014;
//   Device? tRKR00135;
//   Device? tRKR00136;
//   Device? tRKR00015;
//   Device? tRKR00016;
//   Device? tRKR00137;
//   Device? tRKR00138;
//   Device? tRKR00017;
//   Device? tRKR00139;
//   Device? tRKR00018;
//   Device? tRKR00019;
//   Device? tRKR00100;
//   Device? tRKR00101;
//   Device? tRKR00102;
//   Device? tRKR00103;
//   Device? tRKR00104;
//   Device? tRKR00105;
//   Device? tRKR00106;
//   Device? tRKR00107;
//   Device? tRKR00108;
//   Device? tRKR00109;
//   Device? tRKR00110;
//   Device? tRKR00111;
//   Device? tRKR00112;
//   Device? tRKR00113;
//   Device? tRKR00114;
//   Device? tRKR00115;
//   Device? tRKR00116;
//   Device? tRKR00117;
//   Device? tRKR00118;
//   Device? tRKR00119;
//   Device? tRKR00160;
//   Device? tRKR00161;
//   Device? tRKR00040;
//   Device? tRKR00162;
//   Device? tRKR00041;
//   Device? tRKR00163;
//   Device? tRKR00042;
//   Device? tRKR00164;
//   Device? tRKR00043;
//   Device? tRKR00044;
//   Device? tRKR00165;
//   Device? tRKR00045;
//   Device? tRKR00166;
//   Device? tRKR00046;
//   Device? tRKR00167;
//   Device? tRKR00047;
//   Device? tRKR00168;
//   Device? tRKR00048;
//   Device? tRKR00169;
//   Device? tRKR00049;
//   Device? tRKR00170;
//   Device? tRKR00171;
//   Device? tRKR00050;
//   Device? tRKR00172;
//   Device? tRKR00051;
//   Device? tRKR00052;
//   Device? tRKR00173;
//   Device? tRKR00053;
//   Device? tRKR00174;
//   Device? tRKR00175;
//   Device? tRKR00054;
//   Device? tRKR00176;
//   Device? tRKR00055;
//   Device? tRKR00177;
//   Device? tRKR00056;
//   Device? tRKR00178;
//   Device? tRKR00057;
//   Device? tRKR00058;
//   Device? tRKR00179;
//   Device? tRKR00059;
//   Device? tRKR00140;
//   Device? tRKR00141;
//   Device? tRKR00020;
//   Device? tRKR00142;
//   Device? tRKR00021;
//   Device? tRKR00143;
//   Device? tRKR00022;
//   Device? tRKR00144;
//   Device? tRKR00023;
//   Device? tRKR00145;
//   Device? tRKR00024;
//   Device? tRKR00146;
//   Device? tRKR00025;
//   Device? tRKR00147;
//   Device? tRKR00026;
//   Device? tRKR00148;
//   Device? tRKR00027;
//   Device? tRKR00028;
//   Device? tRKR00149;
//   Device? tRKR00029;
//   Device? tRKR00150;
//   Device? tRKR00030;
//   Device? tRKR00151;
//   Device? tRKR00152;
//   Device? tRKR00031;
//   Device? tRKR00153;
//   Device? tRKR00032;
//   Device? tRKR00033;
//   Device? tRKR00154;
//   Device? tRKR00034;
//   Device? tRKR00155;
//   Device? tRKR00035;
//   Device? tRKR00156;
//   Device? tRKR00036;
//   Device? tRKR00157;
//   Device? tRKR00037;
//   Device? tRKR00158;
//   Device? tRKR00159;
//   Device? tRKR00038;
//   Device? tRKR00039;
//   Device? tRKR00080;
//   Device? tRKR00081;
//   Device? tRKR00082;
//   Device? tRKR00083;
//   Device? tRKR00084;
//   Device? tRKR00085;
//   Device? tRKR00086;
//   Device? tRKR00087;
//   Device? tRKR00088;
//   Device? tRKR00089;
//   Device? tRKR00090;
//   Device? tRKR00091;
//   Device? tRKR00092;
//   Device? tRKR00093;
//   Device? tRKR00094;
//   Device? tRKR00095;
//   Device? tRKR00096;
//   Device? tRKR00097;
//   Device? tRKR00098;
//   Device? tRKR00099;
//   Device? tRKR00180;
//   Device? tRKR00060;
//   Device? tRKR00181;
//   Device? tRKR00061;
//   Device? tRKR00182;
//   Device? tRKR00183;
//   Device? tRKR00062;
//   Device? tRKR00063;
//   Device? tRKR00184;
//   Device? tRKR00064;
//   Device? tRKR00185;
//   Device? tRKR00065;
//   Device? tRKR00186;
//   Device? tRKR00066;
//   Device? tRKR00187;
//   Device? tRKR00067;
//   Device? tRKR00188;
//   Device? tRKR00189;
//   Device? tRKR00068;
//   Device? tRKR00069;
//   Device? tRKR00190;
//   Device? tRKR00191;
//   Device? tRKR00070;
//   Device? tRKR00192;
//   Device? tRKR00071;
//   Device? tRKR00193;
//   Device? tRKR00072;
//   Device? tRKR00194;
//   Device? tRKR00073;
//   Device? tRKR00074;
//   Device? tRKR00195;
//   Device? tRKR00075;
//   Device? tRKR00196;
//   Device? tRKR00076;
//   Device? tRKR00197;
//   Device? tRKR00077;
//   Device? tRKR00198;
//   Device? tRKR00078;
//   Device? tRKR00199;
//   Device? tRKR00079;

//   Devices(
//       {this.tRKR00200,
//       this.tRKR00201,
//       this.tRKR00202,
//       this.tRKR00203,
//       this.tRKR00204,
//       this.tRKR00205,
//       this.tRKR00206,
//       this.tRKR00207,
//       this.tRKR00208,
//       this.tRKR00209,
//       this.tRKR00120,
//       this.tRKR00121,
//       this.tRKR00001,
//       this.tRKR00122,
//       this.tRKR00002,
//       this.tRKR00123,
//       this.tRKR00003,
//       this.tRKR00124,
//       this.tRKR00125,
//       this.tRKR00004,
//       this.tRKR00126,
//       this.tRKR00005,
//       this.tRKR00127,
//       this.tRKR00006,
//       this.tRKR00007,
//       this.tRKR00128,
//       this.tRKR00008,
//       this.tRKR00129,
//       this.tRKR00009,
//       this.tRKR00130,
//       this.tRKR00010,
//       this.tRKR00131,
//       this.tRKR00011,
//       this.tRKR00132,
//       this.tRKR00012,
//       this.tRKR00133,
//       this.tRKR00013,
//       this.tRKR00134,
//       this.tRKR00014,
//       this.tRKR00135,
//       this.tRKR00136,
//       this.tRKR00015,
//       this.tRKR00016,
//       this.tRKR00137,
//       this.tRKR00138,
//       this.tRKR00017,
//       this.tRKR00139,
//       this.tRKR00018,
//       this.tRKR00019,
//       this.tRKR00100,
//       this.tRKR00101,
//       this.tRKR00102,
//       this.tRKR00103,
//       this.tRKR00104,
//       this.tRKR00105,
//       this.tRKR00106,
//       this.tRKR00107,
//       this.tRKR00108,
//       this.tRKR00109,
//       this.tRKR00110,
//       this.tRKR00111,
//       this.tRKR00112,
//       this.tRKR00113,
//       this.tRKR00114,
//       this.tRKR00115,
//       this.tRKR00116,
//       this.tRKR00117,
//       this.tRKR00118,
//       this.tRKR00119,
//       this.tRKR00160,
//       this.tRKR00161,
//       this.tRKR00040,
//       this.tRKR00162,
//       this.tRKR00041,
//       this.tRKR00163,
//       this.tRKR00042,
//       this.tRKR00164,
//       this.tRKR00043,
//       this.tRKR00044,
//       this.tRKR00165,
//       this.tRKR00045,
//       this.tRKR00166,
//       this.tRKR00046,
//       this.tRKR00167,
//       this.tRKR00047,
//       this.tRKR00168,
//       this.tRKR00048,
//       this.tRKR00169,
//       this.tRKR00049,
//       this.tRKR00170,
//       this.tRKR00171,
//       this.tRKR00050,
//       this.tRKR00172,
//       this.tRKR00051,
//       this.tRKR00052,
//       this.tRKR00173,
//       this.tRKR00053,
//       this.tRKR00174,
//       this.tRKR00175,
//       this.tRKR00054,
//       this.tRKR00176,
//       this.tRKR00055,
//       this.tRKR00177,
//       this.tRKR00056,
//       this.tRKR00178,
//       this.tRKR00057,
//       this.tRKR00058,
//       this.tRKR00179,
//       this.tRKR00059,
//       this.tRKR00140,
//       this.tRKR00141,
//       this.tRKR00020,
//       this.tRKR00142,
//       this.tRKR00021,
//       this.tRKR00143,
//       this.tRKR00022,
//       this.tRKR00144,
//       this.tRKR00023,
//       this.tRKR00145,
//       this.tRKR00024,
//       this.tRKR00146,
//       this.tRKR00025,
//       this.tRKR00147,
//       this.tRKR00026,
//       this.tRKR00148,
//       this.tRKR00027,
//       this.tRKR00028,
//       this.tRKR00149,
//       this.tRKR00029,
//       this.tRKR00150,
//       this.tRKR00030,
//       this.tRKR00151,
//       this.tRKR00152,
//       this.tRKR00031,
//       this.tRKR00153,
//       this.tRKR00032,
//       this.tRKR00033,
//       this.tRKR00154,
//       this.tRKR00034,
//       this.tRKR00155,
//       this.tRKR00035,
//       this.tRKR00156,
//       this.tRKR00036,
//       this.tRKR00157,
//       this.tRKR00037,
//       this.tRKR00158,
//       this.tRKR00159,
//       this.tRKR00038,
//       this.tRKR00039,
//       this.tRKR00080,
//       this.tRKR00081,
//       this.tRKR00082,
//       this.tRKR00083,
//       this.tRKR00084,
//       this.tRKR00085,
//       this.tRKR00086,
//       this.tRKR00087,
//       this.tRKR00088,
//       this.tRKR00089,
//       this.tRKR00090,
//       this.tRKR00091,
//       this.tRKR00092,
//       this.tRKR00093,
//       this.tRKR00094,
//       this.tRKR00095,
//       this.tRKR00096,
//       this.tRKR00097,
//       this.tRKR00098,
//       this.tRKR00099,
//       this.tRKR00180,
//       this.tRKR00060,
//       this.tRKR00181,
//       this.tRKR00061,
//       this.tRKR00182,
//       this.tRKR00183,
//       this.tRKR00062,
//       this.tRKR00063,
//       this.tRKR00184,
//       this.tRKR00064,
//       this.tRKR00185,
//       this.tRKR00065,
//       this.tRKR00186,
//       this.tRKR00066,
//       this.tRKR00187,
//       this.tRKR00067,
//       this.tRKR00188,
//       this.tRKR00189,
//       this.tRKR00068,
//       this.tRKR00069,
//       this.tRKR00190,
//       this.tRKR00191,
//       this.tRKR00070,
//       this.tRKR00192,
//       this.tRKR00071,
//       this.tRKR00193,
//       this.tRKR00072,
//       this.tRKR00194,
//       this.tRKR00073,
//       this.tRKR00074,
//       this.tRKR00195,
//       this.tRKR00075,
//       this.tRKR00196,
//       this.tRKR00076,
//       this.tRKR00197,
//       this.tRKR00077,
//       this.tRKR00198,
//       this.tRKR00078,
//       this.tRKR00199,
//       this.tRKR00079});

//   Devices.fromJson(Map<String, dynamic> json) {
//     tRKR00200 =
//         json['TRKR-00200'] != null ? Device.fromJson(json['TRKR-00200']) : null;
//     tRKR00201 =
//         json['TRKR-00201'] != null ? Device.fromJson(json['TRKR-00201']) : null;
//     tRKR00202 =
//         json['TRKR-00202'] != null ? Device.fromJson(json['TRKR-00202']) : null;
//     tRKR00203 =
//         json['TRKR-00203'] != null ? Device.fromJson(json['TRKR-00203']) : null;
//     tRKR00204 =
//         json['TRKR-00204'] != null ? Device.fromJson(json['TRKR-00204']) : null;
//     tRKR00205 =
//         json['TRKR-00205'] != null ? Device.fromJson(json['TRKR-00205']) : null;
//     tRKR00206 =
//         json['TRKR-00206'] != null ? Device.fromJson(json['TRKR-00206']) : null;
//     tRKR00207 =
//         json['TRKR-00207'] != null ? Device.fromJson(json['TRKR-00207']) : null;
//     tRKR00208 =
//         json['TRKR-00208'] != null ? Device.fromJson(json['TRKR-00208']) : null;
//     tRKR00209 =
//         json['TRKR-00209'] != null ? Device.fromJson(json['TRKR-00209']) : null;
//     tRKR00120 =
//         json['TRKR-00120'] != null ? Device.fromJson(json['TRKR-00120']) : null;
//     tRKR00121 =
//         json['TRKR-00121'] != null ? Device.fromJson(json['TRKR-00121']) : null;
//     tRKR00001 =
//         json['TRKR-00001'] != null ? Device.fromJson(json['TRKR-00001']) : null;
//     tRKR00122 =
//         json['TRKR-00122'] != null ? Device.fromJson(json['TRKR-00122']) : null;
//     tRKR00002 =
//         json['TRKR-00002'] != null ? Device.fromJson(json['TRKR-00002']) : null;
//     tRKR00123 =
//         json['TRKR-00123'] != null ? Device.fromJson(json['TRKR-00123']) : null;
//     tRKR00003 =
//         json['TRKR-00003'] != null ? Device.fromJson(json['TRKR-00003']) : null;
//     tRKR00124 =
//         json['TRKR-00124'] != null ? Device.fromJson(json['TRKR-00124']) : null;
//     tRKR00125 =
//         json['TRKR-00125'] != null ? Device.fromJson(json['TRKR-00125']) : null;
//     tRKR00004 =
//         json['TRKR-00004'] != null ? Device.fromJson(json['TRKR-00004']) : null;
//     tRKR00126 =
//         json['TRKR-00126'] != null ? Device.fromJson(json['TRKR-00126']) : null;
//     tRKR00005 =
//         json['TRKR-00005'] != null ? Device.fromJson(json['TRKR-00005']) : null;
//     tRKR00127 =
//         json['TRKR-00127'] != null ? Device.fromJson(json['TRKR-00127']) : null;
//     tRKR00006 =
//         json['TRKR-00006'] != null ? Device.fromJson(json['TRKR-00006']) : null;
//     tRKR00007 =
//         json['TRKR-00007'] != null ? Device.fromJson(json['TRKR-00007']) : null;
//     tRKR00128 =
//         json['TRKR-00128'] != null ? Device.fromJson(json['TRKR-00128']) : null;
//     tRKR00008 =
//         json['TRKR-00008'] != null ? Device.fromJson(json['TRKR-00008']) : null;
//     tRKR00129 =
//         json['TRKR-00129'] != null ? Device.fromJson(json['TRKR-00129']) : null;
//     tRKR00009 =
//         json['TRKR-00009'] != null ? Device.fromJson(json['TRKR-00009']) : null;
//     tRKR00130 =
//         json['TRKR-00130'] != null ? Device.fromJson(json['TRKR-00130']) : null;
//     tRKR00010 =
//         json['TRKR-00010'] != null ? Device.fromJson(json['TRKR-00010']) : null;
//     tRKR00131 =
//         json['TRKR-00131'] != null ? Device.fromJson(json['TRKR-00131']) : null;
//     tRKR00011 =
//         json['TRKR-00011'] != null ? Device.fromJson(json['TRKR-00011']) : null;
//     tRKR00132 =
//         json['TRKR-00132'] != null ? Device.fromJson(json['TRKR-00132']) : null;
//     tRKR00012 =
//         json['TRKR-00012'] != null ? Device.fromJson(json['TRKR-00012']) : null;
//     tRKR00133 =
//         json['TRKR-00133'] != null ? Device.fromJson(json['TRKR-00133']) : null;
//     tRKR00013 =
//         json['TRKR-00013'] != null ? Device.fromJson(json['TRKR-00013']) : null;
//     tRKR00134 =
//         json['TRKR-00134'] != null ? Device.fromJson(json['TRKR-00134']) : null;
//     tRKR00014 =
//         json['TRKR-00014'] != null ? Device.fromJson(json['TRKR-00014']) : null;
//     tRKR00135 =
//         json['TRKR-00135'] != null ? Device.fromJson(json['TRKR-00135']) : null;
//     tRKR00136 =
//         json['TRKR-00136'] != null ? Device.fromJson(json['TRKR-00136']) : null;
//     tRKR00015 =
//         json['TRKR-00015'] != null ? Device.fromJson(json['TRKR-00015']) : null;
//     tRKR00016 =
//         json['TRKR-00016'] != null ? Device.fromJson(json['TRKR-00016']) : null;
//     tRKR00137 =
//         json['TRKR-00137'] != null ? Device.fromJson(json['TRKR-00137']) : null;
//     tRKR00138 =
//         json['TRKR-00138'] != null ? Device.fromJson(json['TRKR-00138']) : null;
//     tRKR00017 =
//         json['TRKR-00017'] != null ? Device.fromJson(json['TRKR-00017']) : null;
//     tRKR00139 =
//         json['TRKR-00139'] != null ? Device.fromJson(json['TRKR-00139']) : null;
//     tRKR00018 =
//         json['TRKR-00018'] != null ? Device.fromJson(json['TRKR-00018']) : null;
//     tRKR00019 =
//         json['TRKR-00019'] != null ? Device.fromJson(json['TRKR-00019']) : null;
//     tRKR00100 =
//         json['TRKR-00100'] != null ? Device.fromJson(json['TRKR-00100']) : null;
//     tRKR00101 =
//         json['TRKR-00101'] != null ? Device.fromJson(json['TRKR-00101']) : null;
//     tRKR00102 =
//         json['TRKR-00102'] != null ? Device.fromJson(json['TRKR-00102']) : null;
//     tRKR00103 =
//         json['TRKR-00103'] != null ? Device.fromJson(json['TRKR-00103']) : null;
//     tRKR00104 =
//         json['TRKR-00104'] != null ? Device.fromJson(json['TRKR-00104']) : null;
//     tRKR00105 =
//         json['TRKR-00105'] != null ? Device.fromJson(json['TRKR-00105']) : null;
//     tRKR00106 =
//         json['TRKR-00106'] != null ? Device.fromJson(json['TRKR-00106']) : null;
//     tRKR00107 =
//         json['TRKR-00107'] != null ? Device.fromJson(json['TRKR-00107']) : null;
//     tRKR00108 =
//         json['TRKR-00108'] != null ? Device.fromJson(json['TRKR-00108']) : null;
//     tRKR00109 =
//         json['TRKR-00109'] != null ? Device.fromJson(json['TRKR-00109']) : null;
//     tRKR00110 =
//         json['TRKR-00110'] != null ? Device.fromJson(json['TRKR-00110']) : null;
//     tRKR00111 =
//         json['TRKR-00111'] != null ? Device.fromJson(json['TRKR-00111']) : null;
//     tRKR00112 =
//         json['TRKR-00112'] != null ? Device.fromJson(json['TRKR-00112']) : null;
//     tRKR00113 =
//         json['TRKR-00113'] != null ? Device.fromJson(json['TRKR-00113']) : null;
//     tRKR00114 =
//         json['TRKR-00114'] != null ? Device.fromJson(json['TRKR-00114']) : null;
//     tRKR00115 =
//         json['TRKR-00115'] != null ? Device.fromJson(json['TRKR-00115']) : null;
//     tRKR00116 =
//         json['TRKR-00116'] != null ? Device.fromJson(json['TRKR-00116']) : null;
//     tRKR00117 =
//         json['TRKR-00117'] != null ? Device.fromJson(json['TRKR-00117']) : null;
//     tRKR00118 =
//         json['TRKR-00118'] != null ? Device.fromJson(json['TRKR-00118']) : null;
//     tRKR00119 =
//         json['TRKR-00119'] != null ? Device.fromJson(json['TRKR-00119']) : null;
//     tRKR00160 =
//         json['TRKR-00160'] != null ? Device.fromJson(json['TRKR-00160']) : null;
//     tRKR00161 =
//         json['TRKR-00161'] != null ? Device.fromJson(json['TRKR-00161']) : null;
//     tRKR00040 =
//         json['TRKR-00040'] != null ? Device.fromJson(json['TRKR-00040']) : null;
//     tRKR00162 =
//         json['TRKR-00162'] != null ? Device.fromJson(json['TRKR-00162']) : null;
//     tRKR00041 =
//         json['TRKR-00041'] != null ? Device.fromJson(json['TRKR-00041']) : null;
//     tRKR00163 =
//         json['TRKR-00163'] != null ? Device.fromJson(json['TRKR-00163']) : null;
//     tRKR00042 =
//         json['TRKR-00042'] != null ? Device.fromJson(json['TRKR-00042']) : null;
//     tRKR00164 =
//         json['TRKR-00164'] != null ? Device.fromJson(json['TRKR-00164']) : null;
//     tRKR00043 =
//         json['TRKR-00043'] != null ? Device.fromJson(json['TRKR-00043']) : null;
//     tRKR00044 =
//         json['TRKR-00044'] != null ? Device.fromJson(json['TRKR-00044']) : null;
//     tRKR00165 =
//         json['TRKR-00165'] != null ? Device.fromJson(json['TRKR-00165']) : null;
//     tRKR00045 =
//         json['TRKR-00045'] != null ? Device.fromJson(json['TRKR-00045']) : null;
//     tRKR00166 =
//         json['TRKR-00166'] != null ? Device.fromJson(json['TRKR-00166']) : null;
//     tRKR00046 =
//         json['TRKR-00046'] != null ? Device.fromJson(json['TRKR-00046']) : null;
//     tRKR00167 =
//         json['TRKR-00167'] != null ? Device.fromJson(json['TRKR-00167']) : null;
//     tRKR00047 =
//         json['TRKR-00047'] != null ? Device.fromJson(json['TRKR-00047']) : null;
//     tRKR00168 =
//         json['TRKR-00168'] != null ? Device.fromJson(json['TRKR-00168']) : null;
//     tRKR00048 =
//         json['TRKR-00048'] != null ? Device.fromJson(json['TRKR-00048']) : null;
//     tRKR00169 =
//         json['TRKR-00169'] != null ? Device.fromJson(json['TRKR-00169']) : null;
//     tRKR00049 =
//         json['TRKR-00049'] != null ? Device.fromJson(json['TRKR-00049']) : null;
//     tRKR00170 =
//         json['TRKR-00170'] != null ? Device.fromJson(json['TRKR-00170']) : null;
//     tRKR00171 =
//         json['TRKR-00171'] != null ? Device.fromJson(json['TRKR-00171']) : null;
//     tRKR00050 =
//         json['TRKR-00050'] != null ? Device.fromJson(json['TRKR-00050']) : null;
//     tRKR00172 =
//         json['TRKR-00172'] != null ? Device.fromJson(json['TRKR-00172']) : null;
//     tRKR00051 =
//         json['TRKR-00051'] != null ? Device.fromJson(json['TRKR-00051']) : null;
//     tRKR00052 =
//         json['TRKR-00052'] != null ? Device.fromJson(json['TRKR-00052']) : null;
//     tRKR00173 =
//         json['TRKR-00173'] != null ? Device.fromJson(json['TRKR-00173']) : null;
//     tRKR00053 =
//         json['TRKR-00053'] != null ? Device.fromJson(json['TRKR-00053']) : null;
//     tRKR00174 =
//         json['TRKR-00174'] != null ? Device.fromJson(json['TRKR-00174']) : null;
//     tRKR00175 =
//         json['TRKR-00175'] != null ? Device.fromJson(json['TRKR-00175']) : null;
//     tRKR00054 =
//         json['TRKR-00054'] != null ? Device.fromJson(json['TRKR-00054']) : null;
//     tRKR00176 =
//         json['TRKR-00176'] != null ? Device.fromJson(json['TRKR-00176']) : null;
//     tRKR00055 =
//         json['TRKR-00055'] != null ? Device.fromJson(json['TRKR-00055']) : null;
//     tRKR00177 =
//         json['TRKR-00177'] != null ? Device.fromJson(json['TRKR-00177']) : null;
//     tRKR00056 =
//         json['TRKR-00056'] != null ? Device.fromJson(json['TRKR-00056']) : null;
//     tRKR00178 =
//         json['TRKR-00178'] != null ? Device.fromJson(json['TRKR-00178']) : null;
//     tRKR00057 =
//         json['TRKR-00057'] != null ? Device.fromJson(json['TRKR-00057']) : null;
//     tRKR00058 =
//         json['TRKR-00058'] != null ? Device.fromJson(json['TRKR-00058']) : null;
//     tRKR00179 =
//         json['TRKR-00179'] != null ? Device.fromJson(json['TRKR-00179']) : null;
//     tRKR00059 =
//         json['TRKR-00059'] != null ? Device.fromJson(json['TRKR-00059']) : null;
//     tRKR00140 =
//         json['TRKR-00140'] != null ? Device.fromJson(json['TRKR-00140']) : null;
//     tRKR00141 =
//         json['TRKR-00141'] != null ? Device.fromJson(json['TRKR-00141']) : null;
//     tRKR00020 =
//         json['TRKR-00020'] != null ? Device.fromJson(json['TRKR-00020']) : null;
//     tRKR00142 =
//         json['TRKR-00142'] != null ? Device.fromJson(json['TRKR-00142']) : null;
//     tRKR00021 =
//         json['TRKR-00021'] != null ? Device.fromJson(json['TRKR-00021']) : null;
//     tRKR00143 =
//         json['TRKR-00143'] != null ? Device.fromJson(json['TRKR-00143']) : null;
//     tRKR00022 =
//         json['TRKR-00022'] != null ? Device.fromJson(json['TRKR-00022']) : null;
//     tRKR00144 =
//         json['TRKR-00144'] != null ? Device.fromJson(json['TRKR-00144']) : null;
//     tRKR00023 =
//         json['TRKR-00023'] != null ? Device.fromJson(json['TRKR-00023']) : null;
//     tRKR00145 =
//         json['TRKR-00145'] != null ? Device.fromJson(json['TRKR-00145']) : null;
//     tRKR00024 =
//         json['TRKR-00024'] != null ? Device.fromJson(json['TRKR-00024']) : null;
//     tRKR00146 =
//         json['TRKR-00146'] != null ? Device.fromJson(json['TRKR-00146']) : null;
//     tRKR00025 =
//         json['TRKR-00025'] != null ? Device.fromJson(json['TRKR-00025']) : null;
//     tRKR00147 =
//         json['TRKR-00147'] != null ? Device.fromJson(json['TRKR-00147']) : null;
//     tRKR00026 =
//         json['TRKR-00026'] != null ? Device.fromJson(json['TRKR-00026']) : null;
//     tRKR00148 =
//         json['TRKR-00148'] != null ? Device.fromJson(json['TRKR-00148']) : null;
//     tRKR00027 =
//         json['TRKR-00027'] != null ? Device.fromJson(json['TRKR-00027']) : null;
//     tRKR00028 =
//         json['TRKR-00028'] != null ? Device.fromJson(json['TRKR-00028']) : null;
//     tRKR00149 =
//         json['TRKR-00149'] != null ? Device.fromJson(json['TRKR-00149']) : null;
//     tRKR00029 =
//         json['TRKR-00029'] != null ? Device.fromJson(json['TRKR-00029']) : null;
//     tRKR00150 =
//         json['TRKR-00150'] != null ? Device.fromJson(json['TRKR-00150']) : null;
//     tRKR00030 =
//         json['TRKR-00030'] != null ? Device.fromJson(json['TRKR-00030']) : null;
//     tRKR00151 =
//         json['TRKR-00151'] != null ? Device.fromJson(json['TRKR-00151']) : null;
//     tRKR00152 =
//         json['TRKR-00152'] != null ? Device.fromJson(json['TRKR-00152']) : null;
//     tRKR00031 =
//         json['TRKR-00031'] != null ? Device.fromJson(json['TRKR-00031']) : null;
//     tRKR00153 =
//         json['TRKR-00153'] != null ? Device.fromJson(json['TRKR-00153']) : null;
//     tRKR00032 =
//         json['TRKR-00032'] != null ? Device.fromJson(json['TRKR-00032']) : null;
//     tRKR00033 =
//         json['TRKR-00033'] != null ? Device.fromJson(json['TRKR-00033']) : null;
//     tRKR00154 =
//         json['TRKR-00154'] != null ? Device.fromJson(json['TRKR-00154']) : null;
//     tRKR00034 =
//         json['TRKR-00034'] != null ? Device.fromJson(json['TRKR-00034']) : null;
//     tRKR00155 =
//         json['TRKR-00155'] != null ? Device.fromJson(json['TRKR-00155']) : null;
//     tRKR00035 =
//         json['TRKR-00035'] != null ? Device.fromJson(json['TRKR-00035']) : null;
//     tRKR00156 =
//         json['TRKR-00156'] != null ? Device.fromJson(json['TRKR-00156']) : null;
//     tRKR00036 =
//         json['TRKR-00036'] != null ? Device.fromJson(json['TRKR-00036']) : null;
//     tRKR00157 =
//         json['TRKR-00157'] != null ? Device.fromJson(json['TRKR-00157']) : null;
//     tRKR00037 =
//         json['TRKR-00037'] != null ? Device.fromJson(json['TRKR-00037']) : null;
//     tRKR00158 =
//         json['TRKR-00158'] != null ? Device.fromJson(json['TRKR-00158']) : null;
//     tRKR00159 =
//         json['TRKR-00159'] != null ? Device.fromJson(json['TRKR-00159']) : null;
//     tRKR00038 =
//         json['TRKR-00038'] != null ? Device.fromJson(json['TRKR-00038']) : null;
//     tRKR00039 =
//         json['TRKR-00039'] != null ? Device.fromJson(json['TRKR-00039']) : null;
//     tRKR00080 =
//         json['TRKR-00080'] != null ? Device.fromJson(json['TRKR-00080']) : null;
//     tRKR00081 =
//         json['TRKR-00081'] != null ? Device.fromJson(json['TRKR-00081']) : null;
//     tRKR00082 =
//         json['TRKR-00082'] != null ? Device.fromJson(json['TRKR-00082']) : null;
//     tRKR00083 =
//         json['TRKR-00083'] != null ? Device.fromJson(json['TRKR-00083']) : null;
//     tRKR00084 =
//         json['TRKR-00084'] != null ? Device.fromJson(json['TRKR-00084']) : null;
//     tRKR00085 =
//         json['TRKR-00085'] != null ? Device.fromJson(json['TRKR-00085']) : null;
//     tRKR00086 =
//         json['TRKR-00086'] != null ? Device.fromJson(json['TRKR-00086']) : null;
//     tRKR00087 =
//         json['TRKR-00087'] != null ? Device.fromJson(json['TRKR-00087']) : null;
//     tRKR00088 =
//         json['TRKR-00088'] != null ? Device.fromJson(json['TRKR-00088']) : null;
//     tRKR00089 =
//         json['TRKR-00089'] != null ? Device.fromJson(json['TRKR-00089']) : null;
//     tRKR00090 =
//         json['TRKR-00090'] != null ? Device.fromJson(json['TRKR-00090']) : null;
//     tRKR00091 =
//         json['TRKR-00091'] != null ? Device.fromJson(json['TRKR-00091']) : null;
//     tRKR00092 =
//         json['TRKR-00092'] != null ? Device.fromJson(json['TRKR-00092']) : null;
//     tRKR00093 =
//         json['TRKR-00093'] != null ? Device.fromJson(json['TRKR-00093']) : null;
//     tRKR00094 =
//         json['TRKR-00094'] != null ? Device.fromJson(json['TRKR-00094']) : null;
//     tRKR00095 =
//         json['TRKR-00095'] != null ? Device.fromJson(json['TRKR-00095']) : null;
//     tRKR00096 =
//         json['TRKR-00096'] != null ? Device.fromJson(json['TRKR-00096']) : null;
//     tRKR00097 =
//         json['TRKR-00097'] != null ? Device.fromJson(json['TRKR-00097']) : null;
//     tRKR00098 =
//         json['TRKR-00098'] != null ? Device.fromJson(json['TRKR-00098']) : null;
//     tRKR00099 =
//         json['TRKR-00099'] != null ? Device.fromJson(json['TRKR-00099']) : null;
//     tRKR00180 =
//         json['TRKR-00180'] != null ? Device.fromJson(json['TRKR-00180']) : null;
//     tRKR00060 =
//         json['TRKR-00060'] != null ? Device.fromJson(json['TRKR-00060']) : null;
//     tRKR00181 =
//         json['TRKR-00181'] != null ? Device.fromJson(json['TRKR-00181']) : null;
//     tRKR00061 =
//         json['TRKR-00061'] != null ? Device.fromJson(json['TRKR-00061']) : null;
//     tRKR00182 =
//         json['TRKR-00182'] != null ? Device.fromJson(json['TRKR-00182']) : null;
//     tRKR00183 =
//         json['TRKR-00183'] != null ? Device.fromJson(json['TRKR-00183']) : null;
//     tRKR00062 =
//         json['TRKR-00062'] != null ? Device.fromJson(json['TRKR-00062']) : null;
//     tRKR00063 =
//         json['TRKR-00063'] != null ? Device.fromJson(json['TRKR-00063']) : null;
//     tRKR00184 =
//         json['TRKR-00184'] != null ? Device.fromJson(json['TRKR-00184']) : null;
//     tRKR00064 =
//         json['TRKR-00064'] != null ? Device.fromJson(json['TRKR-00064']) : null;
//     tRKR00185 =
//         json['TRKR-00185'] != null ? Device.fromJson(json['TRKR-00185']) : null;
//     tRKR00065 =
//         json['TRKR-00065'] != null ? Device.fromJson(json['TRKR-00065']) : null;
//     tRKR00186 =
//         json['TRKR-00186'] != null ? Device.fromJson(json['TRKR-00186']) : null;
//     tRKR00066 =
//         json['TRKR-00066'] != null ? Device.fromJson(json['TRKR-00066']) : null;
//     tRKR00187 =
//         json['TRKR-00187'] != null ? Device.fromJson(json['TRKR-00187']) : null;
//     tRKR00067 =
//         json['TRKR-00067'] != null ? Device.fromJson(json['TRKR-00067']) : null;
//     tRKR00188 =
//         json['TRKR-00188'] != null ? Device.fromJson(json['TRKR-00188']) : null;
//     tRKR00189 =
//         json['TRKR-00189'] != null ? Device.fromJson(json['TRKR-00189']) : null;
//     tRKR00068 =
//         json['TRKR-00068'] != null ? Device.fromJson(json['TRKR-00068']) : null;
//     tRKR00069 =
//         json['TRKR-00069'] != null ? Device.fromJson(json['TRKR-00069']) : null;
//     tRKR00190 =
//         json['TRKR-00190'] != null ? Device.fromJson(json['TRKR-00190']) : null;
//     tRKR00191 =
//         json['TRKR-00191'] != null ? Device.fromJson(json['TRKR-00191']) : null;
//     tRKR00070 =
//         json['TRKR-00070'] != null ? Device.fromJson(json['TRKR-00070']) : null;
//     tRKR00192 =
//         json['TRKR-00192'] != null ? Device.fromJson(json['TRKR-00192']) : null;
//     tRKR00071 =
//         json['TRKR-00071'] != null ? Device.fromJson(json['TRKR-00071']) : null;
//     tRKR00193 =
//         json['TRKR-00193'] != null ? Device.fromJson(json['TRKR-00193']) : null;
//     tRKR00072 =
//         json['TRKR-00072'] != null ? Device.fromJson(json['TRKR-00072']) : null;
//     tRKR00194 =
//         json['TRKR-00194'] != null ? Device.fromJson(json['TRKR-00194']) : null;
//     tRKR00073 =
//         json['TRKR-00073'] != null ? Device.fromJson(json['TRKR-00073']) : null;
//     tRKR00074 =
//         json['TRKR-00074'] != null ? Device.fromJson(json['TRKR-00074']) : null;
//     tRKR00195 =
//         json['TRKR-00195'] != null ? Device.fromJson(json['TRKR-00195']) : null;
//     tRKR00075 =
//         json['TRKR-00075'] != null ? Device.fromJson(json['TRKR-00075']) : null;
//     tRKR00196 =
//         json['TRKR-00196'] != null ? Device.fromJson(json['TRKR-00196']) : null;
//     tRKR00076 =
//         json['TRKR-00076'] != null ? Device.fromJson(json['TRKR-00076']) : null;
//     tRKR00197 =
//         json['TRKR-00197'] != null ? Device.fromJson(json['TRKR-00197']) : null;
//     tRKR00077 =
//         json['TRKR-00077'] != null ? Device.fromJson(json['TRKR-00077']) : null;
//     tRKR00198 =
//         json['TRKR-00198'] != null ? Device.fromJson(json['TRKR-00198']) : null;
//     tRKR00078 =
//         json['TRKR-00078'] != null ? Device.fromJson(json['TRKR-00078']) : null;
//     tRKR00199 =
//         json['TRKR-00199'] != null ? Device.fromJson(json['TRKR-00199']) : null;
//     tRKR00079 =
//         json['TRKR-00079'] != null ? Device.fromJson(json['TRKR-00079']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.tRKR00200 != null) {
//       data['TRKR-00200'] = this.tRKR00200!.toJson();
//     }
//     if (this.tRKR00201 != null) {
//       data['TRKR-00201'] = this.tRKR00201!.toJson();
//     }
//     if (this.tRKR00202 != null) {
//       data['TRKR-00202'] = this.tRKR00202!.toJson();
//     }
//     if (this.tRKR00203 != null) {
//       data['TRKR-00203'] = this.tRKR00203!.toJson();
//     }
//     if (this.tRKR00204 != null) {
//       data['TRKR-00204'] = this.tRKR00204!.toJson();
//     }
//     if (this.tRKR00205 != null) {
//       data['TRKR-00205'] = this.tRKR00205!.toJson();
//     }
//     if (this.tRKR00206 != null) {
//       data['TRKR-00206'] = this.tRKR00206!.toJson();
//     }
//     if (this.tRKR00207 != null) {
//       data['TRKR-00207'] = this.tRKR00207!.toJson();
//     }
//     if (this.tRKR00208 != null) {
//       data['TRKR-00208'] = this.tRKR00208!.toJson();
//     }
//     if (this.tRKR00209 != null) {
//       data['TRKR-00209'] = this.tRKR00209!.toJson();
//     }
//     if (this.tRKR00120 != null) {
//       data['TRKR-00120'] = this.tRKR00120!.toJson();
//     }
//     if (this.tRKR00121 != null) {
//       data['TRKR-00121'] = this.tRKR00121!.toJson();
//     }
//     if (this.tRKR00001 != null) {
//       data['TRKR-00001'] = this.tRKR00001!.toJson();
//     }
//     if (this.tRKR00122 != null) {
//       data['TRKR-00122'] = this.tRKR00122!.toJson();
//     }
//     if (this.tRKR00002 != null) {
//       data['TRKR-00002'] = this.tRKR00002!.toJson();
//     }
//     if (this.tRKR00123 != null) {
//       data['TRKR-00123'] = this.tRKR00123!.toJson();
//     }
//     if (this.tRKR00003 != null) {
//       data['TRKR-00003'] = this.tRKR00003!.toJson();
//     }
//     if (this.tRKR00124 != null) {
//       data['TRKR-00124'] = this.tRKR00124!.toJson();
//     }
//     if (this.tRKR00125 != null) {
//       data['TRKR-00125'] = this.tRKR00125!.toJson();
//     }
//     if (this.tRKR00004 != null) {
//       data['TRKR-00004'] = this.tRKR00004!.toJson();
//     }
//     if (this.tRKR00126 != null) {
//       data['TRKR-00126'] = this.tRKR00126!.toJson();
//     }
//     if (this.tRKR00005 != null) {
//       data['TRKR-00005'] = this.tRKR00005!.toJson();
//     }
//     if (this.tRKR00127 != null) {
//       data['TRKR-00127'] = this.tRKR00127!.toJson();
//     }
//     if (this.tRKR00006 != null) {
//       data['TRKR-00006'] = this.tRKR00006!.toJson();
//     }
//     if (this.tRKR00007 != null) {
//       data['TRKR-00007'] = this.tRKR00007!.toJson();
//     }
//     if (this.tRKR00128 != null) {
//       data['TRKR-00128'] = this.tRKR00128!.toJson();
//     }
//     if (this.tRKR00008 != null) {
//       data['TRKR-00008'] = this.tRKR00008!.toJson();
//     }
//     if (this.tRKR00129 != null) {
//       data['TRKR-00129'] = this.tRKR00129!.toJson();
//     }
//     if (this.tRKR00009 != null) {
//       data['TRKR-00009'] = this.tRKR00009!.toJson();
//     }
//     if (this.tRKR00130 != null) {
//       data['TRKR-00130'] = this.tRKR00130!.toJson();
//     }
//     if (this.tRKR00010 != null) {
//       data['TRKR-00010'] = this.tRKR00010!.toJson();
//     }
//     if (this.tRKR00131 != null) {
//       data['TRKR-00131'] = this.tRKR00131!.toJson();
//     }
//     if (this.tRKR00011 != null) {
//       data['TRKR-00011'] = this.tRKR00011!.toJson();
//     }
//     if (this.tRKR00132 != null) {
//       data['TRKR-00132'] = this.tRKR00132!.toJson();
//     }
//     if (this.tRKR00012 != null) {
//       data['TRKR-00012'] = this.tRKR00012!.toJson();
//     }
//     if (this.tRKR00133 != null) {
//       data['TRKR-00133'] = this.tRKR00133!.toJson();
//     }
//     if (this.tRKR00013 != null) {
//       data['TRKR-00013'] = this.tRKR00013!.toJson();
//     }
//     if (this.tRKR00134 != null) {
//       data['TRKR-00134'] = this.tRKR00134!.toJson();
//     }
//     if (this.tRKR00014 != null) {
//       data['TRKR-00014'] = this.tRKR00014!.toJson();
//     }
//     if (this.tRKR00135 != null) {
//       data['TRKR-00135'] = this.tRKR00135!.toJson();
//     }
//     if (this.tRKR00136 != null) {
//       data['TRKR-00136'] = this.tRKR00136!.toJson();
//     }
//     if (this.tRKR00015 != null) {
//       data['TRKR-00015'] = this.tRKR00015!.toJson();
//     }
//     if (this.tRKR00016 != null) {
//       data['TRKR-00016'] = this.tRKR00016!.toJson();
//     }
//     if (this.tRKR00137 != null) {
//       data['TRKR-00137'] = this.tRKR00137!.toJson();
//     }
//     if (this.tRKR00138 != null) {
//       data['TRKR-00138'] = this.tRKR00138!.toJson();
//     }
//     if (this.tRKR00017 != null) {
//       data['TRKR-00017'] = this.tRKR00017!.toJson();
//     }
//     if (this.tRKR00139 != null) {
//       data['TRKR-00139'] = this.tRKR00139!.toJson();
//     }
//     if (this.tRKR00018 != null) {
//       data['TRKR-00018'] = this.tRKR00018!.toJson();
//     }
//     if (this.tRKR00019 != null) {
//       data['TRKR-00019'] = this.tRKR00019!.toJson();
//     }
//     if (this.tRKR00100 != null) {
//       data['TRKR-00100'] = this.tRKR00100!.toJson();
//     }
//     if (this.tRKR00101 != null) {
//       data['TRKR-00101'] = this.tRKR00101!.toJson();
//     }
//     if (this.tRKR00102 != null) {
//       data['TRKR-00102'] = this.tRKR00102!.toJson();
//     }
//     if (this.tRKR00103 != null) {
//       data['TRKR-00103'] = this.tRKR00103!.toJson();
//     }
//     if (this.tRKR00104 != null) {
//       data['TRKR-00104'] = this.tRKR00104!.toJson();
//     }
//     if (this.tRKR00105 != null) {
//       data['TRKR-00105'] = this.tRKR00105!.toJson();
//     }
//     if (this.tRKR00106 != null) {
//       data['TRKR-00106'] = this.tRKR00106!.toJson();
//     }
//     if (this.tRKR00107 != null) {
//       data['TRKR-00107'] = this.tRKR00107!.toJson();
//     }
//     if (this.tRKR00108 != null) {
//       data['TRKR-00108'] = this.tRKR00108!.toJson();
//     }
//     if (this.tRKR00109 != null) {
//       data['TRKR-00109'] = this.tRKR00109!.toJson();
//     }
//     if (this.tRKR00110 != null) {
//       data['TRKR-00110'] = this.tRKR00110!.toJson();
//     }
//     if (this.tRKR00111 != null) {
//       data['TRKR-00111'] = this.tRKR00111!.toJson();
//     }
//     if (this.tRKR00112 != null) {
//       data['TRKR-00112'] = this.tRKR00112!.toJson();
//     }
//     if (this.tRKR00113 != null) {
//       data['TRKR-00113'] = this.tRKR00113!.toJson();
//     }
//     if (this.tRKR00114 != null) {
//       data['TRKR-00114'] = this.tRKR00114!.toJson();
//     }
//     if (this.tRKR00115 != null) {
//       data['TRKR-00115'] = this.tRKR00115!.toJson();
//     }
//     if (this.tRKR00116 != null) {
//       data['TRKR-00116'] = this.tRKR00116!.toJson();
//     }
//     if (this.tRKR00117 != null) {
//       data['TRKR-00117'] = this.tRKR00117!.toJson();
//     }
//     if (this.tRKR00118 != null) {
//       data['TRKR-00118'] = this.tRKR00118!.toJson();
//     }
//     if (this.tRKR00119 != null) {
//       data['TRKR-00119'] = this.tRKR00119!.toJson();
//     }
//     if (this.tRKR00160 != null) {
//       data['TRKR-00160'] = this.tRKR00160!.toJson();
//     }
//     if (this.tRKR00161 != null) {
//       data['TRKR-00161'] = this.tRKR00161!.toJson();
//     }
//     if (this.tRKR00040 != null) {
//       data['TRKR-00040'] = this.tRKR00040!.toJson();
//     }
//     if (this.tRKR00162 != null) {
//       data['TRKR-00162'] = this.tRKR00162!.toJson();
//     }
//     if (this.tRKR00041 != null) {
//       data['TRKR-00041'] = this.tRKR00041!.toJson();
//     }
//     if (this.tRKR00163 != null) {
//       data['TRKR-00163'] = this.tRKR00163!.toJson();
//     }
//     if (this.tRKR00042 != null) {
//       data['TRKR-00042'] = this.tRKR00042!.toJson();
//     }
//     if (this.tRKR00164 != null) {
//       data['TRKR-00164'] = this.tRKR00164!.toJson();
//     }
//     if (this.tRKR00043 != null) {
//       data['TRKR-00043'] = this.tRKR00043!.toJson();
//     }
//     if (this.tRKR00044 != null) {
//       data['TRKR-00044'] = this.tRKR00044!.toJson();
//     }
//     if (this.tRKR00165 != null) {
//       data['TRKR-00165'] = this.tRKR00165!.toJson();
//     }
//     if (this.tRKR00045 != null) {
//       data['TRKR-00045'] = this.tRKR00045!.toJson();
//     }
//     if (this.tRKR00166 != null) {
//       data['TRKR-00166'] = this.tRKR00166!.toJson();
//     }
//     if (this.tRKR00046 != null) {
//       data['TRKR-00046'] = this.tRKR00046!.toJson();
//     }
//     if (this.tRKR00167 != null) {
//       data['TRKR-00167'] = this.tRKR00167!.toJson();
//     }
//     if (this.tRKR00047 != null) {
//       data['TRKR-00047'] = this.tRKR00047!.toJson();
//     }
//     if (this.tRKR00168 != null) {
//       data['TRKR-00168'] = this.tRKR00168!.toJson();
//     }
//     if (this.tRKR00048 != null) {
//       data['TRKR-00048'] = this.tRKR00048!.toJson();
//     }
//     if (this.tRKR00169 != null) {
//       data['TRKR-00169'] = this.tRKR00169!.toJson();
//     }
//     if (this.tRKR00049 != null) {
//       data['TRKR-00049'] = this.tRKR00049!.toJson();
//     }
//     if (this.tRKR00170 != null) {
//       data['TRKR-00170'] = this.tRKR00170!.toJson();
//     }
//     if (this.tRKR00171 != null) {
//       data['TRKR-00171'] = this.tRKR00171!.toJson();
//     }
//     if (this.tRKR00050 != null) {
//       data['TRKR-00050'] = this.tRKR00050!.toJson();
//     }
//     if (this.tRKR00172 != null) {
//       data['TRKR-00172'] = this.tRKR00172!.toJson();
//     }
//     if (this.tRKR00051 != null) {
//       data['TRKR-00051'] = this.tRKR00051!.toJson();
//     }
//     if (this.tRKR00052 != null) {
//       data['TRKR-00052'] = this.tRKR00052!.toJson();
//     }
//     if (this.tRKR00173 != null) {
//       data['TRKR-00173'] = this.tRKR00173!.toJson();
//     }
//     if (this.tRKR00053 != null) {
//       data['TRKR-00053'] = this.tRKR00053!.toJson();
//     }
//     if (this.tRKR00174 != null) {
//       data['TRKR-00174'] = this.tRKR00174!.toJson();
//     }
//     if (this.tRKR00175 != null) {
//       data['TRKR-00175'] = this.tRKR00175!.toJson();
//     }
//     if (this.tRKR00054 != null) {
//       data['TRKR-00054'] = this.tRKR00054!.toJson();
//     }
//     if (this.tRKR00176 != null) {
//       data['TRKR-00176'] = this.tRKR00176!.toJson();
//     }
//     if (this.tRKR00055 != null) {
//       data['TRKR-00055'] = this.tRKR00055!.toJson();
//     }
//     if (this.tRKR00177 != null) {
//       data['TRKR-00177'] = this.tRKR00177!.toJson();
//     }
//     if (this.tRKR00056 != null) {
//       data['TRKR-00056'] = this.tRKR00056!.toJson();
//     }
//     if (this.tRKR00178 != null) {
//       data['TRKR-00178'] = this.tRKR00178!.toJson();
//     }
//     if (this.tRKR00057 != null) {
//       data['TRKR-00057'] = this.tRKR00057!.toJson();
//     }
//     if (this.tRKR00058 != null) {
//       data['TRKR-00058'] = this.tRKR00058!.toJson();
//     }
//     if (this.tRKR00179 != null) {
//       data['TRKR-00179'] = this.tRKR00179!.toJson();
//     }
//     if (this.tRKR00059 != null) {
//       data['TRKR-00059'] = this.tRKR00059!.toJson();
//     }
//     if (this.tRKR00140 != null) {
//       data['TRKR-00140'] = this.tRKR00140!.toJson();
//     }
//     if (this.tRKR00141 != null) {
//       data['TRKR-00141'] = this.tRKR00141!.toJson();
//     }
//     if (this.tRKR00020 != null) {
//       data['TRKR-00020'] = this.tRKR00020!.toJson();
//     }
//     if (this.tRKR00142 != null) {
//       data['TRKR-00142'] = this.tRKR00142!.toJson();
//     }
//     if (this.tRKR00021 != null) {
//       data['TRKR-00021'] = this.tRKR00021!.toJson();
//     }
//     if (this.tRKR00143 != null) {
//       data['TRKR-00143'] = this.tRKR00143!.toJson();
//     }
//     if (this.tRKR00022 != null) {
//       data['TRKR-00022'] = this.tRKR00022!.toJson();
//     }
//     if (this.tRKR00144 != null) {
//       data['TRKR-00144'] = this.tRKR00144!.toJson();
//     }
//     if (this.tRKR00023 != null) {
//       data['TRKR-00023'] = this.tRKR00023!.toJson();
//     }
//     if (this.tRKR00145 != null) {
//       data['TRKR-00145'] = this.tRKR00145!.toJson();
//     }
//     if (this.tRKR00024 != null) {
//       data['TRKR-00024'] = this.tRKR00024!.toJson();
//     }
//     if (this.tRKR00146 != null) {
//       data['TRKR-00146'] = this.tRKR00146!.toJson();
//     }
//     if (this.tRKR00025 != null) {
//       data['TRKR-00025'] = this.tRKR00025!.toJson();
//     }
//     if (this.tRKR00147 != null) {
//       data['TRKR-00147'] = this.tRKR00147!.toJson();
//     }
//     if (this.tRKR00026 != null) {
//       data['TRKR-00026'] = this.tRKR00026!.toJson();
//     }
//     if (this.tRKR00148 != null) {
//       data['TRKR-00148'] = this.tRKR00148!.toJson();
//     }
//     if (this.tRKR00027 != null) {
//       data['TRKR-00027'] = this.tRKR00027!.toJson();
//     }
//     if (this.tRKR00028 != null) {
//       data['TRKR-00028'] = this.tRKR00028!.toJson();
//     }
//     if (this.tRKR00149 != null) {
//       data['TRKR-00149'] = this.tRKR00149!.toJson();
//     }
//     if (this.tRKR00029 != null) {
//       data['TRKR-00029'] = this.tRKR00029!.toJson();
//     }
//     if (this.tRKR00150 != null) {
//       data['TRKR-00150'] = this.tRKR00150!.toJson();
//     }
//     if (this.tRKR00030 != null) {
//       data['TRKR-00030'] = this.tRKR00030!.toJson();
//     }
//     if (this.tRKR00151 != null) {
//       data['TRKR-00151'] = this.tRKR00151!.toJson();
//     }
//     if (this.tRKR00152 != null) {
//       data['TRKR-00152'] = this.tRKR00152!.toJson();
//     }
//     if (this.tRKR00031 != null) {
//       data['TRKR-00031'] = this.tRKR00031!.toJson();
//     }
//     if (this.tRKR00153 != null) {
//       data['TRKR-00153'] = this.tRKR00153!.toJson();
//     }
//     if (this.tRKR00032 != null) {
//       data['TRKR-00032'] = this.tRKR00032!.toJson();
//     }
//     if (this.tRKR00033 != null) {
//       data['TRKR-00033'] = this.tRKR00033!.toJson();
//     }
//     if (this.tRKR00154 != null) {
//       data['TRKR-00154'] = this.tRKR00154!.toJson();
//     }
//     if (this.tRKR00034 != null) {
//       data['TRKR-00034'] = this.tRKR00034!.toJson();
//     }
//     if (this.tRKR00155 != null) {
//       data['TRKR-00155'] = this.tRKR00155!.toJson();
//     }
//     if (this.tRKR00035 != null) {
//       data['TRKR-00035'] = this.tRKR00035!.toJson();
//     }
//     if (this.tRKR00156 != null) {
//       data['TRKR-00156'] = this.tRKR00156!.toJson();
//     }
//     if (this.tRKR00036 != null) {
//       data['TRKR-00036'] = this.tRKR00036!.toJson();
//     }
//     if (this.tRKR00157 != null) {
//       data['TRKR-00157'] = this.tRKR00157!.toJson();
//     }
//     if (this.tRKR00037 != null) {
//       data['TRKR-00037'] = this.tRKR00037!.toJson();
//     }
//     if (this.tRKR00158 != null) {
//       data['TRKR-00158'] = this.tRKR00158!.toJson();
//     }
//     if (this.tRKR00159 != null) {
//       data['TRKR-00159'] = this.tRKR00159!.toJson();
//     }
//     if (this.tRKR00038 != null) {
//       data['TRKR-00038'] = this.tRKR00038!.toJson();
//     }
//     if (this.tRKR00039 != null) {
//       data['TRKR-00039'] = this.tRKR00039!.toJson();
//     }
//     if (this.tRKR00080 != null) {
//       data['TRKR-00080'] = this.tRKR00080!.toJson();
//     }
//     if (this.tRKR00081 != null) {
//       data['TRKR-00081'] = this.tRKR00081!.toJson();
//     }
//     if (this.tRKR00082 != null) {
//       data['TRKR-00082'] = this.tRKR00082!.toJson();
//     }
//     if (this.tRKR00083 != null) {
//       data['TRKR-00083'] = this.tRKR00083!.toJson();
//     }
//     if (this.tRKR00084 != null) {
//       data['TRKR-00084'] = this.tRKR00084!.toJson();
//     }
//     if (this.tRKR00085 != null) {
//       data['TRKR-00085'] = this.tRKR00085!.toJson();
//     }
//     if (this.tRKR00086 != null) {
//       data['TRKR-00086'] = this.tRKR00086!.toJson();
//     }
//     if (this.tRKR00087 != null) {
//       data['TRKR-00087'] = this.tRKR00087!.toJson();
//     }
//     if (this.tRKR00088 != null) {
//       data['TRKR-00088'] = this.tRKR00088!.toJson();
//     }
//     if (this.tRKR00089 != null) {
//       data['TRKR-00089'] = this.tRKR00089!.toJson();
//     }
//     if (this.tRKR00090 != null) {
//       data['TRKR-00090'] = this.tRKR00090!.toJson();
//     }
//     if (this.tRKR00091 != null) {
//       data['TRKR-00091'] = this.tRKR00091!.toJson();
//     }
//     if (this.tRKR00092 != null) {
//       data['TRKR-00092'] = this.tRKR00092!.toJson();
//     }
//     if (this.tRKR00093 != null) {
//       data['TRKR-00093'] = this.tRKR00093!.toJson();
//     }
//     if (this.tRKR00094 != null) {
//       data['TRKR-00094'] = this.tRKR00094!.toJson();
//     }
//     if (this.tRKR00095 != null) {
//       data['TRKR-00095'] = this.tRKR00095!.toJson();
//     }
//     if (this.tRKR00096 != null) {
//       data['TRKR-00096'] = this.tRKR00096!.toJson();
//     }
//     if (this.tRKR00097 != null) {
//       data['TRKR-00097'] = this.tRKR00097!.toJson();
//     }
//     if (this.tRKR00098 != null) {
//       data['TRKR-00098'] = this.tRKR00098!.toJson();
//     }
//     if (this.tRKR00099 != null) {
//       data['TRKR-00099'] = this.tRKR00099!.toJson();
//     }
//     if (this.tRKR00180 != null) {
//       data['TRKR-00180'] = this.tRKR00180!.toJson();
//     }
//     if (this.tRKR00060 != null) {
//       data['TRKR-00060'] = this.tRKR00060!.toJson();
//     }
//     if (this.tRKR00181 != null) {
//       data['TRKR-00181'] = this.tRKR00181!.toJson();
//     }
//     if (this.tRKR00061 != null) {
//       data['TRKR-00061'] = this.tRKR00061!.toJson();
//     }
//     if (this.tRKR00182 != null) {
//       data['TRKR-00182'] = this.tRKR00182!.toJson();
//     }
//     if (this.tRKR00183 != null) {
//       data['TRKR-00183'] = this.tRKR00183!.toJson();
//     }
//     if (this.tRKR00062 != null) {
//       data['TRKR-00062'] = this.tRKR00062!.toJson();
//     }
//     if (this.tRKR00063 != null) {
//       data['TRKR-00063'] = this.tRKR00063!.toJson();
//     }
//     if (this.tRKR00184 != null) {
//       data['TRKR-00184'] = this.tRKR00184!.toJson();
//     }
//     if (this.tRKR00064 != null) {
//       data['TRKR-00064'] = this.tRKR00064!.toJson();
//     }
//     if (this.tRKR00185 != null) {
//       data['TRKR-00185'] = this.tRKR00185!.toJson();
//     }
//     if (this.tRKR00065 != null) {
//       data['TRKR-00065'] = this.tRKR00065!.toJson();
//     }
//     if (this.tRKR00186 != null) {
//       data['TRKR-00186'] = this.tRKR00186!.toJson();
//     }
//     if (this.tRKR00066 != null) {
//       data['TRKR-00066'] = this.tRKR00066!.toJson();
//     }
//     if (this.tRKR00187 != null) {
//       data['TRKR-00187'] = this.tRKR00187!.toJson();
//     }
//     if (this.tRKR00067 != null) {
//       data['TRKR-00067'] = this.tRKR00067!.toJson();
//     }
//     if (this.tRKR00188 != null) {
//       data['TRKR-00188'] = this.tRKR00188!.toJson();
//     }
//     if (this.tRKR00189 != null) {
//       data['TRKR-00189'] = this.tRKR00189!.toJson();
//     }
//     if (this.tRKR00068 != null) {
//       data['TRKR-00068'] = this.tRKR00068!.toJson();
//     }
//     if (this.tRKR00069 != null) {
//       data['TRKR-00069'] = this.tRKR00069!.toJson();
//     }
//     if (this.tRKR00190 != null) {
//       data['TRKR-00190'] = this.tRKR00190!.toJson();
//     }
//     if (this.tRKR00191 != null) {
//       data['TRKR-00191'] = this.tRKR00191!.toJson();
//     }
//     if (this.tRKR00070 != null) {
//       data['TRKR-00070'] = this.tRKR00070!.toJson();
//     }
//     if (this.tRKR00192 != null) {
//       data['TRKR-00192'] = this.tRKR00192!.toJson();
//     }
//     if (this.tRKR00071 != null) {
//       data['TRKR-00071'] = this.tRKR00071!.toJson();
//     }
//     if (this.tRKR00193 != null) {
//       data['TRKR-00193'] = this.tRKR00193!.toJson();
//     }
//     if (this.tRKR00072 != null) {
//       data['TRKR-00072'] = this.tRKR00072!.toJson();
//     }
//     if (this.tRKR00194 != null) {
//       data['TRKR-00194'] = this.tRKR00194!.toJson();
//     }
//     if (this.tRKR00073 != null) {
//       data['TRKR-00073'] = this.tRKR00073!.toJson();
//     }
//     if (this.tRKR00074 != null) {
//       data['TRKR-00074'] = this.tRKR00074!.toJson();
//     }
//     if (this.tRKR00195 != null) {
//       data['TRKR-00195'] = this.tRKR00195!.toJson();
//     }
//     if (this.tRKR00075 != null) {
//       data['TRKR-00075'] = this.tRKR00075!.toJson();
//     }
//     if (this.tRKR00196 != null) {
//       data['TRKR-00196'] = this.tRKR00196!.toJson();
//     }
//     if (this.tRKR00076 != null) {
//       data['TRKR-00076'] = this.tRKR00076!.toJson();
//     }
//     if (this.tRKR00197 != null) {
//       data['TRKR-00197'] = this.tRKR00197!.toJson();
//     }
//     if (this.tRKR00077 != null) {
//       data['TRKR-00077'] = this.tRKR00077!.toJson();
//     }
//     if (this.tRKR00198 != null) {
//       data['TRKR-00198'] = this.tRKR00198!.toJson();
//     }
//     if (this.tRKR00078 != null) {
//       data['TRKR-00078'] = this.tRKR00078!.toJson();
//     }
//     if (this.tRKR00199 != null) {
//       data['TRKR-00199'] = this.tRKR00199!.toJson();
//     }
//     if (this.tRKR00079 != null) {
//       data['TRKR-00079'] = this.tRKR00079!.toJson();
//     }
//     return data;
//   }
// }

// class Device {
//   String? id;
//   String? name;
//   String? gatewayId;
//   String? roomId;

//   Device({this.id, this.name, this.gatewayId, this.roomId});

//   Device.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     gatewayId = json['gatewayId'];
//     roomId = json['roomId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['gatewayId'] = this.gatewayId;
//     data['roomId'] = this.roomId;
//     return data;
//   }

//   String? getId() {
//     return id;
//   }

//   String? getName() {
//     return name;
//   }

//   String? getGatewayId() {
//     return gatewayId;
//   }

//   String? getRoomId() {
//     return roomId;
//   }
// }
