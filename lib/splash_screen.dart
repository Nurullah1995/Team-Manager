
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Service/SharePrefarence.dart';

import 'HomeScreen.dart';
import 'Util/Constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loginSelectionPage();
    // Timer(
    //     Duration(seconds: 7),
    //         () =>
    //         getTokenValue()==null?Navigator.pushNamed(context, '/homeScreen'):
    //         Navigator.pushNamed(context, '/visitorScreen'));
  }

  _loginSelectionPage()async{
       var token=await getTokenValue();
       print(token);
       token==null?Navigator.pushReplacementNamed(context, '/homeScreen'):Navigator.pushReplacementNamed(context, '/visitorScreen');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Image.asset("assets/logo.png",fit: BoxFit.fill,),
                    ),
                  ),
                  // Center(child: Text("OUTREACH",style:GoogleFonts.robotoSlab(fontSize: 36,color: Color(0xff606060)),)),
                  // Center(child: Text("TRACKER",style:GoogleFonts.robotoSlab(fontSize: 36,color: Color(0xff606060)),)),
            ],
          )
      ),
    );
  }
}