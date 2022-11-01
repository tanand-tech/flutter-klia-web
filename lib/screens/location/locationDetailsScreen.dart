import 'dart:convert';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/location/roomLatestLog.dart';
import 'package:web_dashboard/model/location/roomTimeSpent.dart';
import 'package:web_dashboard/model/location/roomTrailLogs.dart';

import 'package:web_dashboard/service/location-api.dart' as api;
import 'package:web_dashboard/util/util.dart';

// Avoid multiple call on forceRefresh
int counterRunRefresh = 0;

class LocationDetails extends StatefulWidget {
  const LocationDetails(
      {super.key, required this.roomId, required this.roomName});
  final String roomId;
  final String roomName;

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  // Set the colors
  Color? setColorNew(String key) {
    /**
     * Actie == GREEN
     * Idle == GREY
     * Away == YELLOW
     */
    switch (key) {
      case 'active':
        return Colors.green[800];
      case 'idle':
        return Colors.grey[700];
      case 'away':
        return Colors.yellow[800];
    }
    return Colors.white;
  }

  Widget handleAvailableTime() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.green[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Available',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          FutureBuilder(
            future: getAvailableTime(widget.roomId),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                /**
                 * Assign the snapshot.data into RoomLog
                 */
                RoomLog temp = snapshot.data;

                return Text(
                  formatedTime((getTimeNow() - temp.timestamp!)),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                );
              } else {
                return const Text('Loading...');
              }
            },
          ),
        ],
      ),
    );
  }

  handleTimeSpent(List<TimeSpentPerRoom> listTimeSpent) {
    List<TimeSpentPerRoom> tempList = [];
    List<TimeSpentPerRoom> finalList = [];
    /**
     * Get total duration
     */
    int totalDuration = 0;
    for (var i in listTimeSpent) {
      TimeSpentPerRoom timeSpentPerRoom = i;
      totalDuration += timeSpentPerRoom.active! +
          timeSpentPerRoom.away! +
          timeSpentPerRoom.idle!;
      TimeSpentPerRoom temp = TimeSpentPerRoom();
      Map<String, int> tempMap = {};
      temp.contractor = timeSpentPerRoom.contractor;
      if (timeSpentPerRoom.active != 0) {
        tempMap['active'] = timeSpentPerRoom.active!;
      }
      if (timeSpentPerRoom.away != 0) {
        tempMap['away'] = timeSpentPerRoom.away!;
      }
      if (timeSpentPerRoom.idle != 0) {
        tempMap['idle'] = timeSpentPerRoom.idle!;
      }
      List convertMapToList =
          tempMap.entries.map((e) => [e.key, e.value]).toList();
      temp.overallData = convertMapToList;
      tempList.add(temp);
    }

    for (var item in tempList) {
      if (item.overallData!.length > 1) {
        for (var items in item.overallData!) {
          TimeSpentPerRoom timeSpentPerRoom = TimeSpentPerRoom();
          timeSpentPerRoom.contractor = item.contractor;
          List temp = [];
          temp.add(items);
          timeSpentPerRoom.overallData = temp;
          finalList.add(timeSpentPerRoom);
        }
      } else {
        TimeSpentPerRoom timeSpentPerRoom = TimeSpentPerRoom();
        timeSpentPerRoom.contractor = item.contractor;
        timeSpentPerRoom.overallData = item.overallData;
        finalList.add(timeSpentPerRoom);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          for (var item in finalList)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i in item.overallData!) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: SizedBox(
                        child: Text(
                          '${calculatePercentage(totalDuration, i[1]!)} %', // Time Spent
                          style: const TextStyle(
                            // fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.circle,
                          color: setColorNew(i[0]!),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.005,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        item.contractor!.name.toString(), // Status
                        style: const TextStyle(
                          // fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          child: Text(
                            formatedTime(i[1]!), // Time Spent
                            style: const TextStyle(
                              // fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Widget
  // For Second Row
  Widget rendelTimeSpentRow(List<TimeSpentPerRoom> room) {
    /**
     * Calculate the total duration
     */
    int totalDuration = 0;
    for (var item in room) {
      totalDuration += item.active! + item.idle! + item.away!;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            for (var item in room) singleRow(totalDuration, item)!,
          ],
        ),
      ),
    );
  }

  Widget? singleRow(int totalDuration, TimeSpentPerRoom room) {
    if (room.active! > 0 && room.away! > 0 && room.idle! > 0) {
      return singleRowAll(totalDuration, room);
    } else if (room.active! > 0 && room.idle! > 0) {
      return singleRowActiveAndIdle(totalDuration, room);
    } else if (room.active! > 0 && room.away! > 0) {
      return singleRowActiveAndAway(totalDuration, room);
    } else if (room.active! > 0) {
      return singleRowActive(totalDuration, room);
    }
    return null;
  }

  Widget? singleRowAll(int totalDuration, TimeSpentPerRoom room) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.active!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: const Icon(
                  Icons.circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.active!)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.away!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: const Icon(
                  Icons.circle,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.away!)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.idle!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Icon(
                  Icons.circle,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.idle!)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget? singleRowActiveAndIdle(int totalDuration, TimeSpentPerRoom room) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.active!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: const Icon(
                  Icons.circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.active!)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.idle!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Icon(
                  Icons.circle,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.idle!)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget? singleRowActiveAndAway(int totalDuration, TimeSpentPerRoom room) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.active!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: const Icon(
                  Icons.circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.active!)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(
                    '${calculatePercentage(totalDuration, room.away!).toString()} %'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: const Icon(
                  Icons.circle,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(room.contractor!.name!.toString()),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: Text(formatedTime(room.away!)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget? singleRowActive(int totalDuration, TimeSpentPerRoom room) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: Text(
                '${calculatePercentage(totalDuration, room.active!).toString()} %'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: const Icon(
              Icons.circle,
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Text(room.contractor!.name!.toString()),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: Text(formatedTime(room.active!)),
          ),
        ],
      ),
    );
  }

  // Widget
  // For Third Row
  Widget rendelTrailRow(List<TrailLog> log) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          for (var item in log.reversed) singleRowTrail(item),
        ],
      ),
    );
  }

  Widget singleRowTrail(TrailLog log) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: SizedBox(
              child: Text(
                convertTimestampToHourMinutes(log.timestamp!).toString(),
              ),
            ),
          ),
          setColor(log),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.005,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text('${log.employee!.employeeId!} ${log.employee!.name!}'),
          ),
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: (log.endTimestamp) != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      child: Text(
                        calculateDuration(log.timestamp!, log.endTimestamp!),
                      ),
                    ),
                  )
                : const Text(''),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.roomName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                handleAvailableTime(),
                // FutureBuilder(
                //     future: getAvailableTime(widget.roomId),
                //     builder: (context, AsyncSnapshot<dynamic> snapshot) {
                //       if (snapshot.hasData) {
                //         /**
                //          * Assign the snapshot.data into RoomLog
                //          */
                //         RoomLog temp = snapshot.data;

                //         /**
                //          * Very First Row
                //          * Available Time
                //          */
                //         return Container(
                //           padding:
                //               const EdgeInsets.only(left: 10.0, right: 10.0),
                //           alignment: Alignment.centerLeft,
                //           width: MediaQuery.of(context).size.width,
                //           height: 60,
                //           color: Colors.green[700],
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               const Text(
                //                 'Available',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 20,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               Text(
                //                 formatedTime((getTimeNow() - temp.timestamp!)),
                //                 style: const TextStyle(
                //                   fontSize: 20,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       } else {
                //         return const Text('Loading...');
                //       }
                //     }),

                /**
                 * Second Row
                 * Daily Summary of Cleaner of Activities
                 */
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Text(
                          'Daily summary of cleaner of activities',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      FutureBuilder(
                          future: getTimeSpentAPI(
                            widget.roomId,
                            getStartofTheDay(),
                            getTimeNow(),
                          ),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              List<TimeSpentPerRoom> temp = snapshot.data;
                              if (temp.isEmpty) {
                                return const Text('No data found');
                              }
                              return handleTimeSpent(temp);
                            } else {
                              return const Text('Loading...');
                            }
                          }),
                    ]),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Text(
                          'Daily trail logs',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      FutureBuilder(
                          future: getTrailLogsFromAPI(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              List<TrailLog> temp = snapshot.data;
                              if (temp.isEmpty) {
                                return const Text('No data found');
                              }
                              return rendelTrailRow(temp);
                            } else {
                              return const Text('Loading...');
                            }
                          }),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // API Functions
  Future<RoomLog?> getAvailableTime(roomId) async {
    http.Response res = await api.getRoomLatestLog(roomId);
    if (res.statusCode == 200) {
      RoomLatestLog data = RoomLatestLog.fromJson(jsonDecode(res.body));
      RoomLog result = data.data!;
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
        }
      }
    }
    return null;
  }

  // Get Data from API
  Future<List<TimeSpentPerRoom>?> getTimeSpentAPI(roomId, start, end) async {
    http.Response res = await api.getRoomTimeSpent(roomId, start, end);
    if (res.statusCode == 200) {
      RoomTimeSpent data = RoomTimeSpent.fromJson(jsonDecode(res.body));
      List<TimeSpentPerRoom> result = data.data!;
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
        }
      }
    }
    return null;
  }

  Future<List<TrailLog>> getTrailLogsFromAPI() async {
    List<TrailLog> logs = [];
    await getRoomTrailLogs(
      widget.roomId,
      getStartofTheDay(),
      getTimeNow(),
    ).then((value) async {
      // debugPrint(
      //     'RoomId : ${widget.roomId}, startTime: ${getStartofTheDay()} , endTime: $getTimeNow()');
      logs = value!;
      logs = await manipulateTrailLogs(logs);
      /**
       * Sort the list according to the timestamp
       */
      logs.sort(((a, b) => a.timestamp!.compareTo(b.timestamp!)));
      return logs;
    });
    return logs;
  }

  Future<List<TrailLog>?> getRoomTrailLogs(roomId, start, end) async {
    http.Response res = await api.getRoomTrailLogs(roomId, start, end);
    if (res.statusCode == 200) {
      RoomTrailLogs data = RoomTrailLogs.fromJson(jsonDecode(res.body));
      List<TrailLog> result = data.data!;
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
        }
      }
    }
    return null;
  }

  // passing ascending order de log from oldest timestamp till latest
  Future<List<TrailLog>> manipulateTrailLogs(List<TrailLog> logs) async {
    print('before adding: ${logs.length}');
    Map<String, List<TrailLog>> map = groupBy(logs, (obj) {
      return obj.employee!.id.toString();
    });
    List<List<TrailLog>> result = [];
    List<TrailLog> finalData = [];
    map.forEach((key, value) {
      List<TrailLog> temp = [value[0]];
      if (value.length == 1) {
        if (value[0].endTimestamp != null) {
          TrailLog newLog = TrailLog();
          newLog.employee = value[0].employee;
          newLog.room = value[0].room;
          newLog.timestamp = value[0].endTimestamp;
          newLog.status = 'away';
          temp.add(newLog);
          print(
              'the last one: ${newLog.employee!.employeeId} : ${newLog.timestamp}');
        }
      }
      for (var i = 1; i < value.length; i++) {
        int startTime = value[i - 1].endTimestamp!;
        int endTime = value[i].timestamp!;
        if (endTime - startTime != 0) {
          TrailLog newLog = TrailLog();
          newLog.employee = value[i].employee;
          newLog.room = value[i].room;
          newLog.timestamp = startTime;
          newLog.status = 'away';
          temp.add(newLog);
        }
        if (i == value.length - 1) {
          if (value[i].endTimestamp != null) {
            TrailLog newLog = TrailLog();
            newLog.employee = value[i].employee;
            newLog.room = value[i].room;
            newLog.timestamp = value[i].endTimestamp;
            newLog.status = 'away';
            temp.add(newLog);
            print(
                'the last one: ${newLog.employee!.employeeId} : ${newLog.timestamp}');
          }
        }
        temp.add(value[i]);
      }
      // var timeNow = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
      result.add(temp);
    });
    print(result.length);

    for (var i = 0; i < result.length; i++) {
      finalData += result[i];
    }

    return finalData;
  }

// Functions
  Widget setColor(TrailLog log) {
    if (log.status! == 'active') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.10,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.circle,
            color: Colors.green,
          ),
        ),
      );
    } else if (log.status! == 'idle') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.10,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.circle,
            color: Colors.grey[700],
          ),
        ),
      );
    } else if (log.status! == 'away') {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.10,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.circle,
            color: Colors.yellow[700],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.10,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.circle,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
