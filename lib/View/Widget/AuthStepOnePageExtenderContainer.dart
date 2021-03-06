import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';

class AuthStepOnePageExtendedContainer extends StatelessWidget {
  final String mobileNo;
  final GestureTapCallback onPressed;
  final String otpMessage;
  AuthStepOnePageExtendedContainer(this.otpMessage,this.mobileNo,this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
           height:MediaQuery.of(context).size.height/15,
           width: MediaQuery.of(context).size.width,
           color: Colors.white,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Row(
                 children: [
                   Expanded(
                     child: Container(
                       padding: EdgeInsets.only(left: 25),
                       child: Row(
                         children: [
                           Image.asset("assets/private-account 1.png"),
                           Text(mobileNo,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray,fontSize: 16),),
                         ],
                       ),
                     ),
                   ),Expanded(
                     child: InkWell(
                       onTap: (){
                         onPressed();
                       },
                       child: Container(
                         padding: EdgeInsets.only(left: 25),
                         child: Row(
                           children: [
                             Image.asset("assets/iconedit.png"),
                             Text("পরিবর্তন করুন",style: GoogleFonts.roboto(color: Constant.primaryColor,fontSize: 16),),
                           ],
                         ),
                       ),
                     ),
                   )
                 ],
               ),
             ],
           )
          ),
          Container(
            height: MediaQuery.of(context).size.height/13,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child:Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(otpMessage,style: GoogleFonts.roboto(color: Colors.red,fontSize: 16),),
            ),
          )  ,
        ],
      ),
    );
  }
}
