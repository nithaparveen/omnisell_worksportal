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
    notifyListeners();

    final value = await ProjectService.fetchProjects();
    if (value != null && value["status"] == "success") {
      projectModel = ProjectModel.fromJson(value);
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreProjects(BuildContext context) async {
    if (isMoreLoading) return; // Prevent multiple simultaneous requests
    isMoreLoading = true;
    notifyListeners();
    try {
      currentPage++; // Increment the page number
      final value = await ProjectService.fetchMoreData(page: currentPage);
      if (value != null && value["status"] == "success") {
        final moreProjects = ProjectModel.fromJson(value);
        // Append the new projects to the existing list
        projectModel.data?.data?.addAll(moreProjects.data?.data ?? []);
      } else {
        // Handle error case (e.g., show a snackbar)
        AppUtils.oneTimeSnackBar("Unable to fetch more data",
            context: context, bgColor: ColorTheme.red);
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors)
      print("Error fetching more projects: $error");
      // You might want to show an error message to the user here as well.
    } finally {
      isMoreLoading = false;
      notifyListeners();
    }
  }
}
