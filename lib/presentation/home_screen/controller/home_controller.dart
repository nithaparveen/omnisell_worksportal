import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/task_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/service/home_service.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';

class HomeController extends ChangeNotifier {
  TaskModel taskModel = TaskModel();
  bool isLoading = false;

  fetchData(context) async {
    isLoading = true;
    notifyListeners();
    log("HomeController -> fetchData()");
    HomeService.fetchData().then((value) {
      if (value["status"] == "success") {
        taskModel = TaskModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }
}
