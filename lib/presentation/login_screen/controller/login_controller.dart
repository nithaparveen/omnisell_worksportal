import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/login_screen/service/login_service.dart';
import '../../bottom_navigation_screen/view/bottom_navigation_screen.dart';

class LoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(String email, String password, BuildContext context) async {
    log("loginController -> onLogin() started");
    LoginService.postLoginData(email, password).then((value) {
      log("postLoginData() -> ${value["status"]}");
      if (value["status"] == "success") {
        log("token -> ${value["data"]["auth_token"]} ");
        storeLoginData(value);
        storeUserToken(value["data"]["auth_token"]);
        final int userId = value["data"]["user"]["user_id"];
        log("userId -> $userId");
        storeUserId(userId);
        AppUtils.oneTimeSnackBar("LoggedIn Successfully", context: context, bgColor: const Color.fromARGB(255, 97, 182, 86),);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => StatusNavigationBar(
                      userId: userId,
                    ),),
            (route) => false);
      } else {
        AppUtils.oneTimeSnackBar("Password mismatch", context: context, bgColor: ColorTheme.red);
        log("Else Condition >> Api failed");
      }
    });
  }

  void onPressed() {
    visibility = !visibility;
    notifyListeners();
  }

  void storeLoginData(loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  void storeUserToken(resData) async {
    log("storeUserToken()");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    sharedPreferences.setString(AppConfig.token, dataUser);
  }

  Future<void> storeUserId(int userId) async {
    log("storeUserId() -> $userId");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(AppConfig.userId, userId);
  }
}
