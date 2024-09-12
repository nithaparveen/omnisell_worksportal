import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/project_screen/model/project_model.dart';
import 'package:omnisell_worksportal/repository/api/project_screen/service/project_service.dart';

class ProjectController extends ChangeNotifier {
  bool isLoading = false;
  bool isMoreLoading = false;
  int currentPage = 1;

  ProjectModel projectModel = ProjectModel();

  Future<void> fetchProjects(BuildContext context) async {
  isLoading = true;
  currentPage = 1;  
  projectModel = ProjectModel();  
  notifyListeners();

  final value = await ProjectService.fetchProjects(page: currentPage);
  if (value != null && value["status"] == "success") {
    projectModel = ProjectModel.fromJson(value);
  } else {
    AppUtils.oneTimeSnackBar(
      "Unable to fetch Data",
      context: context,
      bgColor: ColorTheme.red,
    );
  }
  isLoading = false;
  notifyListeners();
}


Future<void> fetchMoreProjects(BuildContext context) async {
  if (isMoreLoading) return; 
  isMoreLoading = true;
  notifyListeners();
  
  try {
    currentPage++; 
    final value = await ProjectService.fetchMoreData(page: currentPage);
    if (value != null && value["status"] == "success") {
      final moreProjects = ProjectModel.fromJson(value);
      projectModel.data?.data?.addAll(moreProjects.data?.data ?? []);
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch more data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }
  } catch (error) {
    print("Error fetching more projects: $error");
  } finally {
    isMoreLoading = false;
    notifyListeners();
  }
}

}
