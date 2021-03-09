import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_app/splash_screen.dart';
import 'HomeScreen.dart';
import 'Util/Constant.dart';
import 'View/Screen/Login/LoginScreen.dart';
import 'View/Screen/Login/registration_screen.dart';
import 'View/Screen/NextFollwoUP/NextFollowUpScreen.dart';
import 'View/Screen/PinRest/PinResetSucessfullLoader.dart';
import 'View/Screen/Report/ReportScreen.dart';
import 'View/Screen/SubmitSuccessFull/NextFollowUpSuccessFull.dart';
import 'View/Screen/SubmitSuccessFull/RegistrationSuceess.dart';
import 'View/Screen/SubmitSuccessFull/SubmitSuccessFullScreen.dart';
import 'View/Screen/Visitor/VisitRegisterScreenOne.dart';
import 'View/Screen/Visitor/VisitorScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Manager',
      theme:ThemeData(
        primaryColor: Constant.primaryTextColorGray,
        accentColor: Color(0xff39B54A),
        textTheme: TextTheme(bodyText2: TextStyle(color:Constant.textColorWhite)),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homeScreen': (context) => HomeScreen(),
        '/registrationScreen': (context) => RegistrationScreen(),
        '/regSuccessFull': (context) => RegeistrationSuccessfullScreen(),
        '/visitorScreen': (context) => VisitorScreen(),
        '/visitorScreenOne': (context) => VisitRegisterScreenOne(),
         //'/showbusinessInfo': (context) => ShowBusinessInformation(),
        '/loginScreen': (context) => LoginScreen(),
         '/submiSuccessful': (context) => SubmitSuccessFullPage(),
         '/netFollowUPScreen': (context) => NextFollowUpScreen(),
         '/reportScreen': (context) => ReportScreen(),
         '/netfollwUpScreen': (context) => NextFollowUpScreen(),
         '/successFullNextFollowUP': (context) => NextfollowUpSuccessfulll(),
         '/pirResetLodader': (context) => PinResetScuccessfullLoader(),
      },
    );
  }
}