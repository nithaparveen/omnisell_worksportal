import 'dart:convert';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_config.dart';
import '../constants/colors.dart';
import '../constants/textstyles.dart';

class AppUtils {
  static Future<String?> getToken() async {
    log("AppUtils -> getToken()");
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get(AppConfig.token) != null) {
      final access =
      jsonDecode(sharedPreferences.get(AppConfig.token) as String);
      log("Token -> $access");
      return access;
    } else {
      return null;
    }
  }

  static oneTimeSnackBar(
      String? message, {
        int time = 2,
        Color? bgColor,
        TextStyle? textStyle,
        required BuildContext context,
        bool showOnTop = false,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
    // ScaffoldMessenger.of(context??Routes.router.routerDelegate.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        /*action:SnackBarAction(label: "Ok",
        onPressed: (){
          SystemSettings.internalStorage();
        },
        ) ,*/

        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.white60,
        content: Text(message!,
            style:
            textStyle ?? GLTextStyles.cabinStyle(color: ColorTheme.white , weight: FontWeight.w500,size: 14)),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20)
            : null,
      ),
    );
  }
   static showFlushbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = const Color(0xFFE0E0E0),
    Color messageColor = const Color(0xFF000000),
    IconData icon = Icons.done_outline,
    Color iconColor = const Color(0xFF4CAF50),
    double widthFactor = 0.55,
    Duration duration = const Duration(seconds: 3),
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
  }) {
    return Flushbar(
      maxWidth: MediaQuery.of(context).size.width * widthFactor,
      backgroundColor: backgroundColor,
      messageColor: messageColor,
      icon: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
      message: message,
      duration: duration,
      flushbarPosition: flushbarPosition,
    ).show(context);
  }
}
