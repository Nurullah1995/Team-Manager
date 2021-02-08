
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Service/register_service.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/View/Widget/SubmiDialog.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

    final TextEditingController _nameCtlr=TextEditingController();
    final TextEditingController _phoneNoCtlr=TextEditingController();
    final TextEditingController _pinNumberCtlr=TextEditingController();
    final TextEditingController _confirmPinCtlr=TextEditingController();


      Widget _textFormField(TextEditingController controller,){
        return TextFormField(
          controller:controller ,
            validator: (value) {
              if (value.isEmpty) {
                return 'প্রয়োজনীয় তথ্য যোগ করুন';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              fillColor: Colors.white,
              hintText: 'এখানে লিখুন',
            ));
      }
    Widget _textFormFieldForNumber(TextEditingController controller,int maxlength){
      return TextFormField(
         keyboardType: TextInputType.number,
          maxLength: maxlength,
          controller:controller ,
          validator: (value) {
            if (value.isEmpty) {
              return 'প্রয়োজনীয় তথ্য যোগ করুন';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            border: InputBorder.none,
            fillColor: Colors.white,
            hintText: 'এখানে লিখুন',
          ));
    }
      Widget _title(String text){
        return  Container(
          alignment: Alignment.topLeft,
          child: Text(text,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'SF Pro Text Regular')),
        );
      }
     String companyIteamId;
     String teamId;



    final _formKey = GlobalKey<FormState>();
    bool autovalidate = false;
    _formValidation(BuildContext context) {
      if (_formKey.currentState.validate()) {
        // form is valid, proceed further
        _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
      }

      setState(() {
        autovalidate=true;
      });

    }

    List companylist = List();

    Future<dynamic> fetchCompanyList() async {
      var res = await http.get(
          Uri.encodeFull("${Constant.url}/api/companies"),
          headers: {"Accept": "application/json"});
      var resBody = json.decode(res.body);

      setState(() {
       // print(resBody);
        companylist = resBody['companies'] as List;
       // print(companylist[0]['name']);
      });

      return "Sucess";
    }

    List teamList = List();

    Future<dynamic> fetchTeamList(String id) async {
      var res = await http.get(
          Uri.encodeFull("${Constant.url}/api/teams?company=$id"),
          headers: {"Accept": "application/json"});
      var resBody = json.decode(res.body);

      setState(() {
        teamList = resBody['teams'];
        print(teamList[0]['name']);
      });

      return "Sucess";
    }


      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCompanyList();
    fetchTeamList(1.toString());
  }

    @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
        child: Scaffold(
           appBar: AppBar(
             backgroundColor: Constant.primaryColor,
             title: Text("তথ্য যোগ করুন",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.textColorWhite),),
           ),
          body: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                    height: MediaQuery.of(context).size.height/1.3,
                    child: Form(
                      key: _formKey,
                      child: new ListView(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('কোম্পানির নাম'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  //  labelText: 'ভাড়ার পরিমাণ',
                                  hintText: 'সিলেক্ট করুন ',
                                ),
                                value: companyIteamId,
                                onChanged: (item) {
                                  setState(() {
                                    teamList = [];
                                    teamId = null;
                                    companyIteamId = item;
                                    print(companyIteamId);
                                    fetchTeamList(companyIteamId);
                                  });
                                },
                                validator: (value) => value == null ? 'প্রয়োজনীয় তথ্য যোগ করুন' : null,
                                items:
                                companylist != null?companylist.map((item) {
                                  return DropdownMenuItem<String>(
                                    child: Text(item['name']),
                                    value: item['id'].toString(),
                                  );
                                }).toList():[]
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('টিমের নাম'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  //  labelText: 'ভাড়ার পরিমাণ',
                                  hintText: 'সিলেক্ট করুন',
                                ),
                                value: teamId,
                                onChanged: (item) {
                                  setState(() {
                                    teamId = item;
                                    print(teamId);
                                  });
                                },
                                validator: (value) => value == null ? 'প্রয়োজনীয় তথ্য যোগ করুন' : null,
                                items:
                                teamList != null?teamList.map((item) {
                                  return DropdownMenuItem<String>(
                                    child: Text(item['name']),
                                    value: item['id'].toString(),
                                  );
                                }).toList():[]
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('নাম '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
                            child: _textFormField(_nameCtlr),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('মোবাইল নাম্বার'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,),
                            child: _textFormFieldForNumber(_phoneNoCtlr,11),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('পিন নাম্বার'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,),
                            child: _textFormFieldForNumber(_pinNumberCtlr,6),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('কনফার্ম পিন নাম্বার'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,),
                            child: _textFormFieldForNumber(_confirmPinCtlr,6),
                          ),
                        ],
                      ),
                    )
                ),
                SizedBox(height: 10,),
                new Container(
                  child: RaisedButton(
                    onPressed: (){
                       _formValidation(context);
                       Dialogs.showLoadingDialog(context,Constant.keyLoad);
                       addUser(companyIteamId,teamId,_nameCtlr.text,_phoneNoCtlr.text,_pinNumberCtlr.text,_confirmPinCtlr.text).then((result){
                         if(result['success']==true){

                           Get.snackbar('${result['message']}','',snackPosition:SnackPosition.TOP);
                           Navigator.pushNamed(context, '/homeScreen');
                         }
                          else if(result['success']==null){
                           Navigator.of(Constant.keyLoad.currentContext,rootNavigator: true).pop();
                           Get.snackbar('প্রদানকৃত নাম্বারে ইতোমধ্যে নিবন্ধন সম্পন্ন হয়েছে।','',snackPosition:SnackPosition.TOP);
                         }

                       });
                    },
                    color: Constant.primaryColor,
                    child: Text('সাবমিট করুন',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                )
              ],
            ),
          )
        ),
        );
  }
}
