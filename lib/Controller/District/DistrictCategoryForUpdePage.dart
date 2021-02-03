import 'package:get/get.dart';
import 'package:test_app/Model/District/FetchAllDistrictModel.dart';

class DistrictControllerForUpdateScreen extends GetxController{

  // String selectUpdateDistictname;
  // String selectUpdateDistrictItem;
  String selectedDistrictItemName;
  String selectedDistrictItem='';

  void selectedDistrictItemNameFunction(List<FetchAllDistrict>  districtList){
    var trendIndex= districtList.indexWhere((f) => f.id == int.parse(selectedDistrictItem));
    selectedDistrictItemName=districtList[trendIndex].name;
   // print(trendIndex);
  }
  void setUpdateDistrictItem(dynamic value){
    selectedDistrictItemName=value;
    update();
    print(selectedDistrictItem);
  }


}