import 'dart:async';

import 'package:flutter/material.dart';

class PinResetScuccessfullLoader extends StatefulWidget {
  @override
  _PinResetScuccessfullLoaderState createState() => _PinResetScuccessfullLoaderState();
}

class _PinResetScuccessfullLoaderState extends State<PinResetScuccessfullLoader> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
          () => Navigator.pushNamed(context, '/loginScreen'),
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
            Center(child: Text("পাসওয়ার্ড রিসেট  সফল ভাবে সম্পূর্ণ হয়েছে ",style: TextStyle(color: Colors.black),)),
          ],
        ),
      ),
    );
  }
}
