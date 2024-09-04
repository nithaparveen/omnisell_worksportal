import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class AttendanceService {
  static Future<dynamic> fetchAttendance(
      String fromDate, String toDate) async {
    log("AttendanceService -> fetchAttendance()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint:
            "employees/attendences?from=$fromDate&to=$toDate",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}