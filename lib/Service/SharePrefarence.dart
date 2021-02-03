import 'package:shared_preferences/shared_preferences.dart';

Future<void> setValue(String value)async{
  SharedPreferences myprefarence= await SharedPreferences.getInstance();
  myprefarence.setString('token', value);
 //  print("access token :${token}");
}
Future<void> setUserName(String value)async{
  SharedPreferences myprefarence= await SharedPreferences.getInstance();
  myprefarence.setString('userName', value);
    //print("userName:${myprefarence.get('userName')}");
}
Future<void> setUserRole(String value)async{
  SharedPreferences myprefarence= await SharedPreferences.getInstance();
  myprefarence.setString('userRole', value);
 // print("userName:${myprefarence.get('userRole')}");
}
Future<void> setUserImage(String value)async{
  SharedPreferences myprefarence= await SharedPreferences.getInstance();
  myprefarence.setString('userImage', value);
  //print("userName:${myprefarence.get('userImage')}");

}
Future<void> setUserPhoneNo(String value)async{
  SharedPreferences myprefarence= await SharedPreferences.getInstance();
  myprefarence.setString('userContact', value);
  //print("userName:${myprefarence.get('userContact')}");

}


////get all val
Future <String> getTokenValue()async{
  final  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  final String token=sharedPreferences.getString('token');
//  print("accept token : ${token}");
  return token;
}

Future<String> getUserName()async{
  final  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  final String userName=sharedPreferences.getString('userName');
    print("access userName :${userName}");
    return userName;
}
Future<String> getUserRole()async{
  final  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  final String userRole=sharedPreferences.getString('userRole');
    print("access userRole:${userRole}");
    return userRole;
}

Future<String> getUserImage()async{
  final  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  final String userImage=sharedPreferences.getString('userImage');
    print("access userImage :${userImage}");
    return userImage;
}

Future<String> getUserPhoneNo()async{
  final  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  final String userContact=sharedPreferences.getString('userContact');
    print("access usrContact :${userContact}");
    return userContact;
}

void logOut()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var test =await preferences.remove('token');
  print(test);
}