import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';

class MaterialButtonForWhole extends StatelessWidget {
  final String buttonName;
  final GestureTapCallback onPressed;
  MaterialButtonForWhole(this.buttonName,{@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          //  color: Colors.blue,
          //  margin: EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Constant.primaryColor,
          ),
          child: Center(child: Text(buttonName,style: GoogleFonts.notoSans(fontSize: 16),)),
        ),
      ),
    );
  }
}
