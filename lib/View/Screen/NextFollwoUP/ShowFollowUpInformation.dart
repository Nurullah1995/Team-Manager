import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Service/NextFollowUpUpdate.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/SubmitSuccessFull/NextFollowUpSuccessFull.dart';
import 'package:test_app/View/Widget/MaterialButtonForWholeApp.dart';
import '../../../Model/ShowBusinessInfo/ShowSingleBusinessInformation.dart';
import '../../../Service/Show_single_businessInstiution_info.dart';
import '../../Widget/SubmiDialog.dart';


class ShowFollowUpInformation extends StatefulWidget {
  final String followUpId;
  final String visitedPlceId;
  ShowFollowUpInformation(this.followUpId,this.visitedPlceId);
 @override
  _ShowFollowUpInformationState createState() => _ShowFollowUpInformationState();
}

class _ShowFollowUpInformationState extends State<ShowFollowUpInformation> {
  VisitedPlace visitedPlaceDetails;
  @override
  void initState() {
    super.initState();
    showSingeBusinessInformtionShop(int.parse(widget.visitedPlceId)).then((res) {
      setState(() {
        visitedPlaceDetails=res;
      });
    });

  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        appBar:AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Constant.primaryTextColorGray,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Constant.textColorWhite,
          title:Text("ব্যবসা প্রতিষ্ঠানের তথ্য",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
        ) ,

        body:visitedPlaceDetails==null?Center(child: CircularProgressIndicator()): ListView(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 25,right: 15,top: 25,bottom: 25 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          child: Text('ব্যবসা প্রতিষ্ঠানের নাম',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('ব্যবসা প্রতিষ্ঠানের ধরন',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('মালিকের নাম',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('ভিসিট এর সময়',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('ফোন নাম্বার',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('থানা',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('জেলা',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('ডিটেয়াইল এড্রেস',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text('পরবর্তি ফলোয়াপ ',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 0,right: 0,top: 25,bottom: 25 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.orgName,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.orgTypeName,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.ownerName,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.visitTime,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.contact,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.thana,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.district,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.address,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                        Container(
                          height: 50,
                          child: Text(visitedPlaceDetails.nextFollowup,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Text('ব্যবসা প্রতিষ্ঠানের ছবি ',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 40),
              child: Image.network(visitedPlaceDetails.orgImg==null?'':visitedPlaceDetails.orgImg,height: 250,width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
            ),
            MaterialButtonForWhole('ফলোআপ সম্পন্ন',onPressed: (){
              nextFollowUpUpdate(widget.followUpId,widget.visitedPlceId);
              Dialogs.showLoadingDialog(context, _keyLoader);
              //onclick listener
              Navigator.pushNamed(context, '/successFullNextFollowUP');
            },),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
