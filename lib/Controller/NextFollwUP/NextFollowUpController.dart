//import 'package:get/get.dart';
//import 'package:updateoutreach/Model/NextFollwUp/NextFollowUpModel.dart';
//import 'package:updateoutreach/Service/NextFollwUp_Service.dart';
//class NextFollowUpController extends GetxController{
//
//  var isLoading=false.obs;
//  var nextFllowUpList=List<NextFollowUpModel>().obs;
//
//  @override
//  void onInit() {
//    // TODO: implement onInit
//    visitShopList();
//    super.onInit();
//  }
//
//  void visitShopList()async{
//    try{
//      isLoading(true);
//      var followUPList=await nextFlowUpList();
//      if(followUPList!=null){
//        nextFllowUpList.assignAll(followUPList);
//      }
//    }
//    finally{
//      isLoading(false);
//
//    }
//  }
//
//}