import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Service/CheckOTPService.dart';
import 'package:test_app/Service/CreateOtpService.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/PinRest/PinResetScreen.dart';
import 'package:test_app/View/Widget/AuthStepOnePageExtenderContainer.dart';
import 'package:test_app/View/Widget/MaterialButtonForWholeApp.dart';



class AuthenticationStepOneScreen extends StatefulWidget {
   String phoneNumber;
  AuthenticationStepOneScreen(this.phoneNumber);
  @override
  _AuthenticationStepOneScreenState createState() => _AuthenticationStepOneScreenState();
}

class _AuthenticationStepOneScreenState extends State<AuthenticationStepOneScreen> with SingleTickerProviderStateMixin {
  String otopUpdateMessage='';
  String confirmMobileText='';

  final TextEditingController _phoneNofromdialog=TextEditingController();
  final TextEditingController _otpOne=TextEditingController();
  final TextEditingController _otpTow=TextEditingController();
  final TextEditingController _otpThree=TextEditingController();
  final TextEditingController _otpFour=TextEditingController();

  final int time = 120;
  AnimationController _controller;

  Timer timer;
  int totalTimeInSeconds;
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  // AnimationController _controller;
  // Animation<double> animation;
  // var countdown;
  // int actual;

  @override
  void initState() {
    print(widget.phoneNumber);
    super.initState();
    createOTp(widget.phoneNumber);
    animationStart();
  }

  void restartTimer() {
    setState(() {
      _controller.reset();
      _controller.forward();
    });
  }

  void animationStart() {
    totalTimeInSeconds = time;
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: time))
      ..addStatusListener((status) {
      });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Null> _startCountdown() async {
    setState(() {
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }
  //
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;


  Widget _otpTextField(int digit) {
    return new Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
                width: 2.0,
                color: Colors.black,
              ))),
    );
  }

  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        var otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();

        // Verify your otp by here. API call
      }
    });
  }

  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
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
          title: Text("ফোন নম্বর নিশ্চিত করুন",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.primaryTextColorGray),),
        ),
        body: Column(
          children: [
            SizedBox(height: 10,),
            AuthStepOnePageExtendedContainer(confirmMobileText,widget.phoneNumber,(){
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
                                  createOTp(widget.phoneNumber);
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
              height: MediaQuery.of(context).size.height/3.4,
              width: MediaQuery.of(context).size.width,
              color: Constant.textColorWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                      child: Text('আপনার মোবাইলে পাঠানো ৪ ডিজিটের কোডটি লিখুন',style: GoogleFonts.roboto(color: Constant.primaryTextColorGray,fontSize: 16),)),
                  _getInputField,
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: Text(otopUpdateMessage,style: GoogleFonts.roboto(color: Colors.red,fontSize: 16,),),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: OtpTimer(widget.phoneNumber,restartTimer,_controller, 15.0, Colors.black,)
                  ),
                ],
              ),
            ),
                MaterialButtonForWhole('এগিয়ে যান',onPressed: (){
                   String conCatOtp=(_firstDigit.toString()+_secondDigit.toString()+_thirdDigit.toString()+_fourthDigit.toString());
                   print(widget.phoneNumber);
                   print(conCatOtp);
                   checkOTP(widget.phoneNumber, conCatOtp).then((respons) {
                     print(respons);
                     if(respons['isMatched']==true){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>PinRestScreen(widget.phoneNumber)));
                     }
                     setState(() {
                       otopUpdateMessage=respons['message'];
                     });
                   });

                },),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _otpKeyboardInputButton(
                                  label: "1",
                                  onPressed: () {
                                    _setCurrentDigit(1);
                                  }),
                              _otpKeyboardInputButton(
                                  label: "2",
                                  onPressed: () {
                                    _setCurrentDigit(2);
                                  }),
                              _otpKeyboardInputButton(
                                  label: "3",
                                  onPressed: () {
                                    _setCurrentDigit(3);
                                  }),
                            ],
                          ),
                        ),
                        new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _otpKeyboardInputButton(
                                  label: "4",
                                  onPressed: () {
                                    _setCurrentDigit(4);
                                  }),
                              _otpKeyboardInputButton(
                                  label: "5",
                                  onPressed: () {
                                    _setCurrentDigit(5);
                                  }),
                              _otpKeyboardInputButton(
                                  label: "6",
                                  onPressed: () {
                                    _setCurrentDigit(6);
                                  }),
                            ],
                          ),
                        ),
                        new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _otpKeyboardInputButton(
                                  label: "7",
                                  onPressed: () {
                                    _setCurrentDigit(7);
                                  }),
                              _otpKeyboardInputButton(
                                  label: "8",
                                  onPressed: () {
                                    _setCurrentDigit(8);
                                  }),
                              _otpKeyboardInputButton(
                                  label: "9",
                                  onPressed: () {
                                    _setCurrentDigit(9);
                                  }),
                            ],
                          ),
                        ),
                        new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new SizedBox(
                                width: 80.0,
                              ),
                              _otpKeyboardInputButton(
                                  label: "0",
                                  onPressed: () {
                                    _setCurrentDigit(0);
                                  }),
                              _otpKeyboardActionButton(
                                  label: new Icon(
                                    Icons.backspace,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_fourthDigit != null) {
                                        _fourthDigit = null;
                                      } else if (_thirdDigit != null) {
                                        _thirdDigit = null;
                                      } else if (_secondDigit != null) {
                                        _secondDigit = null;
                                      } else if (_firstDigit != null) {
                                        _firstDigit = null;
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        )
      ),
    );
  }
}



class OtpTimer extends StatelessWidget {
  final String phoneNumber;
  final Function restartTimer;
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.phoneNumber,this.restartTimer,this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return timerString == '0:00'
              ? InkWell(
            child: Text('পুনরায় কোড পাঠান',
                style: GoogleFonts.roboto(color: Colors.green,fontSize: 16,)
            ),
            onTap: () {
              this.restartTimer();
              createOTp(phoneNumber);
            },
          )
              : Text(
              "পুনরায় কোড পাঠাতে অপেক্ষা করুন" + "  $timerString",
              style: GoogleFonts.roboto(color: Constant.primaryTextColorGray,fontSize: 16,)
          );
        });
  }
}


