import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Model/VisitPlace/FetchVisitedPlaceModel.dart';
import 'package:test_app/Service/Show_single_businessInstiution_info.dart';


import 'ShowBusinessInformation.dart';


class SearchInstituteInformation extends SearchDelegate<FetchVisitedPlaceModel> {
  final List<FetchVisitedPlaceModel> visitList;
  SearchInstituteInformation(this.visitList);
  //  final List<FetchVisitedPlaceModel> list=List.generate(Controller.visitList, (index) => 'index$index');

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
       // Navigator.pop(context);
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }



  @override
  Widget buildSuggestions(BuildContext context) {

    //final suggestionList=query.isEmpty?visitList:Controller.visitList.where((element) =>element.orgName.toLowerCase().startsWith(query)).toList();
    List<FetchVisitedPlaceModel> suggestionList = [];
    query.isEmpty
        ? suggestionList = visitList //In the true case
        : suggestionList.addAll(visitList.where(
      // In the false case
          (element) => element.orgContact.toLowerCase().startsWith(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) =>
          InkWell(
            onTap: (){
              showSingeBusinessInformtionShop(visitList[index].id).then((res) {
                if(res!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowBusinessInformation(visitList[index].id)));
                }
              });
            },
            child: Card(
              child: ListTile(
                leading: Container(
                  height: 60,
                  width: 50,
                  decoration: new BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text(suggestionList[index].orgName[0],
                    style: TextStyle(color: Colors.white, fontSize: 20),)),
                ),
                title:RichText(
                 text: TextSpan(
                   text: suggestionList[index].orgName.substring(0,query.length),
                     style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold),
                   children:[
                     TextSpan(
                       text: suggestionList[index].orgName.substring(query.length),
                       style: TextStyle(color: Colors.grey,),
                     )
                   ]
                 ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                          "${suggestionList[index].thana},${suggestionList[index]
                              .district}"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: suggestionList[index].orgContact.substring(0,query.length),
                              style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                              children:[
                                TextSpan(
                                  text: suggestionList[index].orgContact.substring(query.length),
                                  style: TextStyle(color: Colors.grey,),
                                )
                              ]
                          ),
                        ),
                        Text(suggestionList[index].visitedDateTime.toString(),
                          style: GoogleFonts.roboto(fontSize: 11),),
                      ],
                    ),
                  ],
                ),
                trailing: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(Icons.keyboard_arrow_right, size: 30,)
                ),
                isThreeLine: true,
              ),
            ),
          ),
    );
  }
  }