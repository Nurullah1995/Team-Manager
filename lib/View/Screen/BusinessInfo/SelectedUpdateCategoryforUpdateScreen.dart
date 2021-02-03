import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/Controller/Category/ShopCategoryForUpdatePage.dart';
import 'package:test_app/Model/Category/FetchCategoryShopModel.dart';
import 'package:test_app/Service/CategoryShopService.dart';
import 'package:test_app/Util/Constant.dart';
import 'package:test_app/View/Screen/Visitor/VisitRegisterScreenOne.dart';
import 'package:test_app/View/Widget/MaterialButtonForWholeApp.dart';


class SelectedBusiessCategoryScreenForUpdateScreen extends StatefulWidget {
  @override
  _SelectedBusiessCategoryScreenForUpdateScreenState createState() => _SelectedBusiessCategoryScreenForUpdateScreenState();
}

class _SelectedBusiessCategoryScreenForUpdateScreenState extends State<SelectedBusiessCategoryScreenForUpdateScreen> {

  ShopCategoryControllerForUpageScreen _shopCategoryController=Get.put(ShopCategoryControllerForUpageScreen());
  List<FetchShopCategory>  shopCategoryList;
  @override
  void initState() {
    // TODO: implement initState
    fetchCategoyShopList().then((response) {
      setState(() {
        shopCategoryList=response;
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
              Text("শপ  ক্যাটাগরি ",style: GoogleFonts.roboto(color: Color(0xff333333),fontSize: 18),),
              IconButton(
                icon: Icon(Icons.search,size: 30,color: Constant.primaryTextColorGray),
                onPressed: (){
                  showSearch(context: context, delegate: SearchForUpdateScreen(shopCategoryList));
                },
              )
            ],
          ),
        ),
        body:shopCategoryList==null?Center(child: CircularProgressIndicator()):Container(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount:shopCategoryList.length,
                  itemBuilder:(BuildContext context,int index)=>Container(
                      child: Container(
                        child: Column(
                          children: [
                            RadioListTile(
                              groupValue:_shopCategoryController.selectedUpdateBusinessRadioItem,
                              title: Text(shopCategoryList[index].name),
                              value: shopCategoryList[index].id.toString(),
                              onChanged: (val) {
                                setState(() {
                                  _shopCategoryController.selectedUpdateBusinessRadioItem= val;
                                  print(_shopCategoryController.selectedUpdateBusinessRadioItem);
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
                _shopCategoryController.selectedItemNameFunction(shopCategoryList);
                _shopCategoryController.setUpdateCategoryItem(_shopCategoryController.selectedUpdateBusinessRadioItem);
//                print(_shopCategoryController.selectedBusinessRadioItem);
//                print(_shopCategoryController.selectedBusinessItemName);
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


class SearchForUpdateScreen extends SearchDelegate<dynamic>  {
  final List categoryList;
  SearchForUpdateScreen(this.categoryList);
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
    List<FetchShopCategory> suggestionList = [];
    query.isEmpty
        ? suggestionList = categoryList //In the true case
        : suggestionList.addAll(categoryList.where(
      // In the false case
          (element) => element.name.toLowerCase().startsWith(query),
    ));

    return GetBuilder<ShopCategoryControllerForUpageScreen>( // specify type as Controller
      init: ShopCategoryControllerForUpageScreen(), // intialize with the Controller
      builder: (_controller) => Column(
        children: [
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  groupValue: _controller.selectedUpdateBusinessRadioItem,
                  title: Text(suggestionList[index].name),
                  value:suggestionList[index].id.toString(),
                  onChanged: (val) {
                    _controller.setUpdateCategoryItem(val);
                  },
                );
              },
            ),

          ),
          MaterialButtonForWhole('নির্বাচন করুন', onPressed: (){
            _controller.selectedItemNameFunction(categoryList);
            print(_controller.selectedUpdateBusinessRadioItem);
            print(_controller.selectedUpdateBusinessItemName);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitRegisterScreenOne()));
          }),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
}