import 'dart:convert';

import 'package:collection/collection.dart';
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

class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({
    super.key,
    required this.roomId,
    required this.roomName,
  });
  final String roomId;
  final String roomName;

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  // Get Data From API
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

  Future<List<TrailLog>> getManipulatedTrailLogsAPI() async {
    List<TrailLog> logs = [];
    await getRoomTrailLogs(
      widget.roomId,
      getStartofTheDay(),
      getTimeNow(),
    ).then((value) async {
      logs = value!;
      logs = await manipulateTrailLogs(logs);
      /**
       * Sort the list according to the timestamp (Ascending)
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

  // Passing ascending order trail log from oldest timestamp till latest
  Future<List<TrailLog>> manipulateTrailLogs(List<TrailLog> logs) async {
    /**
     * Group the list by the employee id
     */
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
        }
      }
      for (var i = 1; i < value.length; i++) {
        /**
         * |____|       |____|_____|
         *          |
         *   find the gap here
         */
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
          }
        }
        temp.add(value[i]);
      }
      result.add(temp);
    });

    for (var i = 0; i < result.length; i++) {
      finalData += result[i];
    }

    return finalData;
  }

  // Functions
  // Set the colors
  Color? setColor(String key) {
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

  // Seperate Widgets
  // First Part Widgets
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

  // Second Part Widgets
  Widget handleTimeSpent(List<TimeSpentPerRoom> listTimeSpent) {
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
                          color: setColor(i[0]!),
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

  // Third Part Widget
  Widget handleTrailLogs(List<TrailLog> trailLog) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          for (var log in trailLog.reversed) ...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: SizedBox(
                      child: Text(
                        convertTimestampToHourMinutes(log.timestamp!)
                            .toString(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.circle,
                        color: setColor(log.status!),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.005,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                        '${log.employee!.employeeId!} ${log.employee!.name!}'),
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
                                calculateDuration(
                                    log.timestamp!, log.endTimestamp!),
                              ),
                            ),
                          )
                        : const Text(''),
                  ),
                ],
              ),
            ),
          ]
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
                /**
                 * First Row
                 * Available Time
                 */
                handleAvailableTime(),
                /**
                 * Second Row
                 * Daily Summary of Cleaner Activities
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
                          'Daily summary of cleaner activities',
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
                          future: getManipulatedTrailLogsAPI(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              List<TrailLog> temp = snapshot.data;
                              if (temp.isEmpty) {
                                return const Text('No data found');
                              }
                              return handleTrailLogs(temp);
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
}
