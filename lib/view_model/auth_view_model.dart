import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice/model/user_model.dart';
import 'package:invoice/repository/auth_repository.dart';
import 'package:invoice/utils/routes/routes_name.dart';
import 'package:invoice/utils/utils.dart';
import 'package:invoice/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then(
            (value) {
              setLoading(false);
              final userPreferences = Provider.of<UserViewModel>(context, listen: false);
              userPreferences.saveUser(
                UserModel(
                  token: value['token'].toString()
                )
              );
              Utils.snakBar("Login successfully", context);
              Navigator.pushNamed(context, RoutesName.home);
              if(kDebugMode){
                print(value.toString());
              }
            }).onError((error, stackTrace) {
              setLoading(false);
              if (kDebugMode) {
                Utils.snakBar(error.toString(), context);
                print(error.toString());
                print(stackTrace);
              }
            });
  }

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.resisterApi(data).then(
            (value) {
          setLoading(false);
          Utils.snakBar("Signup successfully", context);
          Navigator.pushNamed(context, RoutesName.login);
          if(kDebugMode){
            print(value.toString());
          }
        }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.snakBar(error.toString(), context);
        print(error.toString());
        print(stackTrace);
      }
    });
  }
}