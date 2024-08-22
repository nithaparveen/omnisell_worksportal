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

  int? userId;

  void setUserId(int id) {
    userId = id;
  }

  Future<void> fetchTasksByStatus(BuildContext context, String status) async {
    isLoading = true;
    notifyListeners();
    log("Fetching tasks by status: $status");

    try {
      final value = await HomeService.fetchData(userId!, status: status);
      if (value != null && value["status"] == "success") {
        log("data fetched");
        taskModel = TaskModel.fromJson(value);
      } else {
        AppUtils.oneTimeSnackBar(
            "Unable to fetch Data", context: context, bgColor: ColorTheme.red);
      }
    } catch (e) {
      AppUtils.oneTimeSnackBar(
          "An error occurred", context: context, bgColor: ColorTheme.red);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> changeStatus(BuildContext context, int id, String status,
      String? note) async {
    isStatusLoading = true;
    notifyListeners();
    log("Changing status for task ID: $id to $status");

    try {
      final value = await HomeService.changeStatus(id, status, note);
      if (value != null && value["status"] == "success") {
        await fetchTasksByStatus(context, status);
      } else {
        AppUtils.oneTimeSnackBar("Unable to update status", context: context,
            bgColor: ColorTheme.red);
      }
    } catch (e) {
      AppUtils.oneTimeSnackBar(
          "An error occurred", context: context, bgColor: ColorTheme.red);
    } finally {
      isStatusLoading = false;
      notifyListeners();
    }
  }
}
