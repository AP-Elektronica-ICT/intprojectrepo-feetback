import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class NotificationService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotitificationPlugin() {
    _initializedNotification();
  }

  void _initializedNotification() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializeSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializeSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
      initializeSettingsAndroid,
      initializeSettingsIOS,
    );

    Future onSelectNotification(String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
    }

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    String _toTwoDigitString(int value) {
      return value.toString().padLeft(2, '0');
    }

    Future<void> _showWeeklyAtDayAndTime() async {
      var time = Time(10, 0, 0);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'show weekly channel id',
          'show weekly channel name',
          'show weekly description');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
          0,
          'show weekly title',
          'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
          Day.Wednesday,
          time,
          platformChannelSpecifics);
    }

    Future<void> _showNotification() async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'Bitch you should be sporting', 'FeetBack', 'sports brah',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.show(
          0, 'plain title', 'plain body', platformChannelSpecifics,
          payload: 'item x');
    }
  }
}
