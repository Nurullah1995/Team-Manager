
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Util/Constant.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

    final TextEditingController _nameCtlr=TextEditingController();
    final TextEditingController _phoneNoCtlr=TextEditingController();
    final TextEditingController _pinNumberCtlr=TextEditingController();
    final TextEditingController _confirmPinCtlr=TextEditingController();


      Widget _textFormField(TextEditingController controller){
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
     String selectItem;

    List<String> houseTypelist=[
      'ব্যাচেলর ম্যাস পুরুষ',
      'ব্যাচেলর ম্যাস মহিলা',
      'ফ্যামিলি বাসা ',
      'ব্যাচেলর সাবলেট পুরুষ',
      'ব্যাচেলর সাবলেট মহিলা',
      'ফামিলি সাবলেট ',
      'পুরুষ  হোস্টেল'
          'মহিলা হোস্টেল',

    ];
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


    @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
           appBar: AppBar(
             backgroundColor: Constant.primaryColor,
             title: Text("তথ্য যোগ করুন",style:GoogleFonts.notoSans(fontSize: 18,color:Constant.textColorWhite),),
           ),
          body: new SingleChildScrollView(
            child: new Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                    height: MediaQuery.of(context).size.height/1.3,
                    child: Form(
                      key: _formKey,
                      child: new Column(
                        children: <Widget>[
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
                                  hintText: 'ভাড়ার পরিমাণ',
                                ),
                                value: selectItem,
                                onChanged: (item) =>
                                    setState(() => selectItem = item),
                                validator: (value) => value == null ? 'প্রয়োজনীয় তথ্য যোগ করুন' : null,
                                items:
                                houseTypelist.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
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
                            child: _title('নাম '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
                            child: _textFormField(_phoneNoCtlr),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('নাম '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
                            child: _textFormField(_pinNumberCtlr),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,),
                            child: _title('নাম '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
                            child: _textFormField(_confirmPinCtlr),
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
