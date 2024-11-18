import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/status_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/task_detail_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/model/task_model.dart';
import 'package:omnisell_worksportal/repository/api/home_screen/service/home_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import 'package:another_flushbar/flushbar.dart';

class HomeController extends ChangeNotifier {
   TaskModel taskModel = TaskModel();
  StatusModel statusModel = StatusModel();
  TaskDetailModel taskDetailModel = TaskDetailModel();
  
  bool isLoading = false;
  bool isStatusLoading = false;
  String _currentStatus = '';
  
  int? userId;
  
  void setUserId(int id) {
    userId = id;
  }
  
  Future<void> fetchTasksByStatus(BuildContext context, String status) async {
    // Don't reload if the status hasn't changed
    if (status == _currentStatus && taskModel.data?.data != null) {
      return;
    }
    
    isLoading = true;
    notifyListeners();
    
    try {
      final value = await HomeService.fetchData(userId!, status: status);
      if (value != null && value["status"] == "success") {
        taskModel = TaskModel.fromJson(value);
        _currentStatus = status;
      } else {
        AppUtils.oneTimeSnackBar(
          "Unable to fetch Data",
          context: context,
          bgColor: ColorTheme.red
        );
      }
    } catch (e) {
      AppUtils.oneTimeSnackBar(
        "An error occurred",
        context: context,
        bgColor: ColorTheme.red
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

 Future<void> changeStatus(
    BuildContext context, int id, String status, String? remark) async {
  var size = MediaQuery.sizeOf(context);
  isStatusLoading = true;
  notifyListeners();
  print("Changing status for task ID: $id to $status");

  try {
    final value = await HomeService.changeStatus(id, status, remark);
    if (value != null && value["status"] == "success") {
      updateTaskStatus(id, status);
      Flushbar(
        maxWidth: size.width * .65,
        backgroundColor: Color.fromARGB(255, 97, 182, 86),
        icon: Icon(
          Icons.done_sharp,
          color: ColorTheme.white,
          size: 18,
        ),
        messageText: Text(
          "Status updated successfully",
          style: GLTextStyles.openSans(size: 14, weight: FontWeight.w500, color: ColorTheme.white),
        ),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.BOTTOM,
      ).show(context);
    } else {
      AppUtils.oneTimeSnackBar("Unable to update status",
          context: context, bgColor: ColorTheme.red);
    }
  } catch (e) {
    AppUtils.oneTimeSnackBar("An error occurred",
        context: context, bgColor: ColorTheme.red);
  } finally {
    isStatusLoading = false;
    notifyListeners();
  }
}


  void updateTaskStatus(int id, String newStatus) async {
    final taskIndex = taskModel.data?.data?.indexWhere((task) => task.id == id);
    if (taskIndex != null && taskIndex != -1) {
       taskModel.data?.data?[taskIndex].status = newStatus;
      notifyListeners();
    }
  }
}
