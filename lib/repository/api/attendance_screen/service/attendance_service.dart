import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class AttendanceService {
  static Future<dynamic> fetchAttendance(
      String fromDate, String toDate , userId) async {
    log("AttendanceService -> fetchAttendance()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint:
            "employees/attendences?user_id=$userId&from=$fromDate&to=$toDate",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}
