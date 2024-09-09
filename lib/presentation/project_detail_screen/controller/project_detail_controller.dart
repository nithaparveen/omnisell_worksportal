import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/project_detail_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/service/project_detail_service.dart';

class ProjectDetailsController extends ChangeNotifier {
  DetailsModel detailsModel = DetailsModel();
  bool isLoading = false;

  Future<void> fetchDetails(BuildContext context, projectId) async {
    isLoading = true;
    notifyListeners();
    final value = await ProjectDetailsService.fetchDetails(projectId);
    if (value != null && value["status"] == "success") {
      detailsModel = DetailsModel.fromJson(value);
      isLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data", context: context, bgColor: ColorTheme.red);
      isLoading = false;
    }
    notifyListeners();
  }
}

