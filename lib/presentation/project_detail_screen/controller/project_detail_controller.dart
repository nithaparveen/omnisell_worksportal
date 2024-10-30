import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/activities_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/members_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/project_detail_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/sprint_list_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/model/tasks_model.dart';
import 'package:omnisell_worksportal/repository/api/project_detail_screen/service/project_detail_service.dart';

class ProjectDetailsController extends ChangeNotifier {
  DetailsModel detailsModel = DetailsModel();
  TasksModel tasksModel = TasksModel();
  ProjectActivitiesModel projectActivitiesModel = ProjectActivitiesModel();
  MembersModel membersModel = MembersModel();
  SprintListModel sprintListModel = SprintListModel();

  bool isLoading = false;
  bool isTasksLoading = false;
  bool isMembersLoading = false;
  bool isActivitiesLoading = false;
  bool isSprintsLoading = false;

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

  Future<void> fetchMembers(BuildContext context, projectId) async {
    isMembersLoading = true;
    notifyListeners();
    final value = await ProjectDetailsService.fetchMembers(projectId);
    if (value != null && value["status"] == "success") {
      membersModel = MembersModel.fromJson(value);
      isMembersLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isMembersLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchSprints(BuildContext context, projectId) async {
    isSprintsLoading = true;
    notifyListeners();
    final value = await ProjectDetailsService.fetchSprints(projectId);
    if (value != null) {
      sprintListModel = SprintListModel.fromJson(value);
      isSprintsLoading = false;
    } else {
      AppUtils.oneTimeSnackBar("Unable to fetch Data",
          context: context, bgColor: ColorTheme.red);
      isSprintsLoading = false;
    }
    notifyListeners();
  }

  createSprint(name, description, projectId, startDate, duedate, 
      expHours, context) async {
    log("CustomDashboardController -> createSprint()");
    await ProjectDetailsService.createSprint(name, description, projectId,
            startDate, duedate, expHours)
        .then((value) {
      if (value["data"] != null && value["status"] == "success") {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, textStyle: TextStyle(fontSize: 18));
        fetchSprints(context, projectId);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }
}
