import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/activities_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/project_detail_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/tasks_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/service/project_detail_service.dart';

class ProjectDetailsController extends ChangeNotifier {
  DetailsModel detailsModel = DetailsModel();
  TasksModel tasksModel = TasksModel();
  ProjectActivitiesModel projectActivitiesModel = ProjectActivitiesModel();

  bool isLoading = false;
  bool isTasksLoading = false;
  bool isMembersLoading = false;
  bool isActivitiesLoading = false;

  Future<void> fetchDetails(BuildContext context, projectId) async {
    isLoading = true;
    notifyListeners();
    final value = await ProjectDetailsService.fetchDetails(projectId);
    if (value != null && value["status"] == "success") {
      detailsModel = DetailsModel.fromJson(value);
      isLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchTasks(BuildContext context, projectId) async {
    isTasksLoading = true;
    notifyListeners();
    final value = await ProjectDetailsService.fetchTasks(projectId);
    if (value != null && value["status"] == "success") {
      tasksModel = TasksModel.fromJson(value);
      isTasksLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isTasksLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchActivities(BuildContext context, projectId, userId) async {
    isActivitiesLoading = true;
    notifyListeners();
    final value =
        await ProjectDetailsService.fetchActivities(projectId, userId);
    if (value != null && value["status"] == "success") {
      projectActivitiesModel = ProjectActivitiesModel.fromJson(value);
      isActivitiesLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isActivitiesLoading = false;
    }
    notifyListeners();
  }
}
