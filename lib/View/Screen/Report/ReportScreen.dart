import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Model/Report/ReportModel.dart';
import 'package:test_app/Service/Report_service.dart';
import 'package:test_app/Util/Constant.dart';
class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
//final  ReportController _reportController=Get.put(ReportController());
  Future<List<ReportModel>> reportList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reportList=fetchReport();
    print(reportList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          appBar:  AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color:Constant.primaryTextColorGray,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor: Constant.textColorWhite,
            title:Text("রিপোর্ট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
          ),
          body:FutureBuilder<List<ReportModel>>(
            future: reportList, // async work
            builder: (BuildContext context, AsyncSnapshot<List<ReportModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return Center(child: Text('Loading....',style: TextStyle(color: Colors.green,fontSize: 22),));
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index)=>Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70,
                            width:MediaQuery.of(context).size.width ,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25,right: 25,top: 25,bottom: 10),
                              child: Text("ভিজিট রিপোর্ট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child:Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex:3,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: 25,top: 15),
                                          child: Column(
                                            children: [
                                              Text("আজকের ভিজিট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text("  এই সপ্তাহের ভিজিট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text(" এই মাসের ভিজিট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text(" এই বছরের ভিজিট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: 25,top: 15),
                                          child: Column(
                                            children: [
                                              Text('${snapshot.data[index].visitToday} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text('${snapshot.data[index].visitThisWeek} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text('${snapshot.data[index].visitThisMonth} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text('${snapshot.data[index].visitThisYear} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                          SizedBox(
                            height: 70,
                            width:MediaQuery.of(context).size.width ,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25,right: 25,top: 25,bottom: 10),
                              child: Text("ফলোআপ রিপোর্ট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child:Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex:3,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: 25,top: 15),
                                          child: Column(
                                            children: [
                                              Text("আজকের ফলোআপ",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text("  এই সপ্তাহের ফলোআপ",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text(" এই মাসের ফলোআপ",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text(" এই বছরের ফলোআপ",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: 25,top: 15),
                                          child: Column(
                                            children: [
                                              Text('${snapshot.data[index].followupToday.toString()} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text('${snapshot.data[index].followupThisWeek} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text('${snapshot.data[index].followupThisMonth} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                              SizedBox(height: 15,),
                                              Text('${snapshot.data[index].followupThisYear} টি',style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    );
              }
            },
          )
        ),
      ),
    );
  }
}

