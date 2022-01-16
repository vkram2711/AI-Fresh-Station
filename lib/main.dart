
import 'package:ai_fresh_plant/firebase_messaging_utils.dart';
import 'package:ai_fresh_plant/generated/messages_all.dart';
import 'package:ai_fresh_plant/screens/trays/trays_bloc.dart';
import 'package:ai_fresh_plant/screens/trays/widgets/trays_screen.dart';
import 'package:ai_fresh_plant/utils.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'notifications.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    initializeNotifications(context);
    FirebaseMessagingUtils();

    //showNotification("Hello", "world");
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      ),
      child: Padding(padding: EdgeInsets.only(top: 24),child: Provider(
        create: (context) => TraysBloc(),
        dispose: (context, value) => value.dispose(),
        child: MaterialApp(
          title: 'AI Crop Manager',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[600],
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            canvasColor: Colors.white,
            fontFamily: 'Montserrat',
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,),
              body1: TextStyle(
                  fontSize: 12.0, fontFamily: 'Roboto', color: Colors.black),
            ),
          ),
          home: LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(
                  builder: (context, orientation){
                    //ResponsiveHelper().init(constraints, orientation);

                    ScreenUtil.init(context, designSize: Size(1440, 2560));
                    //SizeConfig().init(context);

                    return Scaffold(backgroundColor: HexColor.fromHex("FCFCFC"),body:TraysScreen());
                  }
                );
              },
          )
        ))));
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }
  // Or do other work.
}