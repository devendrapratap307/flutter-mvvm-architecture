import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static toastMessage( String message){
    Fluttertoast.showToast(msg: message
      //   ,backgroundColor: Colors.blue,
      // textColor: Colors.white
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      message: message,
      backgroundColor: Colors.red,
      title: "SAD",
      messageColor: Colors.black,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(Icons.error, size: 28, color: Colors.white),
      duration: const Duration(seconds: 3),
    )..show(context),
    );
  }

  static snakBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red, content: Text(message)));
  }
}