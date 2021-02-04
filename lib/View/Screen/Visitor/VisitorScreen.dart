import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Controller/Login/loginResponseController.dart';
import 'package:test_app/Model/VisitPlace/FetchVisitedPlaceModel.dart';
import 'package:test_app/Service/SharePrefarence.dart';
import 'package:test_app/Service/Show_single_businessInstiution_info.dart';
import 'package:test_app/Service/visited_place_service.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/BusinessInfo/SearchBusinessInstitutionInformation.dart';
import 'package:test_app/View/Screen/BusinessInfo/ShowBusinessInformation.dart';
import 'VisitRegisterScreenOne.dart';

class VisitorScreen extends StatefulWidget {
  @override
  _VisitorScreenState createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  // final LoginResponseController _loginResponseController=Get.find();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static const IconData logout = IconData(0xe848, fontFamily: 'MaterialIcons');
  Future<List<FetchVisitedPlaceModel>> _visitList;
  List<FetchVisitedPlaceModel> _completedvisitList;
    String userName;
    String userImage;
    String userRole;
    String userContact;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _visitList = fetchVisitShopList();
    _completedVisitedList();
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
     });
  }

  _completedVisitedList() {
    fetchVisitShopList().then((value) {
      setState(() {
        _completedvisitList = value;
                });
              });
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
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('হা'),
          ),
        ],
      ),
    )) ?? false;
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
       //  onWillPop:()async{
       //    Future.value(true);
       //  },
        child: Scaffold(
          //  drawerScrimColor: Colors.yellow,
          key:scaffoldKey ,
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
                            Text(userRole==null?'Loading..':userRole,style: GoogleFonts.notoSans(color: Color(0xff333333),fontWeight: FontWeight.bold),),

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
                    Navigator.pushNamed(context, '/homeScreen');
                  },
                ),
                ListTile(
                  title: Text('V-1.0.0',style: GoogleFonts.notoSans(color: Colors.black,),),
                  leading: Text(''),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Constant.primaryColor,
            titleSpacing: 10.0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){
                scaffoldKey.currentState.openDrawer();
              },
            ),
            title: Row(
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: IconButton(
                    icon:Icon(Icons.search,size: 30,),
                    onPressed: (){
                      showSearch(context: context, delegate: SearchInstituteInformation(_completedvisitList));
                    },
                  )

              ),
            ],
          ),
          body:FutureBuilder<List<FetchVisitedPlaceModel>>(
            future: _visitList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final _visitList=snapshot.data;
                return _visitList.isEmpty?Center(child: Text(" এখনো লিস্টে কোনো তথ্য যোগ করা হয়নি ",style: TextStyle(color: Colors.red),))
                    :ListView.builder(
                  itemCount:_visitList.length ,
                  itemBuilder: (BuildContext context,int index)=>
                      InkWell(
                        onTap: (){
                          // call api function
                          showSingeBusinessInformtionShop(_visitList[index].id);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowBusinessInformation(_visitList[index].id)));

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
                            title: Text(_visitList[index].orgName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5,bottom: 5),
                                  child: Text("${_visitList[index].thana},${_visitList[index].district}"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(_visitList[index].orgContact,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text(_visitList[index].visitedDateTime.toString(),style: GoogleFonts.roboto(fontSize: 10),),
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
                      ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButton:FloatingActionButton(
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

