import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Controller/Login/loginResponseController.dart';
import 'Model/Login/LoginModel.dart';
import 'Service/Login_service.dart';
import 'Service/SharePrefarence.dart';
import 'Util/Constant.dart';
import 'View/Screen/Authentication/AuthenticationStepOne.dart';
import 'View/Screen/Visitor/VisitorScreen.dart';
import 'View/Widget/MaterialButtonForWholeApp.dart';
import 'View/Widget/SubmiDialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  final LoginResponseController _loginResponseController=Get.put(LoginResponseController());
  final TextEditingController _phoneNumber=TextEditingController();
  final TextEditingController _pinNumber=TextEditingController();
 // final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  bool _passwordVisible = true;
  bool _load = false;


  _formValidation() {
    if (formKey.currentState.validate()) {
      //form is valid, proceed further
      formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
    setState(() {
      autovalidate=true;
     // _userLogin();
      _userLogin();
    });
  }
  }



  _userLogin(){
    Dialogs.showLoadingDialog(context,Constant.keyLoad);
    login(_phoneNumber.text,_pinNumber.text).then((response) {

      if(response['token']!=null){
        setValue(response['token']);
         setUserName(response['user']['name']);
        setUserRole(response['user']['role']);
         setUserImage(response['user']['image']);
         setUserPhoneNo(response['user']['contact']);
         Navigator.pushNamed(context,'/visitorScreen');
      }
      else if(response['errors']!=null){
        Navigator.of(Constant.keyLoad.currentContext,rootNavigator: true).pop();
          print(response['errors']['pin'][0]);
         Get.snackbar('${response['errors']['pin'][0]}','',snackPosition:SnackPosition.TOP);
      }
    });

  }




  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_load? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();

    return SafeArea(
      child: Scaffold(
        backgroundColor:  Color(0xffffffff),
        body: Container(
         width: MediaQuery.of(context).size.width,
          color: Color(0xffffffff),
          child: Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,top: 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                     SizedBox(height: 10,),
                     Image.asset("assets/logo.png",height: 150,width: 250,),

                  Container(
                    alignment: Alignment.topLeft,
                      child: Text("ফোন নাম্বার",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    maxLength: 11,
                    keyboardType:TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,                      // Added this
                      contentPadding: EdgeInsets.all(8),
                      focusColor: Colors.grey,
                      hoverColor:Colors.grey ,
                      prefixIcon: Icon(Icons.call,),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'পরবর্তি ধাপে যেতে ফোন নাম্বার দিন';
                      }
                      return null;
                    },
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("পিন কোড",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                  ),
                  TextFormField(
                    controller: _pinNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,                      // Added this
                      contentPadding: EdgeInsets.all(8),
                      focusColor: Colors.grey,
                      hoverColor:Colors.grey ,
                      prefixIcon: Icon(Icons.lock,),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: (){
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      // add your custom validation here.
                      if (value.isEmpty) {
                        return 'লগ ইন করতে পিন নাম্বার দিন';
                      }
                      if (value.length < 5) {
                        return 'Must be more than 4 charater';
                      }
                      return null;
                    },
                    obscureText: _passwordVisible,
                  ),
                  SizedBox(height: 5,),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("পিন কোড ভুলে গিয়েছেন? ",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                  ),
                  SizedBox(height: 5,),
                 Row(
                   children: [
                     InkWell(
                       onTap: (){
//                         if(_phoneNumber.text!=null){
//                           createOTp(_phoneNumber.text).then((value) {
//                             print(value);
//                           });
//
//                         }
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthenticationStepOneScreen(_phoneNumber.text)));
                       },
                       child: Container(
                           alignment: Alignment.topLeft,
                           child: Text("নতুন করে পিন সেট করুন",style: GoogleFonts.roboto(fontSize:15 ,color:Constant.primaryColor ),)
                       ),
                     ),
                     SizedBox(width: 5,),
                     Image.asset("assets/next 1.png"),
                   ],
                 ),
                  SizedBox(height: 5,),
                  Expanded(
                    flex: 3,
                    child: Container(
                    ),
                  ),
                  MaterialButtonForWhole('লগইন করুন',onPressed: (){
                    _formValidation();
                  },),
                  SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      text: 'নিবন্ধন করতে চান ?',
                      style: TextStyle(color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                          text: '   নিবন্ধন করুন ',
                          style: TextStyle(color: Constant.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                             Navigator.pushNamed(context, '/registrationScreen');
                          }),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
