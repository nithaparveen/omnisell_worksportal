import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/attendance_screen/model/attendance_model.dart';
import 'package:omnisell_worksportal/repository/api/attendance_screen/service/attendance_service.dart';

class AttendanceController extends ChangeNotifier {
  AttendanceModel attendanceModel = AttendanceModel();
  bool isLoading = false;

  Future<void> fetchAttendance(
      BuildContext context, String fromDate, String toDate) async {
    isLoading = true;
    notifyListeners();
    final value = await AttendanceService.fetchAttendance(fromDate, toDate);
    if (value != null && value["status"] == "success") {
      attendanceModel = AttendanceModel.fromJson(value);
      isLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isLoading = false;
    }
    notifyListeners();
  }
}
