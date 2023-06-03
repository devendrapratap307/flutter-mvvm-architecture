import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice/model/user_model.dart';
import 'package:invoice/utils/routes/routes_name.dart';
import 'package:invoice/view_model/user_view_model.dart';

class SplashServices {

  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {

      print(value.token);
      if(value.token == 'null' || value.token ==''){
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}