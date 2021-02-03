import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';


class AuthStepOnePageContainer extends StatelessWidget {
  final String phoneNumber;
  final GestureTapCallback onClick;
  AuthStepOnePageContainer(this.phoneNumber,this.onClick);
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                        Text(phoneNumber,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray,fontSize: 16),),
                      ],
                    ),
                  ),
                ),Expanded(
                  child: InkWell(
                    onTap: (){
                      onClick();
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
    );
  }
}
