import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_dashboard/model/cleaner/employee/employeeLatestLog.dart';
import 'package:web_dashboard/model/cleaner/employee/employeeSummary.dart';
import 'package:web_dashboard/model/cleaner/employee/employeeTimeSpent.dart';
import 'package:web_dashboard/model/cleaner/employee/employeeTrailLogs.dart';
import 'package:web_dashboard/service/location-api.dart' as api;
import 'package:web_dashboard/util/util.dart';

class CleanerDetails extends StatefulWidget {
  const CleanerDetails(
      {super.key,
      required this.id,
      required this.employeeID,
      required this.employeeName});
  final String id;
  final String employeeID;
  final String employeeName;

  @override
  State<CleanerDetails> createState() => _CleanerDetailsState();
}

class _CleanerDetailsState extends State<CleanerDetails> {
  // Widget
  // Handle First Row (Status || Time Duration)
  Widget handleLatestLog(LatestLogData latestLogData) {
    return Container(
      decoration: BoxDecoration(
        color: setColor(latestLogData.status!),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              capitalizeFirstWord(latestLogData.status!),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              calculateDuration(latestLogData.timestamp!, getTimeNow()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget
  // Handle Second Row (Active || Away || Idle || Duration for each block)
  Widget handleSummaryRow(Map<String, int> mapStatusWithTime) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 1,
          ),
          for (var status in mapStatusWithTime.keys)
            Column(
              children: [
                /**
                 * If there is no duration
                 * Display - h - m
                 * else
                 * Display ? h ? m
                 */
                if (formatedTime(mapStatusWithTime[status]!) ==
                    '00 h 00 m') ...[
                  const Text(
                    ' - h - m ', // Time Spent
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ] else ...[
                  Text(
                    formatedTime(mapStatusWithTime[status]!), // Time Spent
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
                Text(
                  capitalizeFirstWord(status), // Status
                  style: TextStyle(
                    fontSize: 20,
                    color: setColor(status),
                  ),
                ),
              ],
            ),
          const SizedBox(
            width: 1,
          ),
        ],
      ),
    );
  }

  // Widget
  // Handle Third Row
  Widget handleTimeSpentRow(List<EmployeeTSData> employeeTSList) {
    /**
     * Get total duration
     */
    int totalDuration = 0;
    for (var i in employeeTSList) {
      totalDuration += i.duration!;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          for (var employeeTS in employeeTSList)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Text(
                      '${calculatePercentage(totalDuration, employeeTS.duration!)} %', // Time Spent
                      style: const TextStyle(
                        // fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Icon(
                      Icons.circle,
                      color: setColor(employeeTS.status!),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text(
                      capitalizeFirstWord(employeeTS.status!), // Status
                      style: const TextStyle(
                        // fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Text(
                      formatedTime(employeeTS.duration!), // Time Spent
                      style: const TextStyle(
                        // fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Widget
  // Handle Forth Row
  Widget handleTrailLogsRow(List<TrailLogsCleaners> trailLogList) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          for (var item in trailLogList.reversed)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Text(
                      convertTimestampToHourMinutes(item.timestamp!).toString(),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Icon(
                      Icons.circle,
                      color: setColor(item.status!),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text(capitalizeFirstWord(item.status!)),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: (item.endTimestamp) != null
                        ? Text(calculateDuration(
                            item.timestamp!, item.endTimestamp!))
                        : const Text(''),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Widget
  // Show When API is not working well
  Widget loadingText() {
    return const Text(
      'Loading...',
      overflow: TextOverflow.fade,
      softWrap: false,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

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

  // Get Data from API
  Future<LatestLogData> getEmployeeLatestLogAPI() async {
    http.Response res = await api.getEmployeeLatestLog(widget.id);
    EmployeeLatestLog employeeLatestLog =
        EmployeeLatestLog.fromJson(jsonDecode(res.body));
    LatestLogData latestLogData = employeeLatestLog.data!;
    return latestLogData;
  }

  Future<EmployeeCleaner> getEmployeeSummaryAPI() async {
    http.Response res = await api.getEmployeeSummary(
        widget.id, getStartofTheDay(), getTimeNow());
    EmployeeSummary employeeSummary =
        EmployeeSummary.fromJson(jsonDecode(res.body));
    EmployeeCleaner employee = employeeSummary.data!;
    return employee;
  }

  Future<List<EmployeeTSData>> getEmployeeTimeSpentAPI() async {
    http.Response res = await api.getEmployeeTimeSpent(
        widget.id, getStartofTheDay(), getTimeNow());
    EmployeeTimeSpent employeeTimeSpent =
        EmployeeTimeSpent.fromJson(jsonDecode(res.body));
    List<EmployeeTSData> employeeTSData = employeeTimeSpent.data!;
    return employeeTSData;
  }

  Future<List<TrailLogsCleaners>?> getEmployeeTrailLogsAPI() async {
    http.Response res = await api.getEmployeeTrailLogs(
        widget.id, getStartofTheDay(), getTimeNow());
    EmployeeTrailLogs employeeTrailLogs =
        EmployeeTrailLogs.fromJson(jsonDecode(res.body));
    List<TrailLogsCleaners> trailLogsList = employeeTrailLogs.data!;
    return trailLogsList;
  }

  Future<List<TrailLogsCleaners>> getTrailLogsFromAPI() async {
    List<TrailLogsCleaners> logs = [];
    await getEmployeeTrailLogsAPI().then((value) async {
      logs = value!;
      logs = await manipulateTrailLogsCleaners(logs);
      logs.sort(((a, b) => a.timestamp!.compareTo(b.timestamp!)));
      return logs;
    });
    return logs;
  }

  // Function for API
  // passing ascending order log from oldest timestamp till latest
  Future<List<TrailLogsCleaners>> manipulateTrailLogsCleaners(
      List<TrailLogsCleaners> logs) async {
    /**
         * Group the List by the employee id
         */
    Map<String, List<TrailLogsCleaners>> map = groupBy(logs, (obj) {
      return obj.employee!.id.toString();
    });
    List<List<TrailLogsCleaners>> result = [];
    List<TrailLogsCleaners> finalData = [];
    map.forEach((key, value) {
      List<TrailLogsCleaners> temp = [value[0]];
      /**
       * If the list.length == 1
       */
      if (value.length == 1) {
        if (value[0].endTimestamp != null) {
          TrailLogsCleaners newLog = TrailLogsCleaners();
          newLog.employee = value[0].employee;
          newLog.room = value[0].room;
          newLog.timestamp = value[0].endTimestamp;
          newLog.status = 'away';
          temp.add(newLog);
        }
      }
      for (var i = 1; i < value.length; i++) {
        int startTime = value[i - 1].endTimestamp!;
        int endTime = value[i].timestamp!;
        if (endTime - startTime != 0) {
          TrailLogsCleaners newLog = TrailLogsCleaners();
          newLog.employee = value[i].employee;
          newLog.room = value[i].room;
          newLog.timestamp = startTime;
          newLog.status = 'away';
          temp.add(newLog);
        }
        if (i == value.length - 1) {
          if (value[i].endTimestamp != null) {
            TrailLogsCleaners newLog = TrailLogsCleaners();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.id} ${widget.employeeName}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.fade,
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
                FutureBuilder(
                  /**
                   * First Row
                   */
                  future: getEmployeeLatestLogAPI(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      LatestLogData latestLogData = snapshot.data!;
                      return handleLatestLog(latestLogData);
                    }
                    return loadingText();
                  },
                ),
                Container(
                  /**
                   * Second Row
                   */
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: Colors.white,
                  child: FutureBuilder(
                    future: getEmployeeSummaryAPI(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        EmployeeCleaner employeeCleaner = snapshot.data!;
                        Map<String, int> mapStatusWithTime = {};
                        mapStatusWithTime['active'] = employeeCleaner.active!;
                        mapStatusWithTime['away'] = employeeCleaner.away!;
                        mapStatusWithTime['idle'] = employeeCleaner.idle!;

                        return handleSummaryRow(mapStatusWithTime);
                      }
                      return loadingText();
                    },
                  ),
                ),
                SizedBox(
                  /**
                   * Third Row
                   */
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
                          'Daily summary of time spent',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      FutureBuilder(
                        future: getEmployeeTimeSpentAPI(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            List<EmployeeTSData> employeeTSList =
                                snapshot.data!;

                            return handleTimeSpentRow(employeeTSList);
                          }
                          return loadingText();
                        },
                      ),
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
                            List<TrailLogsCleaners> trailLogList =
                                snapshot.data!;

                            return handleTrailLogsRow(trailLogList);
                          }
                          return const Text('data');
                        },
                      ),
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
