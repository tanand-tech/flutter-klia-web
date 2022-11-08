import 'dart:convert';

import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:web_dashboard/instance/forceRefresh/refreshTokenDueLongPeriod.dart';
import 'package:web_dashboard/model/cleaner/cleaners.dart';
import 'package:web_dashboard/model/cleaner/cleanersChart.dart';
import 'package:web_dashboard/model/cleaner/employee/employee.dart';
import 'package:web_dashboard/screens/cleaner/cleanerDetails.dart';
import 'package:web_dashboard/util/util.dart';

import '../../service/location-api.dart' as api;

// Initialize the SharedPreferences
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

// For API used
// Page limit
int paginationLimit = 50;

// Declare the search type
enum SearchCleanerType { ICorPassport, Name }

// Employee Site
List<Employees> employeeList = [];
List<Employees> fullEmployeeList = [];
int totalEmployee = 0;

// Search Function
final TextEditingController searchFieldController = TextEditingController();
String searchContractor = '';
String searchCleaner = '';
String searchCleanerTypeInString = '';
String valueText = '';
Map<String, List<Employees>> groupEmployeeList = {};

// Avoid multiple call on forceRefresh
int counterRunRefresh = 0;

class CleanerScrren extends StatefulWidget {
  const CleanerScrren({super.key});

  @override
  State<CleanerScrren> createState() => _CleanerScrrenState();
}

class _CleanerScrrenState extends State<CleanerScrren> {
  SearchCleanerType? searchCleanerType = SearchCleanerType.ICorPassport;

  @override
  void initState() {
    groupEmployeeListBySite();
    super.initState();
  }

  // API Functions
  // For search functions
  groupEmployeeListBySite() async {
    int page = 0;
    int tempTotalEmployee = 0;
    await getEmployeeListBySite(page).then((value) {
      tempTotalEmployee = value!.total!;
      return employeeList = value.employees!;
    });
    /**
     * Make a small recursion to get all the employee list
     * To avoid crashing of server due to huge data fetching from API
     */
    await getFullEmployeeList(page, employeeList.length, tempTotalEmployee);
    /** 
     * Group the list by contractor name
     */
    groupEmployeeList = groupBy(employeeList, (obj) => obj.contractor!.name!);
  }

  // Functions
  // Make a small recursion to get the full list of employee
  getFullEmployeeList(
      int currentPage, int currentTotalEmployee, int tempTotalEmployee) async {
    currentPage++;
    if (currentTotalEmployee < tempTotalEmployee) {
      await getEmployeeListBySite(currentPage)
          .then((value) => employeeList.addAll(value!.employees!));
      return getFullEmployeeList(
          currentPage, employeeList.length, tempTotalEmployee);
    }
  }

  // API Functions
  // For the search purpose
  Future<EmployeeDetails?> getEmployeeListBySite(int page) async {
    http.Response res = await api.getEmployeeListBySite(page, paginationLimit);
    if (res.statusCode == 200) {
      EmployeeSite employeeSite = EmployeeSite.fromJson(jsonDecode(res.body));
      EmployeeDetails employeeDetails = employeeSite.data!;
      totalEmployee = employeeDetails.total!;
      return employeeDetails;
    }
    return null;
  }

  // For the First Row Data
  Future<Cleaners?> getData() async {
    http.Response res = await api.getStatusCount();
    if (res.statusCode == 200) {
      Cleaners cleaners = Cleaners.fromJson(jsonDecode(res.body));
      return cleaners;
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

  Future<List<CleanersChartData>?> getActiveCleanersChartData() async {
    http.Response res = await api.getContractorStatusCount();
    if (res.statusCode == 200) {
      CleanersChart cleanersChart =
          CleanersChart.fromJson(jsonDecode(res.body));
      List<CleanersChartData> data = cleanersChart.data!;
      return data;
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

  // Functions
  // Format the status data
  Map<String, int> formatStatusData(CleanerData data) {
    Map<String, int> result = {};
    result['Active'] = data.active!;
    result['Idle'] = data.idle!;
    result['On duty'] = (data.active! + data.idle!);
    result['Away'] = data.away!;
    return result;
  }

  // Functions
  // Group By Contractor Name
  Map<String, double> formatContractorsData(
      List<CleanersChartData> cleanersChart, String chartType) {
    double RGData = 0, TMGData = 0, AMSData = 0, AdeccoData = 0;
    switch (chartType) {
      case 'Active':
        {
          if (cleanersChart[0].contractor!.name == 'RG') {
            RGData = (cleanersChart[0].active)?.toDouble() as double;
          }
          if (cleanersChart[1].contractor!.name == 'TMR') {
            TMGData = (cleanersChart[1].active)?.toDouble() as double;
          }
          if (cleanersChart[2].contractor!.name == 'AMS') {
            AMSData = (cleanersChart[2].active)?.toDouble() as double;
          }
          if (cleanersChart[3].contractor!.name == 'Adecco') {
            AdeccoData = (cleanersChart[3].active)?.toDouble() as double;
          }
          break;
        }
      case 'Idle':
        {
          if (cleanersChart[0].contractor!.name == 'RG') {
            RGData = (cleanersChart[0].idle)?.toDouble() as double;
          }
          if (cleanersChart[1].contractor!.name == 'TMR') {
            TMGData = (cleanersChart[1].idle)?.toDouble() as double;
          }
          if (cleanersChart[2].contractor!.name == 'AMS') {
            AMSData = (cleanersChart[2].idle)?.toDouble() as double;
          }
          if (cleanersChart[3].contractor!.name == 'Adecco') {
            AdeccoData = (cleanersChart[3].idle)?.toDouble() as double;
          }
          break;
        }
    }
    double total = RGData + TMGData + AMSData + AdeccoData;
    Map<String, double> finalData = {};
    finalData['RGData'] = RGData;
    finalData['TMGData'] = TMGData;
    finalData['AMSData'] = AMSData;
    finalData['AdeccoData'] = AdeccoData;
    finalData['total'] = total;
    return finalData;
  }

  // Widget
  // Alert Details in Alert Dialog
  showAlertDialogForSearchingInCleaner(
      BuildContext context, List<Employees> listCleaners) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
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
            itemCount: listCleaners.length,
            itemBuilder: (context, position) {
              String id = listCleaners[position].id!.toString();
              String employeeId = listCleaners[position].employeeId!.toString();
              String employeeName = listCleaners[position].name!.toString();
              return GestureDetector(
                onTap: () {
                  debugPrint(
                      "Cleaner's details clicked :: $id - $employeeId - $employeeName");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CleanerDetails(
                              id: id,
                              employeeID: employeeId,
                              employeeName: employeeName,
                            )),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                '${listCleaners[position].employeeId.toString()} ${listCleaners[position].name.toString()}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  overflow: TextOverflow.fade,
                                ),
                                minFontSize: 14.0,
                              ),
                              Text(
                                listCleaners[position]
                                    .contractor!
                                    .contractorId!
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          capitalizeFirstWord(
                              listCleaners[position].status.toString()),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: setColorCleanersDetails(
                                listCleaners[position].status.toString()),
                          ),
                        ),
                      ],
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Widget
  // Search Box in Alert Dialog
  Widget dialogSearchBox(BuildContext context) {
    List<Employees> result = [];
    /**
     * Set up the buttons for search box
     * Cancel Button && Ok Button
     */
    Widget showAll = TextButton(
      onPressed: () {
        showAlertDialogForSearchingInCleaner(context, employeeList);
      },
      style: TextButton.styleFrom(alignment: Alignment.centerLeft),
      child: const Text("Show All"),
    );

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
        switch (searchCleanerType) {
          case SearchCleanerType.ICorPassport:
            {
              setState(() {
                searchCleanerTypeInString = 'IC or Passport';
              });
            }
            break;
          case SearchCleanerType.Name:
            {
              setState(() {
                searchCleanerTypeInString = 'Name';
              });
            }
            break;
          default:
            searchCleanerTypeInString = 'IC or Passport';
            break;
        }

        if (searchContractor.isEmpty && searchCleaner.isEmpty) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(showSnackBar("Please enter a text."));
        } else {
          List<Employees> tempEmployeeList = [];
          for (var companyName in groupEmployeeList.keys) {
            if (companyName.toLowerCase() == searchContractor.toLowerCase() ||
                companyName
                    .toLowerCase()
                    .contains(searchContractor.toLowerCase())) {
              tempEmployeeList = groupEmployeeList[companyName]!;
              break;
            } else {
              // Show error message on snack bar
              ScaffoldMessenger.of(context)
                  .showSnackBar(showSnackBar("Company not found."));
              break;
            }
          }

          switch (searchCleanerTypeInString) {
            case 'IC or Passport':
              {
                result = tempEmployeeList.where((element) {
                  return element.identity!
                              .toString()
                              .replaceAll(RegExp('[^0-9]'), '') ==
                          searchCleaner ||
                      element.identity == searchCleaner ||
                      element.identity!.contains(searchCleaner);
                }).toList();
                if (result.isEmpty) {
                  setState(() {
                    Navigator.pop(context);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(showSnackBar("No data found."));
                }
                break;
              }
            case 'Name':
              {
                result = tempEmployeeList.where((element) {
                  return element.name!.toLowerCase() ==
                          searchCleaner.toLowerCase() ||
                      element.name!.toLowerCase() ==
                          searchCleaner.toLowerCase() ||
                      element.name!
                          .toLowerCase()
                          .contains(searchCleaner.toLowerCase());
                }).toList();
                if (result.isEmpty) {
                  setState(() {
                    Navigator.pop(context);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(showSnackBar("No data found."));
                }
                break;
              }
            default:
          }

          if (result.isNotEmpty) {
            showAlertDialogForSearchingInCleaner(context, result);
          }
        }
      },
    );

    /**
     * Set up the AlertDialog and return as a Widget
     */
    return AlertDialog(
      title: const Text('Search'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 280,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 15, left: 15),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      searchContractor = value;
                    });
                  },
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Search Contractor...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Container(
                width: 150.0,
                height: 1.0,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 15,
                  left: 15,
                  bottom: 20,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      searchCleaner = value;
                    });
                  },
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Search Cleaner...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ListTile(
                  title: const Text(
                    'I/C or Passport',
                    style: TextStyle(
                      fontSize: 13,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  leading: Radio<SearchCleanerType>(
                    value: SearchCleanerType.ICorPassport,
                    groupValue: searchCleanerType,
                    onChanged: (SearchCleanerType? value) {
                      setState(() {
                        searchCleanerType = value;
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ListTile(
                  title: const Text(
                    'Name',
                    style:
                        TextStyle(overflow: TextOverflow.visible, fontSize: 14),
                  ),
                  leading: Radio<SearchCleanerType>(
                    value: SearchCleanerType.Name,
                    groupValue: searchCleanerType,
                    onChanged: (SearchCleanerType? value) {
                      setState(() {
                        searchCleanerType = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showAll,
            Row(
              children: [
                cancelButton,
                continueButton,
              ],
            ),
          ],
        )
      ],
    );
  }

  // Widget
  // First Row
  Widget renderSingleBlock(CleanerData data) {
    Map<String, int> finalData = formatStatusData(data);

    Map<String, int> newData = {};
    for (var key in finalData.keys) {
      if (key == 'Away') {
      } else {
        newData[key] = finalData[key]!;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadiusDirectional.all(
              Radius.circular(3.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.4,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var singleData in newData.keys)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: renderBlock(singleData, newData[singleData]!),
              ),
          ],
        ),
      ),
    );
  }

  // Widget
  // Build single block for the first row
  Widget renderBlock(String key, var value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          key,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(
            fontSize: 14,
            color: setColor(key),
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }

  // Widget
  // Build the chart based on the chart type
  Widget chart(List<CleanersChartData> cleanersChart, String chartType) {
    Map<String, double> formattedData =
        formatContractorsData(cleanersChart, chartType);

    double RGData = 0, TMGData = 0, AMSData = 0, AdeccoData = 0, total = 0;
    for (var key in formattedData.keys) {
      switch (key) {
        case 'RGData':
          {
            RGData = formattedData[key]!;
            break;
          }
        case 'TMGData':
          {
            TMGData = formattedData[key]!;
            break;
          }
        case 'AMSData':
          {
            AMSData = formattedData[key]!;
            break;
          }
        case 'AdeccoData':
          {
            AdeccoData = formattedData[key]!;
            break;
          }
        case 'total':
          {
            total = formattedData[key]!;
            break;
          }
      }
    }
    final List<ChartData> chartDataActiveCleaners = [
      ChartData('RG', RGData,
          '${double.parse(((RGData / total) * 100).toStringAsFixed(2))}%'),
      ChartData('TMR', TMGData,
          '${double.parse(((TMGData / total) * 100).toStringAsFixed(2))}%'),
      ChartData('AMS', AMSData,
          "${double.parse(((AMSData / total) * 100).toStringAsFixed(2))}%"),
      ChartData('Adecco', AdeccoData,
          '${double.parse(((AdeccoData / total) * 100).toStringAsFixed(2))}%')
    ];
    // Check empty data
    if (RGData == 0 && TMGData == 0 && AMSData == 0 && AdeccoData == 0) {
      return SfCircularChart(
        title: ChartTitle(
            text: 'Idle Cleaners',
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            alignment: ChartAlignment.near),
        legend: Legend(isVisible: false),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
            dataSource: chartDataActiveCleaners,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelMapper: (ChartData data, _) => data.text,
          ),
        ],
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Text(
            "No cleaner detected.",
            style: TextStyle(color: Colors.red[800], fontSize: 23),
          ))
        ],
      );
    } else {
      return SfCircularChart(
        title: ChartTitle(
            text: 'Active Cleaners',
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            alignment: ChartAlignment.near),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
            dataSource: chartDataActiveCleaners,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelMapper: (ChartData data, _) => data.text,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              showZeroValue: false,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    }
  }

  // Widget
  // Show When API is not working well
  Widget loadingText() {
    return const Text(
      'Loading...',
      softWrap: false,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
        overflow: TextOverflow.fade,
      ),
    );
  }

  Widget loadingCard() {
    List<String> cardName = ['Active', 'Idle', 'On duty'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadiusDirectional.all(
              Radius.circular(3.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.4,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var singleData in cardName)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: renderBlock(singleData, 0),
              ),
          ],
        ),
      ),
    );
  }

  // Functions
  // Set the colors
  Color? setColor(String key) {
    /**
     * Active == GREEN
     * Idel == GREY
     * On duty == LIGHT BLUE
     */
    switch (key) {
      case 'Active':
        return Colors.green;
      case 'Idle':
        return Colors.grey;
      case 'On duty':
        return Colors.lightBlue[400];
    }
    return Colors.white;
  }

  Color? setColorCleanersDetails(String key) {
    /**
     * Active == GREEN
     * Idel == GREY
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cleaners',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              /**
               * Display the search box
               */
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return dialogSearchBox(context);
                },
              );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    Cleaners cleaners = snapshot.data;
                    CleanerData cleanerData = cleaners.data!;

                    return renderSingleBlock(cleanerData);
                  }
                  return loadingCard();
                },
              ),
            ),
            Card(
              child: FutureBuilder(
                future: getActiveCleanersChartData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<CleanersChartData> cleanersChart = snapshot.data;
                    return chart(cleanersChart, "Active");
                  }
                  return loadingText();
                },
              ),
            ),
            Card(
              child: FutureBuilder(
                future: getActiveCleanersChartData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<CleanersChartData> cleanersChart = snapshot.data;
                    return chart(cleanersChart, "Idle");
                  }
                  return loadingText();
                },
              ),
            ),
            Card(
              child: Center(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Away Cleaners',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FutureBuilder(
                          future: getData(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              Cleaners cleaners = snapshot.data;
                              CleanerData cleanerData = cleaners.data!;

                              Map<String, int> finalData =
                                  formatStatusData(cleanerData);

                              for (var key in finalData.keys) {
                                if (key == 'Away') {
                                  return Text(
                                    finalData[key]!.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  );
                                }
                              }
                              return loadingText();
                            } else {
                              return loadingText();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.text]);
  final String x;
  final double y;
  final String? text;
}
