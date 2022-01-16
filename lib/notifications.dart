import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
BuildContext cont;

Future<void> initializeNotifications(BuildContext context) async {
  cont = context;
  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
}

Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
  /*await Navigator.push(
    cont,
    MaterialPageRoute(builder: (context) => SecondScreen(payload)),
  )*/
}

void showNotification(String title, String body) async{
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics,
      payload: 'item x');
}


Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  showDialog(
    context: cont,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
           // Navigator.of(context, rootNavigator: true).pop();
            /*await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => //SecondScreen(payload),
              ),
            );*/
          },
        )
      ],
    ),
  );
}