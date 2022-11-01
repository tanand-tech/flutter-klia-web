import 'dart:async';
import 'dart:convert';

import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/instance/mqtt/mqttManager.dart';
import 'package:web_dashboard/model/location/OverallLocation.dart';
import 'package:web_dashboard/model/location/trailLogs.dart';
import 'package:web_dashboard/model/staticData/download%20copy.dart';
import 'package:web_dashboard/notifier/notifierManager.dart';
import 'package:web_dashboard/homeScreen.dart';
import 'package:web_dashboard/screens/location/locationDetailsScreen2.dart';
import 'package:web_dashboard/service/location-api.dart' as api;
import 'package:web_dashboard/util/util.dart';

// Initialize the SharedPreferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

// Overall Locations MQTT Topic Name
const String statusTopicName = 'klia-1/status/count/rooms';
// Specific Locations MQTT Topic Name
const String mtbStatusTopicName = 'klia-1/klia-1-mtb/status/count/rooms';
const String cpStatusTopicName = 'klia-1/klia-1-cp/status/count/rooms';
const String satStatusTopicName = 'klia-1/klia-1-sat/status/count/rooms';

// Avoid multiple call on forceRefresh
int counterRunRefresh = 0;

// Counter on MQTT
// Avoid listen multiple times
int counterMqttLS = 1;

// Set default key
// Should remove before deploy / build
final searchTextController = TextEditingController(text: "");

// Search Function
final TextEditingController searchFieldController = TextEditingController();
String searchLocation = '';
String valueText = '';
final List<Rooms> roomList = [];
final List<Zones> zoneList = [];
final List<Blocks> blockList = [];
final List<Locations> locationList = [];
final List<Devices> deviceList = [];

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    /**
     * Only listen to the entire notifier once
     */
    if (counterMqttLS == 1) {
      context.read<TextNotifier>().getPayload();
      context.read<UniversalNotifier>().getPayload();
      counterMqttLS++;
    }
    super.initState();
  }

  @override
  void dispose() {
    /**
     * Unsubscribe all the topic subscribed in the Location Screen
     */
    mqttManager.unsubscribeTopic(statusTopicName);
    mqttManager.unsubscribeTopic(mtbStatusTopicName);
    mqttManager.unsubscribeTopic(cpStatusTopicName);
    mqttManager.unsubscribeTopic(satStatusTopicName);
    super.dispose();
  }

  // API Functions
  Future<dynamic> getOverallData() async {
    /**
     * First Row of the screen 
     * Red / Yellow / Green / Grey
     * Shortage / Oversupply / Normal / Unavailable 
     */
    http.Response res = await api.getRoomsStatusCount();
    if (res.statusCode == 200) {
      OverallLocation location = OverallLocation.fromJson(jsonDecode(res.body));
      OverallLocationData result = location.data!;
      return result;
    }
    if (res.statusCode == 403) {
      counterRunRefresh++;
      if (counterRunRefresh == 1) {
        debugPrint('Refreshing the idToken...');
        Map<String, String> refreshingToken = {};
        if (context.mounted) {
          refreshingToken =
              await refreshTokenDueLongPeriod.forceRefresh(context);
        }
        if (refreshingToken.containsKey('hasRefresh')) {
          setState(() {
            counterRunRefresh = 0;
          });
        } else {
          debugPrint(
              'Could not get the refresh token in the shared preferences..');
          debugPrint('Cannot refresh the id token');
          // Should we direct the user to the login screen?
        }
      }
    }
    return null;
  }

  Future<Map<String, OverallLocation>> getBlockData() async {
    Map<String, OverallLocation> locations = {};
    List<String?> siteId = [];
    List<String?> siteName = [];
    staticDataHS.blocks?.forEach((element) {
      siteId.add(element.id);
      siteName.add(element.name);
    });
    /** 
     * element === blockId
     */
    for (var element in siteId) {
      http.Response res = await api.getRoomsStatusCountByBlock(element);
      if (res.statusCode == 200) {
        OverallLocation location =
            OverallLocation.fromJson(jsonDecode(res.body));
        location.siteId = element;
        /**
         * Map all the data into each key and value
         * siteName[siteId.indexOf(element)] -> just to get the siteName instead of siteId
         * {"MTB":{"status":"OK","message":"Successful","siteId":"klia-1-mtb","data":{"normal":62,"oversupply":1,"shortage":16,"unavailable":1}}}
         */
        locations[siteName[siteId.indexOf(element)]!] = location;
      }
      if (res.statusCode == 403) {
        counterRunRefresh++;
        if (counterRunRefresh == 1) {
          debugPrint('Refreshing the idToken...');
          Map<String, String> refreshingToken = {};
          if (context.mounted) {
            refreshingToken =
                await refreshTokenDueLongPeriod.forceRefresh(context);
          }
          if (refreshingToken.containsKey('hasRefresh')) {
            setState(() {
              counterRunRefresh = 0;
            });
          } else {
            debugPrint(
                'Could not get the refresh token in the shared preferences..');
            debugPrint('Cannot refresh the id token');
          }
        }
      }
    }
    return locations;
  }

  Future<Map<String, List<DataTG>>> getBlockList() async {
    Map<String, List<DataTG>> result = {};
    List<DataTG>? dataTG = [];
    List<String?> siteId = [];
    List<String?> siteName = [];
    List<Rooms>? rooms = staticDataHS.rooms;

    staticDataHS.blocks?.forEach((element) {
      siteId.add(element.id);
      siteName.add(element.name);
    });
    /** 
     * element === blockId
     */
    for (var element in siteId) {
      http.Response res = await api.getTrailLogsGroupByRoomsByBlock(element);
      if (res.statusCode == 200) {
        TrailLogsGroup trailLogsGroup =
            TrailLogsGroup.fromJson(jsonDecode(res.body));
        dataTG = trailLogsGroup.data;

        var m = {};
        for (var r in rooms!) {
          m[r.id] = r.name;
        }
        for (var i = 0; i < dataTG!.length; i++) {
          dataTG[i].name = m[dataTG[i].id];
        }
        result[siteName[siteId.indexOf(element)]!] = dataTG;
      }
      if (res.statusCode == 403) {
        counterRunRefresh++;
        if (counterRunRefresh == 1) {
          debugPrint('Refreshing the idToken...');
          Map<String, String> refreshingToken = {};
          if (context.mounted) {
            refreshingToken =
                await refreshTokenDueLongPeriod.forceRefresh(context);
          }
          if (refreshingToken.containsKey('hasRefresh')) {
            setState(() {
              counterRunRefresh = 0;
            });
          } else {
            debugPrint(
                'Could not get the refresh token in the shared preferences..');
            debugPrint('Cannot refresh the id token');
          }
        }
      }
    }
    return result;
  }

  // Functions
  // Overall Data
  OverallLocationData rebuildData(String data) {
    OverallLocationData finalData =
        OverallLocationData.fromJson(jsonDecode(data));
    return finalData;
  }

  List dataMapping(OverallLocationData data) {
    Map<String, int> dataMapping = {
      'Shortage': data.shortage!,
      'Oversupply': data.oversupply!,
      'Normal': data.normal!,
      'Unavailable': data.unavailable!
    };
    List listData = dataMapping.entries
        .map(
          (e) => [e.key, e.value],
        )
        .toList();
    return listData;
  }

  // Set the color depends on the type of the data
  Color? setColor(String key) {
    /**
     * Shortage - RED
     * Oversupply - YELLOW
     * Normal - GREEN
     * Unavailable - GREY
     */
    if (key == 'Shortage') {
      return Colors.red;
    } else if (key == 'Oversupply') {
      return Colors.orange[400];
    } else if (key == 'Normal') {
      return Colors.green[900];
    } else {
      return Colors.grey[800];
    }
  }

  // Sort the list
  // Accending Format
  sortList(List<DataTG> dataList) {
    Map<String, int> setStatus = {
      "shortage": 0,
      "oversupply": 1,
      "normal": 2,
      "N/A": 3,
      "offline": 4
    };
    for (var i = 0; i < dataList.length; i++) {
      dataList[i].statusName = setStatus[dataList[i].status].toString();
    }
    dataList.sort(
      ((a, b) {
        int sortStatus = a.statusName!.compareTo(b.statusName!);
        if (sortStatus == 0) {
          return (a.name!.compareTo(b.name!));
        }
        return sortStatus;
      }),
    );
  }

  // Widget
  // Overall Locations
  Widget renderRowBlock(String jsonString) {
    /**
     * To assign a start value into consumer for the first time only
     */
    int counterNotifier = 1;
    return Consumer<TextNotifier>(
      builder: (context, notifier, child) {
        /**
         * Assign the data from API to the payload 
         * Only for the first time
         */
        if (counterNotifier == 1) {
          notifier.statusPayload = jsonString;
          counterNotifier++;
        }

        /**
         * Decode the string (notifier.statusPayload) make it as a new object (OverallLocationData)
         * Map all the data into each key and value and convert to a list to make it easy to display
         */
        OverallLocationData rebuidResult = rebuildData(notifier.statusPayload);
        List listData = dataMapping(rebuidResult);

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /**
               * Using a for loop to build a block with specific data (OverallLocationData)
               * 
               * for(var data in listData)
               *  print(data)
               * 
               * [Shortage, 1]
               * [Oversupply, 2]
               * [Normal, 3]
               * [Unavailable, 4]
               */
              for (var data in listData) singleRowBlock(data),
            ],
          ),
        );
      },
    );
  }

  // Each Overall Locations Data
  Widget singleRowBlock(List data) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: setColor(data[0]),
          ),
          child: Column(
            children: [
              Text(
                (data[1]).toString(),
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                capitalizeFirstWord(data[0].toString()),
                overflow: TextOverflow.visible,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget
// Second Row to the Last Row
  Widget renderPanel(Map<String, OverallLocation> locations) {
    // Subscribe to the Specific Locations Mqtt topic
    for (var element in locations.keys) {
      String topic = 'klia-1/${locations[element]!.siteId}/status/count/rooms';
      if (clientNew.getSubscriptionsStatus(topic) ==
          MqttSubscriptionStatus.doesNotExist) {
        mqttManager.subscribeTopic(topic);
      }
    }

    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        /**
         * Loop through the Map to build each row 
         */
        for (MapEntry<String, OverallLocation> e in locations.entries)
          singleBlock(e),
      ],
    );
  }

  Widget singleBlock(MapEntry<String, OverallLocation> locations) {
    /**
     * To assign a start value into consumer for the first time only
     */
    int counterNotifier = 1;

    /**
     * Get the block name form the Map Entry
     */
    String blockName = locations.key;

    return Consumer<TextNotifier>(
      builder: (context, notifier, child) {
        /**
         * Assign the data from API to the payload 
         * Only for the first time
         */
        switch (blockName) {
          /**
           * Decode the string (notifier.?Payload) make it as a new object (OverallLocationData)
           * Map all the data into each key and value 
           */
          case 'MTB':
            {
              if (counterNotifier == 1) {
                if (locations.value.data.toString().isNotEmpty) {
                  notifier.mtbPayload = locations.value.data.toString();
                  counterNotifier++;
                } else {
                  notifier.mtbPayload =
                      '{"normal":0,"oversupply":0,"shortage":0,"unavailable":0}';
                  counterNotifier++;
                }
              }

              OverallLocationData data = OverallLocationData.fromJson(
                  jsonDecode(notifier.getMTBPayload));
              OverallLocation finalResult = OverallLocation();
              finalResult.data = data;
              /**
               * Assign back to the original Map after get the data from API
               */
              locations = MapEntry(locations.key, finalResult);
              break;
            }
          case 'CP':
            {
              if (counterNotifier == 1) {
                if (locations.value.data.toString().isNotEmpty) {
                  notifier.cpPayload = locations.value.data.toString();
                  counterNotifier++;
                } else {
                  notifier.cpPayload =
                      '{"normal":0,"oversupply":0,"shortage":0,"unavailable":0}';
                  counterNotifier++;
                }
              }
              OverallLocationData data = OverallLocationData.fromJson(
                  jsonDecode(notifier.getCPPayload));
              OverallLocation finalResult = OverallLocation();
              finalResult.data = data;
              /**
               * Assign back to the original Map after get the data from API
               */
              locations = MapEntry(locations.key, finalResult);
              break;
            }
          case 'SAT':
            {
              if (counterNotifier == 1) {
                if (locations.value.data.toString().isNotEmpty) {
                  notifier.satPayload = locations.value.data.toString();
                  counterNotifier++;
                } else {
                  notifier.satPayload =
                      '{"normal":0,"oversupply":0,"shortage":0,"unavailable":0}';
                  counterNotifier++;
                }
              }
              OverallLocationData data = OverallLocationData.fromJson(
                  jsonDecode(notifier.getSATPayload));
              OverallLocation finalResult = OverallLocation();
              finalResult.data = data;
              /**
               * Assign back to the original Map after get the data from API
               */
              locations = MapEntry(locations.key, finalResult);
              break;
            }
        }

        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[350],
            child: ExpandableNotifier(
              initialExpanded: false,
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locations.key,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            child: Center(
                              child: Text(
                                locations.value.data!.shortage.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Center(
                              child: Text(
                                locations.value.data!.oversupply.toString(),
                                style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Center(
                              child: Text(
                                locations.value.data!.normal.toString(),
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Center(
                              child: Text(
                                locations.value.data!.unavailable.toString(),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                collapsed: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                ),
                expanded: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              showLocationsDetails(context, locations.key);
                            },
                            child: const Text('Show Details'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                theme: const ExpandableThemeData(
                  tapHeaderToExpand: true,
                  tapBodyToExpand: false,
                  tapBodyToCollapse: false,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget
  // Display the Search Box
  Future<void> displaySearchBox(BuildContext context) async {
    getDataFromStaticDataLS();
    /**
     * Set up the buttons for search box
     * Cancel Button && Ok Button
     */
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        setState(() {
          searchLocation = valueText;
          Navigator.pop(context);
        });
        List<Rooms> roomTempList = [];
        for (var element in roomList) {
          if (element.name!
              .toLowerCase()
              .contains(searchLocation.toLowerCase())) {
            roomTempList.add(element);
          }
        }
        if (roomTempList.isNotEmpty) {
          print("not getting here?");
          showAlertDialogForSearching(context, roomTempList);
        } else {
          print('but here?');
        }
        print("User typed :: $searchLocation");
      },
    );

    /**
     * Set up the AlertDialog
     */
    AlertDialog alert = AlertDialog(
      title: const Text('Search'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 15,
                  left: 15,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                    print(valueText);
                  },
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Search Location...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  // Alert Dialog for Search Result
  showAlertDialogForSearching(BuildContext context, List<Rooms> listRoom) {
    /**
     * Sort the list of room in accending order
     */
    listRoom.sort(
      (a, b) {
        return a.roomId.toString().compareTo(b.roomId.toString());
      },
    );

    /**
     * Set up the buttons for search result
     * Cancel Button
     */
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    /**
     * Set up the AlertDialog
     */
    AlertDialog alert = AlertDialog(
      title: const Text('Search Result'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView.builder(
            itemCount: listRoom.length,
            itemBuilder: (context, position) {
              String roomID = listRoom[position].id.toString();
              String roomName = listRoom[position].name.toString();
              return GestureDetector(
                onTap: () {
                  debugPrint("RoomID Clicked by User :: $roomID");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationDetailsScreen(
                            roomId: roomID, roomName: roomName)),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "${listRoom[position].name.toString()} (${listRoom[position].locationName.toString()})",
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
              );
            }),
      ),
      actions: [
        cancelButton,
      ],
    );

    /**
     * Display the dialog out 
     */
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Widget
  // Show Location Details
  showLocationsDetails(BuildContext context, String name) {
    Map<String, List<DataTG>> data = {};

    /**
     * Set up the buttons for search box
     * Cancel Button && Ok Button
     */
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    /**
     * Set up the AlertDialog
     */
    AlertDialog alert = AlertDialog(
      title: Text(name),
      content: FutureBuilder(
        future: getBlockList(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            /**
             * Assign the snapshot.data into Map<String, List<DataTG>>
             */
            data = snapshot.data;
            /**
             * Sort the list in accending form
             */
            sortList(data[name]!);

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                  itemCount: data[name]?.length,
                  itemBuilder: (context, position) {
                    String roomID = data[name]![position].id.toString();
                    String roomName = data[name]![position].name.toString();
                    return GestureDetector(
                      onTap: () {
                        debugPrint("RoomID Clicked by User :: $roomID");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationDetailsScreen(
                                  roomId: roomID, roomName: roomName)),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "${data[name]![position].name.toString()} (${data[name]![position].status.toString()})",
                            style: const TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return loadingText();
          }
        },
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    /**
     * Display the dialog out 
     */
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Widget
  // Show When API is not working well
  Widget loadingText() {
    return const Text(
      'Loading...',
      overflow: TextOverflow.visible,
      softWrap: false,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  Widget loadingSpecificRow() {
    OverallLocationData data = OverallLocationData.fromJson(
        jsonDecode('{"normal":0,"oversupply":0,"shortage":0,"unavailable":0}'));
    OverallLocation finalData = OverallLocation();
    finalData.data = data;
    Map<String, OverallLocation> locations = {
      "MTB": finalData,
      "CP": finalData,
      "SAT": finalData
    };

    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        /**
         * Loop through the Map to build each row
         */
        for (MapEntry<String, OverallLocation> e in locations.entries)
          singleBlock(e),
      ],
    );
  }

  Widget loadingRowBlock() {
    Map<String, int> dataMapping = {
      'Shortage': 0,
      'Oversupply': 0,
      'Normal': 0,
      'Unavailable': 0
    };
    List listData = dataMapping.entries
        .map(
          (e) => [e.key, e.value],
        )
        .toList();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var data in listData) singleRowBlock(data),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Subscribe to the Overall Location Mqtt topic
     */
    if (clientNew.getSubscriptionsStatus(statusTopicName) ==
        MqttSubscriptionStatus.doesNotExist) {
      mqttManager.subscribeTopic(statusTopicName);
    }

    context.watch<UniversalNotifier>().siteIdFromStaticData;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Location',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // SearchBox;
                displaySearchBox(context);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: FutureBuilder(
                  future: getOverallData(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      /**
                       * Assign the snapshot.data into OverallLocationData
                       * Encode the data and pass the string to following function
                       */
                      OverallLocationData data = snapshot.data;
                      String jsonStringData = jsonEncode(data);
                      return renderRowBlock(jsonStringData);
                    }
                    return loadingRowBlock();
                  },
                ),
              ),
              FutureBuilder(
                future: getBlockData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    /**
                     * Assign the snapshot.data into Map<String, OverallLocation>
                     */
                    Map<String, OverallLocation> locations = snapshot.data;
                    return renderPanel(locations);
                  } else {
                    return loadingSpecificRow();
                  }
                },
              ),
            ],
          ),
        ));
  }

  getDataFromStaticDataLS() {
    List<Blocks>? tempBlock = staticDataHS.blocks;
    List<Zones>? tempZone = staticDataHS.zones;
    List<Locations>? tempLocation = staticDataHS.locations;
    List<Rooms>? tempRoom = staticDataHS.rooms;

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
