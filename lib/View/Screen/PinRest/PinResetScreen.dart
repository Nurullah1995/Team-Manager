import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Service/ResetPinService.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/Login/LoginScreen.dart';
import 'package:test_app/View/Widget/MaterialButtonForWholeApp.dart';
import 'package:test_app/View/Widget/authStepOnePageTopContainer.dart';

class PinRestScreen extends StatefulWidget {
   String phoneNumber;
  PinRestScreen(this.phoneNumber);
  @override
  _PinRestScreenState createState() => _PinRestScreenState();
}

class _PinRestScreenState extends State<PinRestScreen> {
  final TextEditingController _pineOne=TextEditingController();
  final TextEditingController _pinTwo=TextEditingController();
  final TextEditingController _phoneNofromdialog=TextEditingController();

  final formKey = GlobalKey<FormState>();

  _formValidation() {
    if (formKey.currentState.validate()) {
      //form is valid, proceed further
      formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields

    }
    print(widget.phoneNumber);
    resetPin(_pineOne.text, _pinTwo.text, widget.phoneNumber).then((response){

      Get.snackbar('ধন্যবাদ', response['message'],snackPosition:SnackPosition.BOTTOM);
      if(response['success']==true){
       Navigator.pushNamed(context, '/pirResetLodader');
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset:false,
          //  backgroundColor:  Color(0xffffffff),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Constant.primaryTextColorGray,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor:Color(0xffffffff) ,
            title: Text("পিন রিসেট করুন",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),
          ),
          body: Column(
            children: [
              SizedBox(height: 10,),
              AuthStepOnePageContainer(widget.phoneNumber,(){
                 print('call this function');
                 Get.dialog(
                     AlertDialog(
                         content: Wrap(
                           children: [
                             Text("ফোন নাম্বার",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),
                             TextFormField(
                               controller:_phoneNofromdialog,
                               maxLength: 11,
                               keyboardType:TextInputType.number,
                               decoration: InputDecoration(
                                 focusColor: Colors.grey,
                                 hoverColor:Colors.grey ,
                                 prefixIcon: Icon(Icons.call,),
                               ),

                             ),
                             SizedBox(height:10,),
                             Center(
                               child: RaisedButton(
                                 color: Colors.green,
                                 child: Text("সাবমিট করুন",style:GoogleFonts.notoSans(fontSize: 18,color:Colors.white),),
                                 onPressed: (){
                                     setState(() {
                                       widget.phoneNumber=_phoneNofromdialog.text;
                                     });
                                   Navigator.pop(context);
                                 },
                               ),
                             )
                           ],
                         )
                     )
                 );
              }),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 25,right: 25),
                height: MediaQuery.of(context).size.height/3.1,
                width: MediaQuery.of(context).size.width,
                color: Constant.textColorWhite,
                child: Form(
                    key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text("নতুন পিন কোড লিখুন",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                      ),
                      TextFormField(
                        controller: _pineOne,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusColor: Colors.grey,
                          hoverColor:Colors.grey ,
                          prefixIcon: Icon(Icons.lock,),
                        ),
                        validator: (value) {
                          // add your custom validation here.
                          if (value.isEmpty) {
                            return 'নতুন পিন নম্বর দিন ';
                          }
                          if (value.length < 5) {
                            return 'Must be more than 4 charater';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text("নতুন পিন কোডটি আবার লিখুন",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                      ),
                      TextFormField(
                        controller: _pinTwo,
                         keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusColor: Colors.grey,
                          hoverColor:Colors.grey ,
                          prefixIcon: Icon(Icons.lock,),
                        ),
                        validator: (value) {
                          // add your custom validation here.
                          if (value.isEmpty) {
                            return 'নতুন পিন নম্বর দিন ';
                          }
                          if (value.length < 5) {
                            return 'Must be more than 4 charater';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
             SizedBox(height: 10,),
             Container(
                height:MediaQuery.of(context).size.height/10,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
               child: Container(
                 padding: EdgeInsets.only(left: 25,right: 25),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Image.asset('assets/private-account.png'),
                       Text("পিন সম্পূর্ণ গোপনীয়। কোন অবস্থাতেই কাউকে পিন \nবলবেন না বা কোথাও প্রকাশ করবেন না।",style: GoogleFonts.notoSans(fontSize: 14,color: Constant.primaryTextColorGray),)
                     ],
                   )
               )
              ),
              Expanded(
                flex: 3,
                child: Container(
                ),
              ),
              MaterialButtonForWhole('রিসেট করুন',onPressed: (){
                  _formValidation();
              },),
              Expanded(
                flex: 2,
                child: Container(
                ),
              ),
            ],
          )
      ),
    );
  }
}
