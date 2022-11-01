import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/model/staticData/download%20copy.dart';

// static class or global
// Initialize the SharedPreferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
final sharedPreference = SharedPreferenceConnect();

class SharedPreferenceConnect {
  Download2 staticDataSP = Download2('siteId', 'name');
  List<Rooms> roomList = [];
  final List<Zones> zoneList = [];
  final List<Blocks> blockList = [];
  final List<Locations> locationList = [];
  final List<Devices> deviceList = [];

  Future<Download2?> getDataFromSharedPreferences() async {
    final SharedPreferences preferences = await prefs;
    print('Getting static data from SharedPreferences..');
    try {
      // Null Check
      var temp = preferences.getString('staticData') ?? '{}';
      staticDataSP = Download2.fromJson(jsonDecode(temp));
      print('Got static data..');
      return staticDataSP;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  getDataFromStaticData() {
    List<Blocks>? tempBlock = staticDataSP.blocks;
    List<Zones>? tempZone = staticDataSP.zones;
    List<Locations>? tempLocation = staticDataSP.locations;
    List<Rooms>? tempRoom = staticDataSP.rooms;

    for (var i in tempRoom!) {
      roomList.add(i);
    }
    for (var i in tempLocation!) {
      Locations location = i;
      if (location.rooms != null && location.rooms!.isNotEmpty) {
        location.rooms = getRoom(roomList, location.rooms!);
      }
      locationList.add(location);
    }
    for (var i in tempZone!) {
      Zones zone = i;
      if (zone.locations != null && zone.locations!.isNotEmpty) {
        zone.locations = getLocation(locationList, zone.locations!);
      }
      zoneList.add(zone);
    }
    for (var i in tempBlock!) {
      Blocks block = i;
      if (block.zones != null && block.zones!.isNotEmpty) {
        block.zones = getZone(zoneList, block.zones!);
      }
      blockList.add(block);
      blockList.sort(
        (a, b) {
          return a.toString().compareTo(b.toString());
        },
      );
    }
    for (var room in roomList) {
      String currentLocationId = room.locationId!;
      for (var element in locationList) {
        if (element.id == currentLocationId) {
          room.locationName = element.name!;
        }
      }
    }
  }

  getRoom(List<Rooms> listRoom, List<String> listString) {
    listRoom.retainWhere((element) {
      for (var i in listString) {
        return element.id!.toLowerCase().contains(i.toLowerCase());
      }
      return false;
    });
  }

  getLocation(List<Locations> listLocation, List<String> listString) {
    listLocation.retainWhere((element) {
      for (var i in listString) {
        return element.id!.toLowerCase().contains(i.toLowerCase());
      }
      return false;
    });
  }

  getZone(List<Zones> listZone, List<String> listString) {
    listZone.retainWhere((element) {
      for (var i in listString) {
        return element.id!.toLowerCase().contains(i.toLowerCase());
      }
      return false;
    });
  }
}

// class FormattedStaticData {
//   final staticData = sharedPreference.staticDataSP;

//   getData() {
//     List<Blocks> tempBlock = staticData.blocks!;
//     List<Zones> tempZone = staticData.zones!;
//     List<Locations> tempLocation = staticData.locations!;
//     List<Rooms> tempRoom = staticData.rooms!;
//     List<Devices> tempDevice = staticData.device!;

//     for (var i in tempRoom) {
//       roomList.add(i);
//     }
//     for (var i in tempLocation) {
//       Locations location = i;
//       if (location.rooms!.isNotEmpty) {
//         location.rooms = getRoom(roomList, location.rooms!);
//       }
//       locationList.add(location);
//     }
//     for (var i in tempZone) {
//       Zones zone = i;
//       if (zone.locations!.isNotEmpty) {
//         zone.locations = getLocation(locationList, zone.locations!);
//       }
//       zoneList.add(zone);
//     }
//     for (var i in tempBlock) {
//       Blocks block = i;
//       if (block.zones!.isNotEmpty) {
//         block.zones = getZone(zoneList, block.zones!);
//       }
//       blockList.add(block);
//       blockList.sort(
//         (a, b) {
//           return a.toString().compareTo(b.toString());
//         },
//       );
//     }
//   }

//   getRoom(List<Rooms> listRoom, List<String> listString) {
//     listRoom.retainWhere((element) {
//       for (var i in listString) {
//         return element.id!.toLowerCase().contains(i.toLowerCase());
//       }
//       return false;
//     });
//   }

//   getLocation(List<Locations> listLocation, List<String> listString) {
//     listLocation.retainWhere((element) {
//       for (var i in listString) {
//         return element.id!.toLowerCase().contains(i.toLowerCase());
//       }
//       return false;
//     });
//   }

//   getZone(List<Zones> listZone, List<String> listString) {
//     listZone.retainWhere((element) {
//       for (var i in listString) {
//         return element.id!.toLowerCase().contains(i.toLowerCase());
//       }
//       return false;
//     });
//   }
// }


/** 

// Set the data in shared preferences, and geDataFromSharedPreferences method
Future<dynamic> getSiteId() async {
  final SharedPreferences preferences = await prefs;

  Download2? data = await getDataFromSharedPreferences();
  var tempSiteId = data?.siteId;
  preferences.setString('siteId', tempSiteId!);
  return tempSiteId;
}

Future<dynamic> getName() async {
  final SharedPreferences preferences = await prefs;

  Download2? data = await getDataFromSharedPreferences();
  var tempName = data?.name;
  preferences.setString('name', tempName!);
  return tempName;
}

Future<List<Block>?> getBlocks() async {
  Download2? data = await getDataFromSharedPreferences();

  List<Block>? blockList = data?.blocks;
  blockList?.forEach((element) {
    print(element);
  });
  return blockList;
}

Future<List<Block>> setBlocks() async {
  Downloads? data = await getDataFromSharedPreferences();
  List<Block> blockList = [];
  blockList.add(data?.blocks!.klia1Mtb as Block);
  blockList.add(data?.blocks!.klia1Cp as Block);
  blockList.add(data?.blocks!.klia1Sat as Block);
  // print(blockList.length);
  return blockList;
}

Future<dynamic> getBlocks() async {
  final SharedPreferences preferences = await prefs;

  Downloads? data = await getDataFromSharedPreferences();
  var tempBlocks = data?.blocks;
  print(tempBlocks);
  preferences.setString('blocks', tempBlocks.toString());
  return tempBlocks;
}

Future<dynamic> getZones() async {
  final SharedPreferences preferences = await prefs;

  Downloads? data = await getDataFromSharedPreferences();
  var tempXones = data?.zones;
  preferences.setString('zones', tempXones.toString());
  return tempXones;
}
*/
