import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final initializeSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

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

  /// Notification that shows every week at certain day at a certain time
  Future<void> showWeeklyAtDayAndTime() async {
    var time = Time(17, 57, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      0,
      'Title',
      'body',
      Day.Tuesday,
      time,
      platformChannelSpecifics,
    );
  }

  /// Notofications that shows a notification every day at a certain time
  Future<void> showdailyAtTime() async {
    var time = Time(16, 01, 00);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'title',
        'body',
        time,
        platformChannelSpecifics);
  }

  /// Notification that shows a notification instantly.
  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Bitch you should be sporting', 'FeetBack', 'sports brah',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 
        'Get back there',
        'We havent seen you around in some time ?',
        platformChannelSpecifics,
        payload: 'item x');
  }
}
