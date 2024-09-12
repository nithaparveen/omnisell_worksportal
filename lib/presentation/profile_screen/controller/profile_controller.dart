import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/profile_screen/model/profile_model.dart';
import 'package:omnisell_worksportal/repository/api/profile_screen/service/profile_service.dart';

class ProfileController extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();

  bool isLoading = false;

  Future<void> fetchProfileDetails(BuildContext context, userId) async {
    isLoading = true;
    notifyListeners();
    final value = await ProfileService.fetchProfileDetails(userId);
    if (value != null && value["status"] == "success") {
      profileModel = ProfileModel.fromJson(value);
      isLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isLoading = false;
    }
    notifyListeners();
  }
}
