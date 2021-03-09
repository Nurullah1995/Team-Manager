// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:test_app/Model/Search/SearchModel.dart';
// import 'package:test_app/Model/VisitPlace/FetchVisitedPlaceModel.dart';
// import 'package:test_app/Service/SharePrefarence.dart';
// import 'package:test_app/Service/search_service.dart';
// import 'package:test_app/Service/visited_place_service.dart';
//
// class VisitorScreenController extends GetxController{
//
//   String userName;
//   String userImage;
//   String userRole;
//   String userContact;
//
//
//
//   int lastPageNumbaer;
//   int current_page=1;
//   bool loading=true;
//   bool innerLoading=true;
//
//   bool searching, error;
//   var data;
//   String query;
//
//
//
//   List<FetchVisitedPlaceModel> visitList=[];
//   List<SerarchListModel> searchList=[];
//
//   ScrollController scrollControllerForVisitPlace=ScrollController();
//   ScrollController scrollControllerForSearchList=ScrollController();
//
//   @override
//   void onInit() {
//
//
//     searching = false;
//     error = false;
//     query = "";
//
//     lastPageNumber().then((lastNumber) {
//       lastPageNumbaer=lastNumber;
//       print(lastPageNumbaer);
//     });
//     getUserName().then((result) {
//       userName=result;
//     });
//     getUserPhoneNo().then((result) {
//       userContact=result;
//     });
//     getUserImage().then((result) {
//       userImage=result;
//     });
//     getUserRole().then((result) {
//       userRole=result;
//       print(userRole);
//     });
//
//     visitShopList();
//     scrollControllerForVisitPlace.addListener(() {
//       if(scrollControllerForVisitPlace.position.pixels==scrollControllerForVisitPlace.position.maxScrollExtent){
//         visitShopList();
//         update();
//       }
//     });
//
//     // TODO: implement onInit
//     super.onInit();
//
//
//   }
//
//
//   void getSuggestion() async{  //get suggestion function
//     fetchSearchList(query).then((response) {
//       var searchListId;
//       var responseListId;
//       searchList.forEach((element) {
//         searchListId=element.id;
//       });
//       response.forEach((element) {
//         responseListId=element.id;
//       });
//       if(searchListId!=responseListId){
//         searchList.addAll(response);
//         update();
//       }
//
//     });
//
//
//   }
//
//
//
//   visitShopList(){
//     fetchVisitShopList(current_page).then((responseItem) {
//       visitList.addAll(responseItem);
//       loading=false;
//       if(current_page!=lastPageNumbaer){
//         innerLoading=false;
//         current_page++;
//       }
//     });
//   }
//
// @override
//   void onClose() {
//   scrollControllerForVisitPlace.dispose();
//     // TODO: implement onClose
//     super.onClose();
//   }
//
//
//
// }