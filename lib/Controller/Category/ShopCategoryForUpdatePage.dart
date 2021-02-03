import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test_app/Model/Category/FetchCategoryShopModel.dart';

class ShopCategoryControllerForUpageScreen extends GetxController{

  String selectedUpdateBusinessItemName;
  String selectedUpdateBusinessRadioItem='';

  void selectedItemNameFunction(List<FetchShopCategory>  categoryList){
    var trendIndex= categoryList.indexWhere((f) => f.id == int.parse(selectedUpdateBusinessRadioItem));
    selectedUpdateBusinessItemName=categoryList[trendIndex].name;
  }


  void setUpdateCategoryItem(dynamic value){
    selectedUpdateBusinessRadioItem=value;
    update();
    print(selectedUpdateBusinessRadioItem);
  }


}