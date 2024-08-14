import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/status_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/task_detail_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/task_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/service/home_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';

class HomeController extends ChangeNotifier {
  TaskModel taskModel = TaskModel();
  StatusModel statusModel = StatusModel();
  TaskDetailModel taskDetailModel = TaskDetailModel();

  bool isLoading = false;
  bool isStatusLoading = false;
  bool isStatusViewLoading = false;

  fetchData(context) async {
    isLoading = true;
    notifyListeners();
    log("HomeController -> fetchData()");
    HomeService.fetchData().then((value) {
      if (value != null && value["status"] == "success") {
        taskModel = TaskModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }

  changeStatus(context, int id, String status, String? note) async {
    isStatusLoading = true;
    notifyListeners();
    log("HomeController -> changeStatus()");
    HomeService.changeStatus(id, status, note).then((value) {
      if (value != null && value["status"] == "success") {
        statusModel = StatusModel.fromJson(value);
        isStatusLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }
}
