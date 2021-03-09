import 'dart:async';

import 'package:flutter/material.dart';
class RegeistrationSuccessfullScreen extends StatefulWidget {
  @override
  _RegeistrationSuccessfullScreenState createState() => _RegeistrationSuccessfullScreenState();
}

class _RegeistrationSuccessfullScreenState extends State<RegeistrationSuccessfullScreen> {


  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
          () =>
              //Navigator.pushNamed(context, '/homeScreen'),
              Navigator.of(context).pushNamedAndRemoveUntil('/homeScreen', (Route<dynamic> route) => false),
      // }),

    );

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/13203-green-check-mark.gif"),
            Center(child: Text("রেজিস্ট্রেশন সফল ভাবে সম্পন্ন হয়েছে",style: TextStyle(color: Colors.black),)),

          ],
        ),
      ),
    );
  }
}
