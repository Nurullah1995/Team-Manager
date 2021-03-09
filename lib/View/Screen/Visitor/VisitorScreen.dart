import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Controller/Login/loginResponseController.dart';
import 'package:test_app/Model/Search/SearchModel.dart';
import 'package:test_app/Model/VisitPlace/FetchVisitedPlaceModel.dart';
import 'package:test_app/Service/SharePrefarence.dart';
import 'package:test_app/Service/Show_single_businessInstiution_info.dart';
import 'package:test_app/Service/search_service.dart';
import 'package:test_app/Service/visited_place_service.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/BusinessInfo/ShowBusinessInformation.dart';
import 'VisitRegisterScreenOne.dart';

class VisitorScreen extends StatefulWidget {
  @override
  _VisitorScreenState createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {


  bool searching, error;
  var data;
  String query;

  String notfoundData='';

  List<SerarchListModel> searchList=[];
  int currentPageForSearch;
  int lastPageForSearch;


 // ScrollController _scrollControllerForSearchList=ScrollController();
  TextEditingController searchTextEditingCtlr=TextEditingController();
  static const IconData logout = IconData(0xe848, fontFamily: 'MaterialIcons');



  ScrollController _scrollControllerForVisitPlace=ScrollController();




List<FetchVisitedPlaceModel> _visitList=[];
  String userName;
  String userImage;
  String userRole;
  String userContact;



  int current_page=1;
  bool loading=true;
  bool innerLoading=true;


  @override
  void initState() {

    searching = false;
    error = false;
    query = "";

    getUserName().then((result) {
      userName=result;
    });
    getUserPhoneNo().then((result) {
      userContact=result;
    });
    getUserImage().then((result) {
      userImage=result;
    });
    getUserRole().then((result) {
      userRole=result;
      print(userRole);
    });



    visitShopList();
    _scrollControllerForVisitPlace.addListener(() {
      innerLoading=true;
      if(_scrollControllerForVisitPlace.position.pixels==_scrollControllerForVisitPlace.position.maxScrollExtent){

        nextPageUrl().then((netPageUrl) {
          List<FetchVisitedPlaceModel> _newvisitList=[];

          fetchVisitShopListNextPage(netPageUrl).then((res) {
             _newvisitList.addAll(res);

             var regularVisitListId;
             var newVisitListId;
             _visitList.forEach((element) {
               regularVisitListId=element.id;
             });
             _newvisitList.forEach((element) {
               newVisitListId=element.id;
             });
             if(regularVisitListId!=newVisitListId){
               _visitList=_visitList+_newvisitList;
               innerLoading=false;
               print(_visitList.length);
             }

          });
        });

      }
    });



    searchTextEditingCtlr.addListener(() {
      if (searchTextEditingCtlr.text.isEmpty) {
      } else {
        Future.delayed(Duration(seconds: 1), () {
          getSuggestion();
        });
      }
    });


    // TODO: implement initState
    super.initState();

  }




  void getSuggestion() async{//get suggestion function
    fetchSearchList(searchTextEditingCtlr.text).then((response) {
       print(response);

       if(response==null){
          notfoundData='No found data';
        }else{
         var searchListId;
         var responseListId;
         if(searchList!=null){
           searchList.forEach((element) {
             searchListId=element.id;
           });
         }
         if(response!=null){
           response.forEach((element) {
             responseListId=element.id;
           });
         }
         if(searchListId!=responseListId){
           setState(() {
             searchList.addAll(response);
             print(searchList.length);
           });
         }
       }

    });


  }



    visitShopList(){
        fetchVisitShopList().then((responseItem) {
           _visitList.addAll(responseItem);
             setState(() {
               loading=false;
               innerLoading=false;
             });
        });
      }



  @protected
  @mustCallSuper
  void dispose() {
    _scrollControllerForVisitPlace.dispose();
    super.dispose();
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('আপনি নিশ্চিত ?'),
        content: new Text('আপনি কি এপ্লিকেশন থেকে বের হতে চাচ্ছেন ?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('না'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: new Text('হ্যাঁ'),
          ),
        ],
      ),
    )) ?? false;
  }


  Widget searchField(){ //search input field
    return Container(
        child:TextField(
          controller:searchTextEditingCtlr,
          autofocus: true,
          style: TextStyle(color:Colors.white, fontSize: 18),
          decoration:InputDecoration(
            hintStyle: TextStyle(color:Colors.white, fontSize: 18),
            hintText: "Search",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.transparent, width:2),
            ),//under line border, set OutlineInputBorder() for all side border
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.transparent, width:2),
            ), // focused border color
          ), //decoration for search input field
          // onChanged: (value){
          //   query = value; //update the value of query
          //   getSuggestion(); //start to get suggestion
          // },
        )
    );

  }

  Widget showSearchSuggestions(){
    return searchList.isEmpty?Center(child: Text(notfoundData,style: TextStyle(color: Colors.black),)) :ListView.builder(
     // controller: _scrollControllerForSearchList,
      itemCount: searchList.length,
      itemBuilder: (BuildContext context, int index) =>
          InkWell(
            onTap: (){
              showSingeBusinessInformtionShop(int.parse(searchList[index].id)).then((res) {
                if(res!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowBusinessInformation(int.parse(searchList[index].id))));
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
                  child: Center(child: Text(searchList[index].orgName[0].toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
                title:RichText(
                  text: TextSpan(
                      text: searchList[index].orgName.substring(0,query.length), style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),
                      children:[
                        TextSpan(
                          text: searchList[index].orgName.substring(query.length),
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
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
                          "${searchList[index].thana},${searchList[index]
                              .district}"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(searchList[index].orgContact.toString(),
                          style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.bold,color: Constant.black,),),
                        Text(searchList[index].visitedDateTime.toString(),
                          style: GoogleFonts.roboto(fontSize: 10,color: Colors.green),)
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



  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        //  onWillPop:()async{
        //    Future.value(true);
        //  },
        child: Scaffold(
          endDrawerEnableOpenDragGesture: false,
          //  drawerScrimColor: Colors.yellow,
          key:_drawerKey,
          drawer: Drawer(
            child: new ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 30),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName==null?'Loading..':userName,style: GoogleFonts.notoSans(color: Color(0xff333333),fontWeight: FontWeight.bold),),
                            Text(userRole==null?'Team Name':userRole,style: GoogleFonts.notoSans(color: Color(0xff333333),fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                      Container(
                          height: 60,
                          width: 60,
                          child:
                          // (userImage == null) ?
                          Image.asset('assets/avatar-circle.png')
                        // : Image.network(userImage ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Image.asset('assets/icondrawerone.png'),
                  title: Text('রিপোর্ট',style: GoogleFonts.notoSans(color: Color(0xff333333),fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/reportScreen');
                  },
                ),
                SizedBox(height: 5,),
                ListTile(
                  tileColor: Colors.white,
                  leading: Image.asset('assets/icondrawertwo.png'),
                  title: Text('পরবর্তি ফলোআপ',style: GoogleFonts.notoSans(color: Color(0xff333333),fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/netFollowUPScreen');
                  },
                ),
                SizedBox(height:MediaQuery.of(context).size.height/2.5,),
                ListTile(
                  title: Text('লগ আউট করুন',style: GoogleFonts.notoSans(color: Colors.red,fontWeight: FontWeight.bold),),
                  leading: Icon(Icons.logout,color: Colors.red,),
                  onTap: (){
                    logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/homeScreen', (Route<dynamic> route) => false);

                  },
                ),
                ListTile(
                  title: Text('V-2.0.0',style: GoogleFonts.notoSans(color: Colors.black,),),
                  leading: Text(''),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Constant.primaryColor,
            titleSpacing: 10.0,
            leading: searching?IconButton(
              icon:Icon(Icons.arrow_back),
              onPressed:(){
                searchTextEditingCtlr.clear();
                searchList.clear();
                setState(() {
                  searching = false;
                  //set not searching on back button press
                });
              },
            ):IconButton(
              icon: Icon(Icons.menu),
                onPressed: () => _drawerKey.currentState.openDrawer(),
            ),
            title: searching?searchField(): Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:
                              // (userImage == null) ?
                              AssetImage('assets/avatar-circle.png')
                            //: NetworkImage(userImage),
                          )
                      )),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(userName==null?'Loading..':userName,
                                style: GoogleFonts.notoSans(fontSize: 16),)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(userRole==null?'Loading..':userRole,
                              style: GoogleFonts.roboto(fontSize: 13),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: IconButton(
                    icon:Icon(Icons.search,size: 30,),
                      onPressed:(){
                      print(_visitList.length);
                       searchList.clear();
                        setState(() {
                          searching = true;
                          getSuggestion();
                        });
                      }
                  )

              ),
            ],
          ),
          body:searching?showSearchSuggestions(): loading?Center(child: CircularProgressIndicator()):_visitList.isEmpty?Center(child: Text('ভিজিট লিস্টে কোনো তথ্য নেই',style: TextStyle(color: Colors.red,fontSize: 20),)):ListView.builder(
                   controller: _scrollControllerForVisitPlace,
                  itemCount:_visitList.length+1,
                  itemBuilder: (BuildContext context,int index){
                        if(index==_visitList.length){
                          return innerLoading?Center(child: CircularProgressIndicator()):Text("");
                        }
                    return InkWell(
                      onTap: ()async{
                        // call api function
                        showSingeBusinessInformtionShop(int.parse(_visitList[index].id));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowBusinessInformation(int.parse(_visitList[index].id))));

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
                            child: Center(child: Text(_visitList[index].orgName[0].toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20),)),
                          ),
                          title: Text(_visitList[index].orgName,style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.green),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 5),
                                child: Text("${_visitList[index].thana},   ${_visitList[index].district}"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(_visitList[index].orgContact,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                                  Text(_visitList[index].visitedDateTime.toString(),style: GoogleFonts.roboto(fontSize: 10,color: Colors.green,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                              padding: EdgeInsets.only(top: 15),
                              child: Icon(Icons.keyboard_arrow_right,size: 20,)
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  }

                ),
          floatingActionButton:searching?Text(''): FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitRegisterScreenOne()));
              // Add your onPressed code here!
            },
            child: Icon(Icons.add,color: Colors.white,),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
