import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/Visitor/VisitorScreen.dart';
class SubmitSuccessFullPage extends StatefulWidget {
  @override
  _SubmitSuccessFullPageState createState() => _SubmitSuccessFullPageState();
}

class _SubmitSuccessFullPageState extends State<SubmitSuccessFullPage> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
            () => Navigator.popUntil(context, ModalRoute.withName('/visitorScreen')),
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
               Center(child: Text("ব্যবসা প্রতিষ্ঠানের তথ্য সফল ভাবে সাবমিট হয়েছে",style: TextStyle(color: Colors.black),)),

            // Expanded(
            //   flex: 2,
            //     child: Container(
            //
            //     )
            // ),
            // RaisedButton(
            //     child: Text('Ok',style: TextStyle(color: Colors.white),),
            //     color: Constant.primaryColor,
            //   onPressed: (){
            //       Navigator.pushNamed(context, '/visitorScreen');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

