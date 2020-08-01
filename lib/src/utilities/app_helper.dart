import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppHelper {
  static void showToastMessage(String toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.blueGrey);
  }



  // Strings to show messages.

  static final String message_something_went_wrong = "Something went wrong. Please try again later!";
}
