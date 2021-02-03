import 'package:get/get.dart';
import 'package:test_app/Model/Category/FetchCategoryShopModel.dart';


class ShopCategoryController extends GetxController{

  String selectedBusinessItemName;
  String selectedBusinessRadioItem='';

   void selectedItemNameFunction(List<FetchShopCategory>  categoryList){
    var trendIndex= categoryList.indexWhere((f) => f.id == int.parse(selectedBusinessRadioItem));
    selectedBusinessItemName=categoryList[trendIndex].name;
  }


  void setUpdateCategoryItem(dynamic value){
    selectedBusinessRadioItem=value;
    update();
    print(selectedBusinessRadioItem);
  }


}