import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Controller/Login/loginResponseController.dart';
import 'package:test_app/Service/Login_service.dart';
import 'package:test_app/Service/SharePrefarence.dart';
import 'package:test_app/Util/Constant.dart';

import '../../Widget/SubmiDialog.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumber=TextEditingController();
  final TextEditingController _pinNumber=TextEditingController();



  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  bool _passwordVisible = true;

  _formValidation() {
    if (formKey.currentState.validate()) {
      //form is valid, proceed further
      formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
      setState(() {
        autovalidate=true;
     //  _userLogin();
      });
    }
  }

  _userLogin(){
    Dialogs.showLoadingDialog(context,Constant.keyLoad);
    login(_phoneNumber.text,_pinNumber.text).then((response) {
      if(response['token']!=null){
        setValue(response['token']);
        print(response['token']);
        setUserName(response['user']['name']);
        setUserRole(response['user']['team']);
        setUserImage(response['user']['image']);
        setUserPhoneNo(response['user']['contact']);
        Navigator.pushReplacementNamed(context,'/visitorScreen');
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
    return WillPopScope(
      onWillPop:()async{
        Navigator.pop(context);
        return false;
      } ,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:  Color(0xffffffff),
          appBar: AppBar(
           automaticallyImplyLeading: false,
            backgroundColor:Color(0xffffffff) ,
            title: Text("লগইন করুন",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),

          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xffffffff),
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,top: 10),
              child: Form(
                key:formKey,
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Image.asset("assets/logo.png",height: 150,width: 250,),
                    Text("OUTREACH TRACKER",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("ফোন নাম্বার",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                    ),
                    TextFormField(
                      controller: _phoneNumber,
                      maxLength: 11,
                      keyboardType:TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: Colors.grey,
                        hoverColor:Colors.grey ,
                        prefixIcon: Icon(Icons.call,),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5,),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("পিন কোড",style: GoogleFonts.roboto(fontSize:15 ,color:Color(0xff000000) ),)
                    ),
                    TextFormField(
                      controller: _pinNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                          return 'Please enter your password';
                        }
                        if (value.length < 5) {
                          return 'Must be more than 4 charater';
                        }
                        return null;
                      },
                      //val.length < 6 ? 'Password too short.' : null,
                      // onSaved: (val) => _password = val,
                      obscureText: _passwordVisible,
                    ),
                    SizedBox(height: 5,),
                    Expanded(
                      flex: 3,
                      child: Container(
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _formValidation();
                        if(autovalidate==true){
                          _userLogin();
                          Dialogs.showLoadingDialog(context,Constant.keyLoad);
                          Navigator.pushNamed(context, '/visitorScreen');
                        }
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
                        child: Center(child: Text("এগিয়ে যান",style: GoogleFonts.notoSans(fontSize: 16),)),
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
      ),
    );
  }
}
