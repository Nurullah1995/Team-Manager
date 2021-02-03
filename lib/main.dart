import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_app/splash_screen.dart';
import 'HomeScreen.dart';
import 'Util/Constant.dart';
import 'View/Screen/BusinessInfo/SelectedBusinessType.dart';
import 'View/Screen/BusinessInfo/SelectedUpdateCategoryforUpdateScreen.dart';
import 'View/Screen/District/DistrictListType.dart';
import 'View/Screen/District/selectDistrictForUpdatePage.dart';
import 'View/Screen/Login/LoginScreen.dart';
import 'View/Screen/NextFollwoUP/NextFollowUpScreen.dart';
import 'View/Screen/PinRest/PinResetSucessfullLoader.dart';
import 'View/Screen/Report/ReportScreen.dart';
import 'View/Screen/SubmitSuccessFull/NextFollowUpSuccessFull.dart';
import 'View/Screen/SubmitSuccessFull/SubmitSuccessFullScreen.dart';
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
     // home:SplashScreen(),
      //(title: 'Flutter Login'),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homeScreen': (context) => HomeScreen(),
        '/visitorScreen': (context) => VisitorScreen(),
        '/loginScreen': (context) => LoginScreen(),
         '/registerCategory': (context) => SelectBusinessCategory(),
         '/districtTypeforRegister': (context) => DistrictListType(),
         '/updateCatScreen': (context) => SelectedBusiessCategoryScreenForUpdateScreen(),
         '/updateDistrictScreen': (context) => DistrictCategoryForUpdateScreen(),
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