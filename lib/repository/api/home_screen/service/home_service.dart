import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class HomeService {
  static Future<dynamic> fetchData(int userId, {String? status}) async {
    log("HomeService -> fetchData()");
    try {
      String endPoint = "projects/tasks?assigned_to=$userId";
      if (status != null && status.isNotEmpty) {
        endPoint += "&status=$status";
      }

      var decodedData = await ApiHelper.getData(
        endPoint: endPoint,
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }

  static Future<dynamic> changeStatus(
      int id, String status, String? note) async {
    log("HomeService -> changeStatus()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint:
            "projects/tasks/change-status?task_id=$id&status=$status&status_note=${Uri.encodeComponent(note ?? '')}",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}
