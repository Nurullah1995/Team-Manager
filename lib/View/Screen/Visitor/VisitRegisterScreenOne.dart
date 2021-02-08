import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_app/Controller/Category/ShopCategoryController.dart';
import 'package:test_app/Controller/District/DistrictController.dart';
import 'package:test_app/Service/SharePrefarence.dart';
import 'package:test_app/Service/UniqueContactCheck_service.dart';
import 'package:test_app/Service/submit_allInfo-service.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Widget/SubmiDialog.dart';

class VisitRegisterScreenOne extends StatefulWidget {

  @override
  _VisitRegisterScreenOneState createState() => _VisitRegisterScreenOneState();
}

class _VisitRegisterScreenOneState extends State<VisitRegisterScreenOne> {
  ShopCategoryController _controller=Get.put(ShopCategoryController());
  DistrictController _districtController=Get.put(DistrictController());
  TextEditingController phoneNumberCtlr=TextEditingController();
  TextEditingController ownerNameCtlr=TextEditingController();
  TextEditingController businessNameCtlr=TextEditingController();
  TextEditingController businessTypeCtlr=TextEditingController();
  TextEditingController districtTypeCtlr=TextEditingController();
  TextEditingController thanaTypeCtlr=TextEditingController();
  TextEditingController detailsAddressCtlr=TextEditingController();
  TextEditingController noteCtlr=TextEditingController();
  TextEditingController dateCtlr;
  File images_one;
  String showDemoImage='https://cdn3.iconfinder.com/data/icons/photo-tools/65/select-512.png';
  String alterNativeImage='https://cdn3.iconfinder.com/data/icons/photo-tools/65/select-512.png';
  String alterNativeDate='DD/MM/YYYY';
  String demoDate='DD/MM/YYYY';
   String latitude;
   String logitute;
   var _currentAddress;


  @override
  void initState() {
    super.initState();
    _getCurrentPosition().then((value) {
      setState(() {
        latitude=value.latitude.toString();
        logitute=value.longitude.toString();
        _getGeolocationAddress(value);
        print(logitute);
        print(latitude);
      });
    });
    _controller.selectedBusinessRadioItem=null;
    _controller.selectedBusinessItemName=null;
    _districtController.selectedDistrictItemName=null;
    _districtController.selectedDistrictItem=null;
  }



  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future<Position> _getCurrentPosition() async {
    // verify permissions
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    return position;
  }

  // Method to get Address from position:

  Future<String> _getGeolocationAddress(Position position) async {
    // geocoding
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      _currentAddress= "${place.thoroughfare}, ${place.locality}";
      setState(() {
        detailsAddressCtlr.text=_currentAddress;
        print(detailsAddressCtlr.text);
      });
    }

    return "No address available";
  }



  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        images_one = File(pickedFile.path);
        print(images_one);
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        images_one = File(pickedFile.path);
        print(images_one);
      } else {
        print('No image selected.');
      }
    });
  }

  bool autovalidate = false;

 // final fkey = GlobalKey<FormState>();
   MaterialColor buttonTextColor = const MaterialColor(
     0xff39B54A,
    const <int, Color>{
      50: const Color(0xff39B54A),
      100: const Color(0xff39B54A),
      200: const Color(0xff39B54A),
      300: const Color(0xff39B54A),
      400: const Color(0xff39B54A),
      500: const Color(0xff39B54A),
      600: const Color(0xff39B54A),
      700: const Color(0xff39B54A),
      800: const Color(0xff39B54A),
      900: const Color(0xff39B54A),
    },
  );
  DateTime selectedStartDate;
  var date;

  void _pickStartDateDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
              primarySwatch: buttonTextColor,//OK/Cancel button text color
              primaryColor: const Color(0xff39B54A),//Head background
              accentColor: const Color(0xff39B54A),//selection color
            dialogBackgroundColor: Colors.white,//Background color
            textTheme: TextTheme(bodyText2: TextStyle(color:Constant.textColorWhite)),
          ),
          child: child,
        );
      },
    ).then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        selectedStartDate = pickedDate;
        print(selectedStartDate);
      });
    }
    );
  }



  _formValidation(BuildContext context) {
      print(_controller.selectedBusinessItemName);
    if (Constant.formkey.currentState.validate()) {
     // form is valid, proceed further
      Constant.formkey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
    }

    setState(() {
      autovalidate=true;
    });

  }

 dynamic selectionDate(){
     if(selectedStartDate==null){
       return;
     }
      else if(selectedStartDate!=null){
      var date= convertDateTimeDisplay(selectedStartDate.toString());
      return date;
     }
  }

 String unicheckResponse;
  _insertData(){
    date=selectionDate();
   print(date);
   submitAllInfo(
        phoneNumberCtlr.text,
        ownerNameCtlr.text,
        businessNameCtlr.text,
        _controller.selectedBusinessRadioItem,
        date,
        images_one,
        latitude,logitute,
        _districtController.selectedDistrictItem,
        thanaTypeCtlr.text,detailsAddressCtlr.text,noteCtlr.text)
        .then((response) {
      if(response.statusCode == 200)
      {
        response.stream.bytesToString().then((message){
          print(message);
          Navigator.pushNamed(context, '/submiSuccessful');
        });
      }
      else
      {
        Navigator.of(Constant.keyLoad.currentContext,rootNavigator: true).pop();
        response.stream.bytesToString().then((message){
          print(message);

        });

      }
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
       data: ThemeData(
           primaryColor:Colors.green ,
           accentColor: Colors.green,
          cardColor:  Colors.green,
           backgroundColor:  Colors.green,
//           highlightColor: red,
//           splashColor: green
       ),
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: ColorConfig.textColorWhite,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color:Constant.primaryTextColorGray,),
              onPressed: (){
                _controller.selectedBusinessRadioItem=null;
                _controller.selectedBusinessItemName=null;
                _districtController.selectedDistrictItemName=null;
                _districtController.selectedDistrictItem=null;
                Navigator.pop(context);
              },
            ),
            backgroundColor: Constant.textColorWhite,
            title:Text("প্রতিষ্ঠান ভিজিট নিবন্ধন করুন",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: Constant.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Container(
                        child: Row(
                          children: [
                            Text("ব্যবসা প্রতিষ্ঠানের ফোন নাম্বার",style: TextStyle(color: Color(0xff4A4A4A)),),
                            Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller:phoneNumberCtlr,
                        keyboardType:TextInputType.number,
                        maxLength: 11,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'অনুগ্রহ পূর্বক ব্যবসা প্রতিষ্ঠানের ফোন নাম্বার লিখুন';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,                      // Added this
                          contentPadding: EdgeInsets.all(8),
                          hintText: "এখানে লিখুন",
                        ),
                      ),
                  //  Text(unicheckResponse==null?'':unicheckResponse,style: TextStyle(color: Colors.red),),
                    SizedBox(height: 10,),
                   Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text("ব্যবসা প্রতিষ্ঠানের মালিকের নাম",style: TextStyle(color: Color(0xff4A4A4A)),),
                                Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller:ownerNameCtlr ,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'অনুগ্রহ পূর্বক বব্যবসা প্রতিষ্ঠানের মালিকের নাম লিখুন';
                              }
                              return null;
                            },
                            onTap: (){
                              fetchFoundDataList(phoneNumberCtlr.text).then((result) {
                                setState(() {
                                  ownerNameCtlr.text=result['orgOwnerName'];
                                  businessNameCtlr.text=result['orgName'];
                                  _controller.selectedBusinessItemName=result['orgTypeName'];
                                  _districtController.selectedDistrictItemName=result['districtName'];
                                  thanaTypeCtlr.text=result['thana'];
                                  detailsAddressCtlr.text=result['address'];
                                  demoDate=result['nextFollowup'];
                                  showDemoImage=result['orgImg'];
                                  _controller.selectedBusinessRadioItem=result['orgTypeId'].toString();
                                  _districtController.selectedDistrictItem=result['district'].toString();
                                });
                              });


                              // uniqueCkeckContact(phoneNumberCtlr.text).then((response) {
                              //    if(response['found']==true){
                              //      setState(() {
                              //        unicheckResponse=response['message'];
                              //        print(unicheckResponse);
                              //      });
                              //    }
                              //
                              // });
                            },
                            decoration: InputDecoration(
                              isDense: true,                      // Added this
                              contentPadding: EdgeInsets.all(8),
                              hintText: "এখানে লিখুন",
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Text("ব্যবসা প্রতিষ্ঠানের নাম",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller:businessNameCtlr ,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'অনুগ্রহ পূর্বক ব্যবসা প্রতিষ্ঠানের নাম লিখুন';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,                      // Added this
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: "এখানে লিখুন",
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("ব্যবসা প্রতিষ্ঠানের ধরন",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/registerCategory');
                                  },
                                  decoration:  InputDecoration(
                                    isDense: true,                      // Added this
                                    contentPadding: EdgeInsets.all(8),
                                    focusColor: Colors.grey,
                                    hoverColor:Colors.grey ,
                                    hintText: _controller.selectedBusinessItemName==null?'সিলেক্ট করুন':_controller.selectedBusinessItemName,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("জেলার নাম সিলেক্ট করুন",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/districtTypeforRegister');
                                  },
                                  decoration:  InputDecoration(
                                    isDense: true,                      // Added this
                                    contentPadding: EdgeInsets.all(8),
                                    focusColor: Colors.grey,
                                    hoverColor:Colors.grey ,
                                    hintText: _districtController.selectedDistrictItemName==null?'সিলেক্ট করুন':_districtController.selectedDistrictItemName,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("থানার নাম লিখুন",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller:thanaTypeCtlr ,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'অনুগ্রহ পূর্বক থানার নাম লিখুন';
                                    }
                                    return null;
                                  },
                                  decoration:  InputDecoration(
                                    isDense: true,                      // Added this
                                    contentPadding: EdgeInsets.all(8),
                                    focusColor: Colors.grey,
                                    hoverColor:Colors.grey ,
                                    hintText: "এখানে লিখুন",
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("বিস্তারিত ঠিকানা লিখুন",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller:detailsAddressCtlr ,
                                  decoration: InputDecoration(
                                    isDense: true,                      // Added this
                                    contentPadding: EdgeInsets.all(8),
                                    // hintText: _currentAddress,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("নোট",style: TextStyle(color: Color(0xff4A4A4A)),),
                                     // Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: new TextFormField (
                                    controller: noteCtlr,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      isDense: true,                      // Added this
                                      contentPadding: EdgeInsets.all(8),
                                       hintText: 'এখানে লিখুন',
                                    ),
                                    // validator: (value) {
                                    //   if (value.isEmpty) {
                                    //     return 'অনুগ্রহ নোট লিখুন';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("পরবর্তি ফলোয়াপ",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                  //
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                          selectedStartDate ==
                                              null //ternary expression to check if date is null
                                              ? demoDate!=null?demoDate:alterNativeDate
                                              : '${DateFormat('d MMMM y').format(selectedStartDate)}',
                                          style: TextStyle(
                                              color: Constant
                                                  .black,
                                              fontSize: 16,
                                              fontFamily:
                                              'SF Pro Text Regular')),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          right: 20),
                                      child:
                                      InkWell(
                                          onTap: (){
                                            _pickStartDateDialog();
                                          },
                                          child: Icon(Icons.date_range)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  child: Row(
                                    children: [
                                      Text("ব্যবসা প্রতিষ্ঠানের ছবি আপলোড করুন",style: TextStyle(color: Color(0xff4A4A4A)),),
                                      Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                InkWell(
                                    onTap: (){
                                      //  getImageFromCamera();
                                      showDialog(
                                        context: context,
                                        builder: (_) => Center(child: _DialogForFistCam()),
                                      );
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3.5,
                                      width:MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child:images_one !=null?Image.file(images_one,fit: BoxFit.fill,):
                                      Image.network(showDemoImage!=null?showDemoImage:alterNativeImage,fit: BoxFit.fill,height: 50,width: 50,),
                                    ),
                                ),
                                Text(images_one==null?'অনুগ্রহপূর্বক ব্যবসা  প্রতিষ্টানের ফটো আপলোড করুন':'ফটো সফল ভাবে আপলোড হয়েছে',style: GoogleFonts.roboto(color: Colors.green,fontSize: 16),),
                                SizedBox(height: 30,),
                                InkWell(
                                  onTap: (){
                                    _formValidation(context);
                                    Dialogs.showLoadingDialog(context, Constant.keyLoad);
                                    _insertData();
                                    // if(images_one==null){
                                    //   Get.snackbar('warning...??', 'Please give me input all of informtaion ',
                                    //     snackPosition: SnackPosition.BOTTOM,
                                    //     backgroundColor: Colors.black,
                                    //     colorText: Colors.white,
                                    //   );
                                    //
                                    // }else{
                                    //
                                    // }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    //  color: Colors.blue,
                                    //  margin: EdgeInsets.only(bottom: 50),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Constant.primaryColor,
                                    ),
                                    child: Center(child: Text("সাবমিট করুন",style: GoogleFonts.notoSans(fontSize: 16,color:Colors.white ),)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }





  Widget _DialogForFistCam()=>  Wrap(
    children: <Widget>[
      Card(
        //  color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 200,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    getImageFromCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/camera_one.png',fit: BoxFit.fill,),
                  ),
                ),
                InkWell(
                  onTap: (){
                    getImageFromGallery();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/gallery.png',fit: BoxFit.fill,),
                  ),
                )
              ],
            ),
            // color: Colors.red,
          ),
        ),
      ),
    ],
  );
}
