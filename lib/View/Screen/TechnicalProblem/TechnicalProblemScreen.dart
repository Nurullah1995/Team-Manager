import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';

class TechnicalProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/submit_problem.png')),
            SizedBox(height: 30,),
            Center(child: Text("দুঃখিত ",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),)),
            Center(child: Text("কারিগরি ত্রূটির কারণে তথ্য সাবমিট করা সম্ভব",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),)),
            Center(child: Text("হয়নি",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),)),
          ],
        ),
      ),
    );
  }
}
