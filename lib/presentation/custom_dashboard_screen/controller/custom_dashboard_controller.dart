import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/repository/api/custom_dashboard_screen/model/card_list_model.dart';
import 'package:omnisell_worksportal/repository/api/custom_dashboard_screen/model/custom_list_model.dart';
import 'package:omnisell_worksportal/repository/api/custom_dashboard_screen/service/custom_dashboard_service.dart';

class CustomDashboardController extends ChangeNotifier {
  bool isLoading = false;
  bool isCardLoading = false;
  CustomListModel customListModel = CustomListModel();
  CardListModel cardListModel = CardListModel();

  Future<void> fetchDashboards(BuildContext context) async {
    isLoading = true;
    customListModel = CustomListModel();
    notifyListeners();
    final value = await CustomDashboardService.fetchDashboards();
    if (value != null) {
      customListModel = CustomListModel.fromJson(value);
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

  createDashboard(name, description, userId, date, context) async {
    log("CustomDashboardController -> createDashboard()");
    await CustomDashboardService.createDashboard(
            name, description, userId, date)
        .then((value) {
      if (value["data"] != null) {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, textStyle: TextStyle(fontSize: 18));
        fetchDashboards(context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }

    Future<void> fetchCards(BuildContext context,dashboardId) async {
    isCardLoading = true;
    cardListModel = CardListModel();
    notifyListeners();
    final value = await CustomDashboardService.fetchCards(dashboardId);
    if (value != null && value["status"] == "success") {
      cardListModel = CardListModel.fromJson(value);
    } else {
      AppUtils.oneTimeSnackBar(
        "Unable to fetch Data",
        context: context,
        bgColor: ColorTheme.red,
      );
    }
    isCardLoading = false;
    notifyListeners();
  }

  createCard(name, description, userId, date, context) async {
    log("CustomDashboardController -> createCard()");
    await CustomDashboardService.createDashboard(
            name, description, userId, date)
        .then((value) {
      if (value["data"] != null) {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, textStyle: TextStyle(fontSize: 18));
        fetchDashboards(context);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }
}
