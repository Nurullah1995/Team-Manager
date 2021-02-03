import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';

class InternetProblemScreen extends StatefulWidget {
  @override
  _InternetProblemScreenState createState() => _InternetProblemScreenState();
}

class _InternetProblemScreenState extends State<InternetProblemScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/wifi_signal.png')),
            SizedBox(height: 30,),
            Center(child: Text("দুঃখিত ",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),)),
            Center(child: Text("ইন্টারনেট সংযোগ নাই , অনুগ্রহ করে ইন্টারনেট ",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),)),
            Center(child: Text("সংযুক্ত করে পুনরায় চেষ্টা করুন ",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),)),
          ],
        ),
      ),
    );
  }
}
