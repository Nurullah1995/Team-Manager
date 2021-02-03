import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Controller/District/DistrictController.dart';
import 'package:test_app/Model/District/FetchAllDistrictModel.dart';
import 'package:test_app/Service/district_service.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/Visitor/VisitRegisterScreenOne.dart';
import 'package:test_app/View/Widget/MaterialButtonForWholeApp.dart';


class DistrictListType extends StatefulWidget {
  @override
  _DistrictListTypeState createState() => _DistrictListTypeState();
}

class _DistrictListTypeState extends State<DistrictListType> {
  DistrictController _districtController=Get.put(DistrictController());
  List<FetchAllDistrict> _districtList= List<FetchAllDistrict>();
  @override
  void initState() {
    // TODO: implement initState
    fetchDistrictList().then((response) {
       setState(() {
         _districtList=response;
       });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constant.textColorWhite,
        appBar:AppBar(
          backgroundColor: Constant.textColorWhite,
          leading:IconButton(
            icon: Icon(Icons.arrow_back,color:Constant.primaryTextColorGray,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("জেলা সিলেক্ট করুন",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
              IconButton(
                icon: Icon(Icons.search,size: 30,color: Constant.primaryTextColorGray),
                onPressed: (){
                  showSearch(context: context, delegate: SearchForDistrictType(_districtList));
                },
              )
            ],
          ),
        ),
        body:_districtList==null?Center(child: CircularProgressIndicator()):Container(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount:_districtList.length,
                  itemBuilder:(BuildContext context,int index)=>Container(
                      child: Container(
                        child: Column(
                          children: [
                            RadioListTile(
                              groupValue:_districtController.selectedDistrictItem,
                              title: Text(_districtList[index].name),
                              value: _districtList[index].id.toString(),
                              onChanged: (val) {
                                setState(() {
                                  _districtController.selectedDistrictItem= val;
                                  print(_districtController.selectedDistrictItem);
                                });
                              },
                            ),
                            Divider(),
                          ],
                        ),
                      )
                  ),
                ),
              ),
              MaterialButtonForWhole('নির্বাচন করুন',onPressed: (){
                _districtController.selectedDistrictItemNameFunction(_districtList);
                print(_districtController.selectedDistrictItem);
                print(_districtController.selectedDistrictItemName);
                Navigator.pop(context);
              },
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}


class SearchForDistrictType extends SearchDelegate<dynamic>  {
  final List<FetchAllDistrict> districtList;
  SearchForDistrictType(this.districtList);
  // String radioItem = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Navigator.pop(context);
        close(context,null);
      },
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

//  final List<CategoryShopController> listExample;
//  Search(this.listExample);

//  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<FetchAllDistrict> suggestionList = [];
    query.isEmpty
        ? suggestionList = districtList //In the true case
        : suggestionList.addAll(districtList.where(
      // In the false case
          (element) => element.name.toLowerCase().startsWith(query),
    ));

    return GetBuilder<DistrictController>( // specify type as Controller
      init: DistrictController(), // intialize with the Controller
      builder: (_controller) => Column(
        children: [
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  groupValue: _controller.selectedDistrictItem,
                  title: Text(suggestionList[index].name),
                  value:suggestionList[index].id.toString(),
                  onChanged: (val) {
                    _controller.setUpdateDistrictItem(val);
                  },
                );
              },
            ),

          ),
          MaterialButtonForWhole('নির্বাচন করুন', onPressed: (){
            _controller.selectedDistrictItemNameFunction(districtList);
            print(_controller.selectedDistrictItem);
            print(_controller.selectedDistrictItemName);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitRegisterScreenOne()));
          }),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
}