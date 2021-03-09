import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Model/ShowBusinessInfo/ShowSingleBusinessInformation.dart';
import 'package:test_app/Service/Show_single_businessInstiution_info.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/EditScreen/EditSingleBusinessShopDetails.dart';
import 'package:test_app/View/Widget/MaterialButtonForWholeApp.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowBusinessInformation extends StatefulWidget {
  final int singleProductId;
  ShowBusinessInformation(this.singleProductId,);
  @override
  _ShowBusinessInformationState createState() => _ShowBusinessInformationState();
}

class _ShowBusinessInformationState extends State<ShowBusinessInformation> {
  VisitedPlace visitedPlaceDetails;


  @override
  void initState() {
    super.initState();
    showSingeBusinessInformtionShop(widget.singleProductId).then((res) {
      setState(() {
        visitedPlaceDetails=res;
        print(visitedPlaceDetails.orgTypeName);
      });
    });

  }



  var demoDate='';
  var demoImage='https://www.dicetower.com/sites/default/files/styles/image_300/public/game-art/no-image-available_1.png?itok=4AoejwSQ';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                         child: Text('সম্পূর্ণ ঠিকানা',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text('নোট',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text('পরিবর্তী ফলোআপ',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
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
                         child: Text(visitedPlaceDetails.orgName==null?'':visitedPlaceDetails.orgName,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.orgTypeName==null?'':visitedPlaceDetails.orgTypeName,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.ownerName==null?'':visitedPlaceDetails.ownerName,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.visitTime==null?'Loading ..':visitedPlaceDetails.visitTime,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Container(
                             height: 50,
                             child: Text(visitedPlaceDetails.contact==null?'Loading ..':visitedPlaceDetails.contact,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                           ),
                           InkWell(
                             child: Image.asset(
                               'assets/phoneCall.png',height: 40,width: 40,
                             ),
                             onTap: (){
                               launch(('tel://${visitedPlaceDetails.contact}'));
                             },
                           ),
                         ],
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.thana==null?'Loading ..':visitedPlaceDetails.thana,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.district==null?'Loading ..':visitedPlaceDetails.district,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.address==null?'Loading ..':visitedPlaceDetails.address,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.feedback==null?'Loading ..':visitedPlaceDetails.feedback,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
                       ),
                       Container(
                         height: 50,
                         child: Text(visitedPlaceDetails.nextFollowup==null?demoDate:visitedPlaceDetails.nextFollowup,style: GoogleFonts.roboto(color: Constant.primaryTextColorGray),),
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
             child: Image.network(visitedPlaceDetails.orgImg==null?demoImage:visitedPlaceDetails.orgImg,height: 250,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
           ),
           MaterialButtonForWhole('তথ্য আপডেট করুন',onPressed: (){

             //onclick listener
             Navigator.push(context, MaterialPageRoute(builder: (context)=>EdiitShopBusinessDetailsInfo(widget.singleProductId,visitedPlaceDetails)));
           },),
           SizedBox(height: 50,),
         ],
       ),
        ),
    );
  }
}
