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
  }

  static Future<dynamic> fetchTasks({required int page}) async {
    log("HomeService -> fetchTasks(page: $page)");
    try {
      var nextPage =
          "https://dashboard.omnisellcrm.com/api/projects/tasks?page=$page";
      var decodedData = await ApiHelper.getDataWObaseUrl(
        endPoint: nextPage,
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
      throw Exception('Failed to fetch tasks');
    }
  }
}
