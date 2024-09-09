import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class ProjectDetailsService {
  
  static Future<dynamic> fetchDetails(projectId) async {
    log("ProjectDetailsService -> fetchDetails()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "projects/get-details?project_id=$projectId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }

  static Future<dynamic> fetchActivities(projectId, userId) async {
    log("ProjectDetailsService -> fetchActivities()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "projects/activities?projects_id=$projectId&users_id=$userId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }

  static Future<dynamic> fetchTasks(projectId) async {
    log("ProjectDetailsService -> fetchTasks()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "projects/tasks?projects_id=$projectId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}
