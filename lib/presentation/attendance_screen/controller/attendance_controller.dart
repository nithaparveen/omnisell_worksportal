import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/attendance_screen/model/attendance_model.dart' as attendance;
import 'package:omnisell_worksportal/repository/api/attendance_screen/model/not_signed_in_model.dart';
import 'package:omnisell_worksportal/repository/api/attendance_screen/service/attendance_service.dart';

class AttendanceController extends ChangeNotifier {
  List<attendance.Datum> attendanceData = [];
  NotSignedInModel notSignedInModel = NotSignedInModel();

  bool isLoading = false;
  bool isNSILoading = false;

  Future<void> fetchAttendance(BuildContext context, String fromDate, String toDate) async {
    isLoading = true;
    notifyListeners();
    final value = await AttendanceService.fetchAttendance(fromDate, toDate);
    if (value != null && value["status"] == "success") {
      attendanceData = attendance.AttendanceModel.fromJson(value).data ?? [];
      isLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data", context: context, bgColor: ColorTheme.red);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchNotSignedIn(BuildContext context, String date) async {
    isNSILoading = true;
    notifyListeners();
    final value = await AttendanceService.fetchNotSignedIn(date);
    if (value != null && value["status"] == "success") {
      notSignedInModel = NotSignedInModel.fromJson(value);
      isNSILoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data", context: context, bgColor: ColorTheme.red);
      isNSILoading = false;
    }
    notifyListeners();
  }

  List<Datum> get notSignedInData {
    return notSignedInModel.data?.cast<Datum>() ?? [];
  }
}

