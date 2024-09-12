import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class ProfileService {
  static Future<dynamic> fetchProfileDetails(userId) async {
    log("ProfileService -> fetchProfileDetails()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "user?id=$userId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
    return {};
  }
}
