import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';


class BusinessInstutionInformationScreen extends StatefulWidget {
  @override
  _BusinessInstutionInformationScreenState createState() => _BusinessInstutionInformationScreenState();
}

class _BusinessInstutionInformationScreenState extends State<BusinessInstutionInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Constant.primaryTextColorGray,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor:Color(0xffffffff) ,
          title: Text("ব্যবসা প্রতিষ্ঠানের তথ্য",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),
        ),
        body: Column(
          children: [
               Row(
                 children: [
                    Expanded(
                      child: Container(
                        color: Colors.yellow,
                        child: Column(
                          children: [
                           Text("ব্যবসা প্রতিষ্ঠানের তথ্য",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),
                          ],
                        ),
                      ),
                    ),
                   Expanded(
                     child: Container(
                       color: Colors.red,
                       child: Column(
                         children: [
                           Text("ব্যবসা প্রতিষ্ঠানের তথ্য",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),
                         ],
                       ),
                     ),
                   ),
                 ],
               )
          ],
        ),
      ),
    );
  }
}
