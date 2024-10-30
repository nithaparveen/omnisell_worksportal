import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/controller/project_detail_controller.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen(
      {super.key, required this.projectId, required this.userId});
  final int projectId;
  final int userId;

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<ProjectDetailsController>(context, listen: false)
        .fetchActivities(context, widget.projectId, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<ProjectDetailsController>(
        builder: (context, controller, _) {
      var activitiesList = controller.projectActivitiesModel.data?.data ?? [];

      if (activitiesList.isEmpty) {
        return Center(
            child: Text(
          "No activities available",
          style: GLTextStyles.cabinStyle(
              size: 16, weight: FontWeight.w400, color: Colors.grey),
        ));
      }
      if (controller.isActivitiesLoading) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            
            color: ColorTheme.spider,
            size: 30,
          ),
        );
      }
      return ListView.separated(
        itemCount: activitiesList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Card(
            surfaceTintColor: ColorTheme.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${activitiesList[index].title}',
                      style: GLTextStyles.openSans(
                          size: 16, weight: FontWeight.w500)),
                  SizedBox(height: size.width * .008),
                  Row(
                    children: [
                      Text("Username: ",
                          style: GLTextStyles.openSans(
                              size: 11,
                              weight: FontWeight.w400,
                              color: Colors.grey)),
                      Text('${activitiesList[index].user?.username}',
                          style: GLTextStyles.openSans(
                              size: 12,
                              weight: FontWeight.w400,
                              color: Colors.black)),
                    ],
                  ),
                  const Divider(thickness: .25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Created date",
                              style: GLTextStyles.openSans(
                                  size: 11,
                                  weight: FontWeight.w400,
                                  color: Colors.grey)),
                          Text(
                              activitiesList[index].createdAt != null
                                  ? DateFormat('dd.MM.yyyy').format(
                                      DateTime.parse(
                                          "${activitiesList[index].createdAt}"))
                                  : "",
                              style: GLTextStyles.openSans(
                                  size: 11,
                                  weight: FontWeight.w400,
                                  color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
      );
    });
  }
}
