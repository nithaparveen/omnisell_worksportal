import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class HomeService {
  static Future<dynamic> fetchData() async {
    log("HomeService -> fetchData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "projects/tasks",
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
            "projects/tasks/change-status?task_id=$id&status=$status&status_note=$note",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}
