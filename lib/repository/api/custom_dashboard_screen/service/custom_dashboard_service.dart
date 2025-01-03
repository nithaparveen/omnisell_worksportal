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
  static Future<dynamic> fetchCards(dashboardId) async {
    log("CustomDashboardService -> fetchCards()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "custom-card/list?dashboard_id=$dashboardId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }

  static Future<dynamic> createCard(name, description, userId, date) async {
    log("CustomDashboardService -> createCard()");
    var decodedData = await ApiHelper.postData(
      endPoint:
          "custom/store?dashboard_name=$name&description=$description&owner_user_id=$userId&create_date=$date",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData;
  }
  static Future<dynamic> deleteCard(cardId) async {
    log("CustomDashboardService -> deleteCard()");
    var decodedData = await ApiHelper.postData(
      endPoint:
          "custom-card/delete?id=$cardId",
      header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
    );
    return decodedData;
  }
}
