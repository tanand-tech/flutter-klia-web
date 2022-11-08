import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

SnackBar showSnackBar(String snackBar) {
  return SnackBar(
    content: Text(snackBar),
  );
}

bool isEmailValid(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

String capitalizeFirstWord(String s) => s[0].toUpperCase() + s.substring(1);

String formatedTime(int timeInSecond) {
  int min = (timeInSecond / 60).floor() % 60;
  int hr = (timeInSecond / 3600).floor() % 24;
  int d = (timeInSecond / 86400).floor();
  String hour = hr.toString().length <= 1 ? "0$hr" : "$hr";
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  if (d.toString() != '0') {
    return "$d d $hour h $minute m";
  }
  return "$hour h $minute m";
}

int getTimeNow() {
  return (DateTime.now().millisecondsSinceEpoch / 1000).floor();
}

String calculatePercentage(int totalDuration, int data) {
  return ((data / totalDuration) * 100).toDouble().toStringAsFixed(2);
}

int getStartofTheDay() {
  var now =
      ((DateTime.now().millisecondsSinceEpoch / 1000).floor() / 86400).floor();
  var temp = now * 86400;
  var result = temp - 28800;
  return result;
}

calculateDuration(int startTimeStamp, int endTimeStamp) {
  return formatedTime(endTimeStamp - startTimeStamp);
}

convertTimestampToHourMinutes(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('HH:mm').format(date);
}

convertTimestampToDateTime(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd MMM yyyy HH:mm').format(date);
}
