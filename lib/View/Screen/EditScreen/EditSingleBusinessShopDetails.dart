
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:test_app/Controller/Category/ShopCategoryForUpdatePage.dart';
import 'package:test_app/Controller/District/DistrictCategoryForUpdePage.dart';
import 'package:test_app/Model/Category/FetchCategoryShopModel.dart';
import 'package:test_app/Model/District/FetchAllDistrictModel.dart';
import 'package:test_app/Model/ShowBusinessInfo/ShowSingleBusinessInformation.dart';
import 'package:test_app/Service/CategoryShopService.dart';
import 'package:test_app/Service/district_service.dart';
import 'package:test_app/Service/updateSingle_service.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Widget/SubmiDialog.dart';




class EdiitShopBusinessDetailsInfo extends StatefulWidget {
  final int singleProductId;
  final VisitedPlace singleProductDetails;
  EdiitShopBusinessDetailsInfo(this.singleProductId,this.singleProductDetails);
  @override
  _EdiitShopBusinessDetailsInfoState createState() => _EdiitShopBusinessDetailsInfoState();
}

class _EdiitShopBusinessDetailsInfoState extends State<EdiitShopBusinessDetailsInfo> {
   ShopCategoryControllerForUpageScreen _shopCategoryController=Get.put(ShopCategoryControllerForUpageScreen());
   DistrictControllerForUpdateScreen _districtController=Get.put(DistrictControllerForUpdateScreen());
  List<FetchShopCategory> categoryTypelist;
  List<FetchAllDistrict> districtList;

  DateTime selectedDate = DateTime.now();
 // DateTime selectedStartDate;
  double latitute;
  double longitude;
  TextEditingController phoneNumberCtlr=TextEditingController();
  TextEditingController ownerNameCtlr=TextEditingController();
  TextEditingController businessNameCtlr=TextEditingController();
  TextEditingController thanaTypeCtlr=TextEditingController();
  TextEditingController detailsAddressCtlr=TextEditingController();
  TextEditingController dateCtlr=TextEditingController();
  File images_one;

   var demoDate='';
   var demoImage='https://www.dicetower.com/sites/default/files/styles/image_300/public/game-art/no-image-available_1.png?itok=4AoejwSQ';

  @override
  void initState() {
    // TODO: implement initState

       phoneNumberCtlr=TextEditingController(text: widget.singleProductDetails.contact);
       ownerNameCtlr=TextEditingController(text: widget.singleProductDetails.ownerName);
       businessNameCtlr=TextEditingController(text: widget.singleProductDetails.orgName);
       //businessTypeCtlr=TextEditingController(text: widget.singleProductDetails.orgTypeName);
       thanaTypeCtlr=TextEditingController(text: widget.singleProductDetails.thana);
       detailsAddressCtlr=TextEditingController(text: widget.singleProductDetails.address);
       dateCtlr=TextEditingController(text: widget.singleProductDetails.nextFollowup);
       // districtTypeCtlr=TextEditingController(text: widget.singleProductDetails.district);
       _shopCategoryController.selectedUpdateBusinessItemName=widget.singleProductDetails.orgTypeName;
        _districtController.selectedDistrictItemName=widget.singleProductDetails.district;
    fetchCategoyShopList().then((res) {
      setState(() {
        categoryTypelist=res;
      });
    });
    fetchDistrictList().then((res){
      setState(() {
        districtList=res;
      });
    });
    super.initState();
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked == null){
       selectedDate=null;
    }else if(picked!=null){
      setState(() {
        selectedDate = picked;
        dateCtlr.text = DateFormat('d MMMM y').format(selectedDate);
        print(dateCtlr.text);
      });
    }

  }

 String _formateDate(String date){
           if(date!=null){
             DateTime newDatetime=new DateFormat("d MMMM y").parse(date);
             DateFormat formatter = DateFormat('yyyy-MM-dd');
             var datetime = formatter.format(newDatetime);
             // print(datetime);
             return datetime;
           } else {
             return null;
           }
   }


  int  findCategoryTypeIdFromName(List<FetchShopCategory>  categoryList, String catTypeName){
    var trendIndex= categoryList.indexWhere((f) => f.name == catTypeName);
    print(trendIndex);
   return categoryList[trendIndex].id;
  }

  int  findDistrictIdFromName(List<FetchAllDistrict>  categoryList, String districtTypeName){
    var trendIndex= categoryList.indexWhere((f) => f.name == districtTypeName);
    print(trendIndex);
    return categoryList[trendIndex].id;
  }




  _formValidation(BuildContext context)async {
   var CategoryTypeId= findCategoryTypeIdFromName(categoryTypelist,_shopCategoryController.selectedUpdateBusinessItemName);
     print(CategoryTypeId);
    var districtId=findDistrictIdFromName(districtList,_districtController.selectedDistrictItemName);
   print(districtId);
    var formatedDate= dateCtlr.text;
   //print(_shopCategoryController.selectedUpdateBusinessItemName);

   if (Constant.formkeyforEdit.currentState.validate()) {
     // form is valid, proceed further
     Constant.formkeyforEdit.currentState.save();
     //save once fields are valid, onSaved method invoked for every form fields
     Dialogs.showLoadingDialog(context, Constant.keyLoad);
     updateSingleBusinessItem(
         widget.singleProductId,
         phoneNumberCtlr.text==null?widget.singleProductDetails.contact:phoneNumberCtlr.text,
         ownerNameCtlr.text==null?widget.singleProductDetails.ownerName:ownerNameCtlr.text,
         businessNameCtlr.text,
         CategoryTypeId.toString(),
          formatedDate!=""?_formateDate(formatedDate):"",
         images_one,
         districtId.toString(),
         thanaTypeCtlr.text==null?widget.singleProductDetails.thana:thanaTypeCtlr.text,
         detailsAddressCtlr.text==null?widget.singleProductDetails.address:detailsAddressCtlr.text)
         .then((response) {
       if(response.statusCode == 200)
       {
         response.stream.bytesToString().then((message){
           //invoking login
           print(message);
           Navigator.pushNamed(context, '/submiSuccessful');
         });
       }
       else
       {

         response.stream.bytesToString().then((message){
           print(message);

         });

       }
     }
     );
   }

    setState(() {
      autovalidate=true;
    });

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
                Navigator.pop(context);
              },
            ),
            backgroundColor: Constant.textColorWhite,
            title:Text("প্রতিষ্ঠানের তথ্য আপডেট করুন",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: Constant.formkeyforEdit,
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
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Text("বব্যবসা প্রতিষ্ঠানের মালিকের নাম",style: TextStyle(color: Color(0xff4A4A4A)),),
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
                      decoration: InputDecoration(
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(8),
                        hintText: "এখানে লিখুন",
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Text("বব্যবসা প্রতিষ্ঠানের নাম",style: TextStyle(color: Color(0xff4A4A4A)),),
                          Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller:businessNameCtlr ,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'অনুগ্রহ পূর্বক বব্যবসা প্রতিষ্ঠানের নাম লিখুন';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(8),
                        hintText: "এখানে লিখুন",
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Text("ব্যবসা প্রতিষ্ঠানের ধরন",style: TextStyle(color: Color(0xff4A4A4A)),),
                          Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                        ],
                      ),
                    ),
                    TextFormField(
                     // controller: businessTypeCtlr,
                      onTap: (){
                        Navigator.pushNamed(context, '/updateCatScreen');
                      },
                      decoration:  InputDecoration(
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(8),
                        focusColor: Colors.grey,
                        hoverColor:Colors.grey ,
                        hintText: _shopCategoryController.selectedUpdateBusinessItemName,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ),
                      ),
                     // validator: (value) {
                     //   if (value.isEmpty) {
                     //     return 'অনুগ্রহ পূর্বক প্রতিষ্ঠানের লিখুন ধরন সিলেক্ট করুন';
                     //   }
                     //   return null;
                     // },
                    ),

                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Text("জেলার নাম সিলেক্ট করুন",style: TextStyle(color: Color(0xff4A4A4A)),),
                          Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                        ],
                      ),
                    ),
                    TextFormField(
                     // controller: districtTypeCtlr,
                      onTap: (){
                        Navigator.pushNamed(context, '/updateDistrictScreen');
                      },
                      decoration:  InputDecoration(
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(8),
                        focusColor: Colors.grey,
                        hoverColor:Colors.grey ,
                        hintText: _districtController.selectedDistrictItemName,
                            //!=null?widget.singleProductDetails.district:_districtController.selectUpdateDistictname,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ),
                      ),
//                      validator: (value) {
//                        if (value.isEmpty) {
//                          return 'অনুগ্রহ পূর্বক জেলার নাম লিখুন';
//                        }
//                        return null;
//                      },
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'অনুগ্রহ পূর্বক বিস্তারিত ঠিকানা লিখুন ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(8),
                        hintText: "এখানে লিখুন",
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Text("পরবর্তি ফলোয়াপ",style: TextStyle(color: Color(0xff4A4A4A)),),
                          Text("",style: TextStyle(color: Colors.red,fontSize: 20),),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: dateCtlr,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,                      // Added this
                        contentPadding: EdgeInsets.all(8),
                        focusColor: Colors.grey,
                        hoverColor:Colors.grey ,
                        suffixIcon: IconButton(
                          icon: Icon(
                             Icons.calendar_today,
                          ),
                          onPressed: (){
                              _selectDate(context);
                          },
                        ),
                      ),
                      // validator: (value) {
                      //   // add your custom validation here.
                      //   if (value.isEmpty) {
                      //     return 'তারিখ সিলেক্ট করুন';
                      //   }
                      //   if (value.length < 5) {
                      //     return 'Must be more than 4 charater';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Row(
                        children: [
                          Text("ব্যবসা প্রতিষ্ঠানের ছবি আপলোড করুন",style: TextStyle(color: Color(0xff4A4A4A)),),
                          Text("*",style: TextStyle(color: Colors.red,fontSize: 20),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (_) => Center(child: _DialogForFistCam()),
                          );
                        },
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child:images_one !=null? Image.file(images_one,fit: BoxFit.fill,)
                          :Image.network(widget.singleProductDetails.orgImg!=null?widget.singleProductDetails.orgImg:demoImage,fit: BoxFit.fill,),
                        )
                    ),
                    Text(images_one==null?'অনুগ্রহপূর্বক ব্যবসা  প্রতিষ্টানের ফটো আপলোড করুন':'ফটো সফল ভাবে আপলোড হয়েছে ',style: GoogleFonts.roboto(color: Colors.green,fontSize: 16),),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        _formValidation(context);
                        Constant.formkey.currentState?.reset();
                       //_formValidation();
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
                        child: Center(child: Text("সাবমিট করুন",style: GoogleFonts.notoSans(fontSize: 16,color: Colors.white),)),
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
