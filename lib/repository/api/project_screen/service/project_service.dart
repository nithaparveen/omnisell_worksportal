import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class ProjectService {
  static Future<dynamic> fetchProjects({required int page}) async {
    log("ProjectService -> fetchProjects()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "projects?page=$page",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }

  static Future<dynamic> fetchMoreData({required int page}) async {
    log("ProjectService -> fetchMoreData()");
    try {
      var nextPageUrl =
          "https://dashboard.omnisellcrm.com/api/projects?page=$page";
      var decodedData = await ApiHelper.getDataWObaseUrl(
        endPoint: nextPageUrl,
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
      throw Exception('Failed to fetch leads');
    }
  }
}
