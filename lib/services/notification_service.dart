import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';


class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final initializeSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  static final initializeSettingsIOS = IOSInitializationSettings();

  final initializationSettings = InitializationSettings(
    initializeSettingsAndroid,
    initializeSettingsIOS,
  );

  NotificationService() {
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
     // onSelectNotification: onSelectNotification, 
    );
  }

 /* Future onSelectNotification(String payload) async {  // isn't quit necessary but am gonna leave it here for some time
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  } */

   String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> showWeeklyAtDayAndTime() async {
    var time = Time(22, 15, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'show weekly title',
        'Weekly notification shown on Monday at approximately',
        Day.Wednesday,
        time,
        platformChannelSpecifics,
        payload: 'item x');
  }

   Future<void> showdailyAtTime() async {
    var time = Time(16, 01, 00);
    debugPrint(_toTwoDigitString(time.hour) +  ':' + _toTwoDigitString(time.minute) + ':' + _toTwoDigitString(time.second));
    
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Bitch you should be sporting', 'FeetBack', 'sports brah',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 
        'tity o mcdonalds', 
        'de koe ? die spreekt', 
        platformChannelSpecifics,
        payload: 'item x');
  }
}
