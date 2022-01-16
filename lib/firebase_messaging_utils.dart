//import 'package:ai_fresh_plant/network/api.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

//import 'notifications.dart';
//FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  /*print("notification");
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];

    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    showNotification(notification, "sdsasak");

    print(notification);
  }*/

  // Or do other work.
}


class FirebaseMessagingUtils {

  FirebaseMessagingUtils(){
      configure();
      makeCall();
  }

  void makeCall() async {
    //RestClient().sendMessage(await _firebaseMessaging.getToken(), "Small step for one man - big for humans");
  }

  void configure(){
    /*_firebaseMessaging..configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );*/
    //TODO: refactor to new firebase
  }
}