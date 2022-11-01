// import 'dart:async';
// import 'dart:convert';

// import 'package:expandable/expandable.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:web_dashboard/model/download%20copy.dart';
// import 'package:web_dashboard/model/location.dart';
// import 'package:web_dashboard/model/trailLogs.dart';
// import 'package:web_dashboard/screens/locationDetailsScreen.dart';
// import 'package:web_dashboard/sharedPreference/sharedPreferences.dart';

// import '../service/location-api.dart' as api;

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});

//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   final staticData = sharedPreference.staticDataSP;
//   List<Location> result = [];

//   // Get the data for the first row of the screen
//   Future<dynamic> getData() async {
//     print("getting data for shortage and ...");
//     http.Response res = await api.getRoomsStatusCount();
//     if (res.statusCode == 200) {
//       Location location = Location.fromJson(jsonDecode(res.body));
//       return location;
//     }
//     return null;
//   }

//   Future<Map<String, Location>> getBlockData() async {
//     Map<String, Location> locations = {};
//     List<String?> siteId = [];
//     List<String?> siteName = [];
//     staticData.blocks?.forEach((element) {
//       siteId.add(element.id);
//     });
//     staticData.blocks?.forEach((element) {
//       siteName.add(element.name);
//     });
//     for (var element in siteId) {
//       http.Response res = await api.getRoomsStatusCountByBlock(element);
//       if (res.statusCode == 200) {
//         Location location = Location.fromJson(jsonDecode(res.body));
//         // siteName[siteId.indexOf(element)] -> just to get the siteName instead of siteId
//         locations[siteName[siteId.indexOf(element)]!] = location;
//         print('added $element');
//       }
//     }
//     return locations;
//   }

//   Future<Map<String, List<DataTG>>> getBlockList() async {
//     Map<String, List<DataTG>> result = {};
//     List<DataTG>? dataTG = [];
//     List<String?> siteId = [];
//     List<String?> siteName = [];
//     List<Rooms>? rooms = staticData.rooms;

//     staticData.blocks?.forEach((element) {
//       siteId.add(element.id);
//     });
//     staticData.blocks?.forEach((element) {
//       siteName.add(element.name);
//     });
//     for (var element in siteId) {
//       http.Response res = await api.getTrailLogsGroupByRoomsByBlock(element);
//       if (res.statusCode == 200) {
//         TrailLogsGroup trailLogsGroup =
//             TrailLogsGroup.fromJson(jsonDecode(res.body));
//         dataTG = trailLogsGroup.data;

//         var m = Map();
//         for (var r in rooms!) {
//           m[r.id] = r.name;
//         }
//         for (var i = 0; i < dataTG!.length; i++) {
//           dataTG[i].name = m[dataTG[i].id];
//         }
//         result[siteName[siteId.indexOf(element)]!] = dataTG;
//       }
//     }
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
//           child: SizedBox(
//             height: 68,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   width: 0.23 * MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2.0),
//                     color: Colors.red,
//                   ),
//                   child: Column(
//                     children: [
//                       FutureBuilder(
//                         future: getData(),
//                         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                           if (snapshot.hasData) {
//                             Location location = snapshot.data;
//                             return Text(
//                               (location.data?.shortage).toString(),
//                               style: const TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           } else {
//                             return const Text(
//                               'Loading...',
//                               overflow: TextOverflow.fade,
//                               softWrap: false,
//                               style: TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const Text(
//                         "Shortage",
//                         overflow: TextOverflow.fade,
//                         softWrap: false,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 0.23 * MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2.0),
//                     color: Colors.orange[400],
//                   ),
//                   child: Column(
//                     children: [
//                       FutureBuilder(
//                         future: getData(),
//                         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                           if (snapshot.hasData) {
//                             Location location = snapshot.data;
//                             return Text(
//                               (location.data?.oversupply).toString(),
//                               style: const TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           } else {
//                             return const Text(
//                               'Loading...',
//                               overflow: TextOverflow.fade,
//                               softWrap: false,
//                               style: TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const Text(
//                         "Oversupply",
//                         overflow: TextOverflow.fade,
//                         softWrap: false,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 0.23 * MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2.0),
//                     color: Colors.green[900],
//                   ),
//                   child: Column(
//                     children: [
//                       FutureBuilder(
//                         future: getData(),
//                         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                           if (snapshot.hasData) {
//                             Location location = snapshot.data;
//                             return Text(
//                               (location.data?.normal).toString(),
//                               style: const TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           } else {
//                             return const Text(
//                               'Loading...',
//                               overflow: TextOverflow.fade,
//                               softWrap: false,
//                               style: TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const Text(
//                         "Normal",
//                         overflow: TextOverflow.fade,
//                         softWrap: false,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 0.23 * MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2.0),
//                     color: Colors.grey[800],
//                   ),
//                   child: Column(
//                     children: [
//                       FutureBuilder(
//                         future: getData(),
//                         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//                           if (snapshot.hasData) {
//                             Location location = snapshot.data;
//                             return Text(
//                               (location.data?.unavailable).toString(),
//                               style: const TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           } else {
//                             return const Text(
//                               'Loading...',
//                               overflow: TextOverflow.fade,
//                               softWrap: false,
//                               style: TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.white,
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       const Text(
//                         "N/A",
//                         overflow: TextOverflow.fade,
//                         softWrap: false,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         FutureBuilder(
//           future: getBlockData(),
//           builder: (context, AsyncSnapshot<dynamic> snapshot) {
//             if (snapshot.hasData) {
//               Map<String, Location> locations = snapshot.data;
//               return _renderPanel(locations);
//             } else {
//               return const Text(
//                 'Loading...',
//                 overflow: TextOverflow.fade,
//                 softWrap: false,
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//               );
//             }
//           },
//         ),
//       ],
//     ));
//   }

//   Widget _renderPanel(Map<String, Location> locations) {
//     return ListView(
//       padding: EdgeInsets.zero,
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       children: [
//         for (MapEntry<String, Location> e in locations.entries) singleBlock(e),
//       ],
//     );
//   }

//   Widget singleBlock(MapEntry<String, Location> locations) {
//     locations = MapEntry("dasdsa", locations.value);
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: Container(
//         width: double.infinity,
//         color: Colors.grey[350],
//         child: ExpandableNotifier(
//           initialExpanded: false,
//           child: ExpandablePanel(
//             header: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         locations.key,
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         locations.value.data!.shortage.toString(),
//                         style: const TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         locations.value.data!.oversupply.toString(),
//                         style: TextStyle(
//                           color: Colors.yellow[800],
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         locations.value.data!.normal.toString(),
//                         style: TextStyle(
//                           color: Colors.green[800],
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         locations.value.data!.unavailable.toString(),
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             collapsed: Container(
//               color: Colors.white,
//               width: MediaQuery.of(context).size.width,
//             ),
//             expanded: Container(
//               color: Colors.white,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           textStyle: const TextStyle(fontSize: 20),
//                         ),
//                         onPressed: () {
//                           showAlertDialog(context, locations.key);
//                         },
//                         child: const Text('Show Details'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             theme: const ExpandableThemeData(
//               tapHeaderToExpand: true,
//               tapBodyToExpand: false,
//               tapBodyToCollapse: false,
//               headerAlignment: ExpandablePanelHeaderAlignment.center,
//               hasIcon: true,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void sortList(List<DataTG> dataList) {
//     Map<String, int> setStatus = {
//       "shortage": 0,
//       "oversupply": 1,
//       "normal": 2,
//       "N/A": 3,
//       "offline": 4
//     };
//     for (var i = 0; i < dataList.length; i++) {
//       dataList[i].statusName = setStatus[dataList[i].status].toString();
//     }
//     dataList.sort(
//       ((a, b) {
//         int sortStatus = a.statusName!.compareTo(b.statusName!);
//         if (sortStatus == 0) {
//           return (a.name!.compareTo(b.name!));
//         }
//         return sortStatus;
//       }),
//     );
//   }

//   showAlertDialog(BuildContext context, String name) {
//     Map<String, List<DataTG>> data = {};

//     // set up the buttons
//     Widget cancelButton = TextButton(
//       child: const Text("Cancel"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = TextButton(
//       child: const Text("Ok"),
//       onPressed: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => const LocationDetails()),
//         // );
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(name),
//       content: FutureBuilder(
//         future: getBlockList(),
//         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.hasData) {
//             data = snapshot.data;
//             sortList(data[name]!);
//             return SizedBox(
//               height: MediaQuery.of(context).size.height * 0.8,
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: ListView.builder(
//                   itemCount: data[name]?.length,
//                   itemBuilder: (context, position) {
//                     String roomID = data[name]![position].id.toString();
//                     String roomName = data[name]![position].name.toString();
//                     return GestureDetector(
//                       onTap: () {
//                         print(roomID);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LocationDetails(
//                                   roomId: roomID, roomName: roomName)),
//                         );
//                       },
//                       child: Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Text(
//                             "${data[name]![position].name.toString()} (${data[name]![position].status.toString()})",
//                             style: const TextStyle(fontSize: 22.0),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           } else {
//             return const Text(
//               'Loading...',
//               style: TextStyle(fontSize: 20, color: Colors.black),
//             );
//           }
//         },
//       ),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
