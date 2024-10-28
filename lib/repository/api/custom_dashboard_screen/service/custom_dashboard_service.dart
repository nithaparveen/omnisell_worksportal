import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class CustomDashboardService {
  static Future<dynamic> createDashboard(
      name, description, userId, date) async {
    log("CustomDashboardService -> createDashboard()");
      var decodedData = await ApiHelper.postData(
        endPoint:
            "custom/store?dashboard_name=$name&description=$description&owner_user_id=$userId&create_date=$date",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
  }

  static Future<dynamic> fetchDashboards() async {
    log("CustomDashboardService -> fetchDashboards()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "custom/list",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}
