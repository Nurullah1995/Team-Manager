import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/Util/Constant.dart';

import '../NextFollwoUP/NextFollowUpScreen.dart';

class NextfollowUpSuccessfulll extends StatefulWidget {
  @override
  _NextfollowUpSuccessfulllState createState() => _NextfollowUpSuccessfulllState();
}

class _NextfollowUpSuccessfulllState extends State<NextfollowUpSuccessfulll> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
            () => Navigator.pushNamed(context, '/netfollwUpScreen')
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/13203-green-check-mark.gif"),
            Center(child: Text("সফল ভাবে সম্পন্ন হয়েছে ",style: TextStyle(color: Colors.black),)),
          ],
        ),
      ),
    );
  }
}
