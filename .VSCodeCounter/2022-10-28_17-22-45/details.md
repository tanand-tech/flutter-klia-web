# Details

Date : 2022-10-28 17:22:45

Directory c:\\Users\\User\\Downloads\\Documents\\Flutter\\web_dashboard\\lib

Total : 49 files,  7874 codes, 6723 comments, 954 blanks, all 15551 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/config.dart](/lib/config.dart) | Dart | 9 | 2 | 2 | 13 |
| [lib/homeScreen.dart](/lib/homeScreen.dart) | Dart | 189 | 32 | 18 | 239 |
| [lib/instance/MQTTAppState.dart](/lib/instance/MQTTAppState.dart) | Dart | 20 | 1 | 7 | 28 |
| [lib/instance/forceRefresh/refreshTokenDueLongPeriod.dart](/lib/instance/forceRefresh/refreshTokenDueLongPeriod.dart) | Dart | 59 | 11 | 7 | 77 |
| [lib/instance/mqttManagerUniversal.dart](/lib/instance/mqttManagerUniversal.dart) | Dart | 0 | 333 | 56 | 389 |
| [lib/instance/mqtt/mqttClientFactory.dart](/lib/instance/mqtt/mqttClientFactory.dart) | Dart | 3 | 0 | 1 | 4 |
| [lib/instance/mqtt/mqttClientFactoryNull.dart](/lib/instance/mqtt/mqttClientFactoryNull.dart) | Dart | 4 | 0 | 2 | 6 |
| [lib/instance/mqtt/mqttClientFactoryServer.dart](/lib/instance/mqtt/mqttClientFactoryServer.dart) | Dart | 17 | 6 | 6 | 29 |
| [lib/instance/mqtt/mqttClientFactoryWeb.dart](/lib/instance/mqtt/mqttClientFactoryWeb.dart) | Dart | 16 | 3 | 6 | 25 |
| [lib/instance/mqtt/mqttManager.dart](/lib/instance/mqtt/mqttManager.dart) | Dart | 192 | 57 | 51 | 300 |
| [lib/main.dart](/lib/main.dart) | Dart | 43 | 3 | 7 | 53 |
| [lib/model/alert/alert.dart](/lib/model/alert/alert.dart) | Dart | 121 | 0 | 19 | 140 |
| [lib/model/alert/alertNotification.dart](/lib/model/alert/alertNotification.dart) | Dart | 22 | 0 | 4 | 26 |
| [lib/model/cleaner/cleaners.dart](/lib/model/cleaner/cleaners.dart) | Dart | 45 | 0 | 9 | 54 |
| [lib/model/cleaner/cleanersChart.dart](/lib/model/cleaner/cleanersChart.dart) | Dart | 90 | 0 | 15 | 105 |
| [lib/model/cleaner/employee/employee.dart](/lib/model/cleaner/employee/employee.dart) | Dart | 194 | 0 | 25 | 219 |
| [lib/model/cleaner/employee/employeeLatestLog.dart](/lib/model/cleaner/employee/employeeLatestLog.dart) | Dart | 118 | 0 | 16 | 134 |
| [lib/model/cleaner/employee/employeeSummary.dart](/lib/model/cleaner/employee/employeeSummary.dart) | Dart | 130 | 0 | 16 | 146 |
| [lib/model/cleaner/employee/employeeTimeSpent.dart](/lib/model/cleaner/employee/employeeTimeSpent.dart) | Dart | 43 | 0 | 8 | 51 |
| [lib/model/cleaner/employee/employeeTrailLogs.dart](/lib/model/cleaner/employee/employeeTrailLogs.dart) | Dart | 193 | 0 | 25 | 218 |
| [lib/model/location/OverallLocation.dart](/lib/model/location/OverallLocation.dart) | Dart | 53 | 0 | 10 | 63 |
| [lib/model/location/roomLatestLog.dart](/lib/model/location/roomLatestLog.dart) | Dart | 134 | 0 | 20 | 154 |
| [lib/model/location/roomTimeSpent.dart](/lib/model/location/roomTimeSpent.dart) | Dart | 88 | 0 | 15 | 103 |
| [lib/model/location/roomTrailLogs.dart](/lib/model/location/roomTrailLogs.dart) | Dart | 173 | 0 | 20 | 193 |
| [lib/model/location/trailLogs.dart](/lib/model/location/trailLogs.dart) | Dart | 148 | 0 | 30 | 178 |
| [lib/model/login/login.dart](/lib/model/login/login.dart) | Dart | 175 | 0 | 35 | 210 |
| [lib/model/staticData/download copy.dart](/lib/model/staticData/download%20copy.dart) | Dart | 242 | 5 | 33 | 280 |
| [lib/model/staticData/download.dart](/lib/model/staticData/download.dart) | Dart | 0 | 4,018 | 81 | 4,099 |
| [lib/model/universalMessage.dart](/lib/model/universalMessage.dart) | Dart | 25 | 0 | 4 | 29 |
| [lib/notifier/notifierManager.dart](/lib/notifier/notifierManager.dart) | Dart | 164 | 3 | 23 | 190 |
| [lib/screens/alert/alertScreen.dart](/lib/screens/alert/alertScreen.dart) | Dart | 624 | 107 | 35 | 766 |
| [lib/screens/cleaner/cleanerDetails.dart](/lib/screens/cleaner/cleanerDetails.dart) | Dart | 448 | 46 | 22 | 516 |
| [lib/screens/cleaner/cleanerScreen.dart](/lib/screens/cleaner/cleanerScreen.dart) | Dart | 881 | 82 | 48 | 1,011 |
| [lib/screens/locationDetailsScreen.dart](/lib/screens/locationDetailsScreen.dart) | Dart | 0 | 937 | 32 | 969 |
| [lib/screens/location/locationDetailsScreen.dart](/lib/screens/location/locationDetailsScreen.dart) | Dart | 856 | 81 | 31 | 968 |
| [lib/screens/location/locationDetailsScreen2.dart](/lib/screens/location/locationDetailsScreen2.dart) | Dart | 496 | 42 | 21 | 559 |
| [lib/screens/location/locationScreen copy.dart](/lib/screens/location/locationScreen%20copy.dart) | Dart | 891 | 155 | 57 | 1,103 |
| [lib/screens/location/locationScreen.dart](/lib/screens/location/locationScreen.dart) | Dart | 0 | 533 | 20 | 553 |
| [lib/screens/login/loginScreen.dart](/lib/screens/login/loginScreen.dart) | Dart | 230 | 26 | 14 | 270 |
| [lib/screens/settings/changePassword.dart](/lib/screens/settings/changePassword.dart) | Dart | 256 | 28 | 21 | 305 |
| [lib/screens/settings/settingsScreen.dart](/lib/screens/settings/settingsScreen.dart) | Dart | 142 | 29 | 10 | 181 |
| [lib/screens/splash_screen.dart](/lib/screens/splash_screen.dart) | Dart | 0 | 32 | 6 | 38 |
| [lib/service/alertLog-api.dart](/lib/service/alertLog-api.dart) | Dart | 26 | 0 | 5 | 31 |
| [lib/service/api.dart](/lib/service/api.dart) | Dart | 78 | 2 | 11 | 91 |
| [lib/service/location-api.dart](/lib/service/location-api.dart) | Dart | 68 | 3 | 14 | 85 |
| [lib/service/login-api.dart](/lib/service/login-api.dart) | Dart | 23 | 20 | 6 | 49 |
| [lib/service/setting-api.dart](/lib/service/setting-api.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/sharedPreference/sharedPreferences.dart](/lib/sharedPreference/sharedPreferences.dart) | Dart | 94 | 126 | 18 | 238 |
| [lib/util/util.dart](/lib/util/util.dart) | Dart | 43 | 0 | 10 | 53 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)