import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Model/NextFollwUp/NextFollowUpModel.dart';
import 'package:test_app/Service/NextFollwUp_Service.dart';
import 'package:test_app/Util/Constant.dart';

import 'ShowFollowUpInformation.dart';


class NextFollowUpScreen extends StatefulWidget {
  @override
  _NextFollowUpScreenState createState() => _NextFollowUpScreenState();
}

class _NextFollowUpScreenState extends State<NextFollowUpScreen> {
 // final NextFollowUpController _nextFollowUpControllerr= Get.put(NextFollowUpController());
 List<NextFollowUpModel> _nextFollowUpList= List<NextFollowUpModel>();

 var isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    _nextFlowUpList();
    super.initState();

  }
  _nextFlowUpList(){

     try{
       isLoading=true;
           nextFlowUpList().then((response) {
      setState(() {
        _nextFollowUpList=response;
        print(_nextFollowUpList);
      });
    }

    );
     }finally{
       isLoading=false;
     }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,color:Constant.primaryTextColorGray,),
                  onPressed: (){
                   // Navigator.pop(context);
                    Navigator.pushNamed(context, '/visitorScreen');
                  },
                ),
                backgroundColor: Constant.textColorWhite,
                title:Text("পরবর্তি ফলোআপ লিস্ট",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
              ),
        body: _nextFollowUpList.isEmpty?Center(child: Text('ফলোআপ লিস্টে কোনো তথ্য নেই',style: TextStyle(color: Colors.red),)):Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 25,right: 25,top: 15,),
              child: SizedBox(
                child: Text("ফলোআপ ${_nextFollowUpList.length}",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
              ),
            ),
            Flexible(

              child: ListView.builder(
                itemCount: _nextFollowUpList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_nextFollowUpList.isEmpty) {
                    // Return Widget for this condition,
                    return Container(
                      child: Center(child: Text('No item', style: TextStyle(
                          color: Colors.black,fontSize: 20),)),
                    );
                  }
                  else {
                    return  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowFollowUpInformation(_nextFollowUpList[index].followUpId,_nextFollowUpList[index].visitedPlaceId)));
                      },
                      child: Card(
                        child: ListTile(
                          leading:Container(
                            height: 60,
                            width: 50,
                            decoration: new BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Text(_nextFollowUpList[index].orgName[0],style: TextStyle(color: Colors.white,fontSize: 20),)),
                          ),
                          title: Text(_nextFollowUpList[index].orgName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 5),
                                child: Text('${_nextFollowUpList[index].upazila},${_nextFollowUpList[index].upazila}'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(_nextFollowUpList[index].orgContact),
                                  Text(_nextFollowUpList[index].followupDate.toString(),style: GoogleFonts.roboto(fontSize: 11),),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                              padding: EdgeInsets.only(top: 15),
                              child: Icon(Icons.keyboard_arrow_right,size: 30,)
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  }
                }
              ),
            )
          ],
        ),
          ),
        );
  }
}
