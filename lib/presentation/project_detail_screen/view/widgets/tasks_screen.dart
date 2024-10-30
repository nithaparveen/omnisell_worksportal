import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/controller/project_detail_controller.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.projectId});
  final int projectId;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData()async{
    await Provider.of<ProjectDetailsController>(context, listen: false)
        .fetchTasks(context, widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<ProjectDetailsController>(
        builder: (context, controller, _) {
      var taskList = controller.tasksModel.data?.data ?? [];
      if (taskList.isEmpty) {
        return Center(
            child: Text(
          "No tasks available",
          style: GLTextStyles.cabinStyle(
              size: 16, weight: FontWeight.w400, color: Colors.grey),
        ));
      }
      if (controller.isTasksLoading) {
        return  Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
           
              color: ColorTheme.spider,
              size: 30,
            ),
        );
      }
      return ListView.separated(
        itemCount: taskList.length,
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
                  Text('${taskList[index].title}',
                      style: GLTextStyles.openSans(
                          size: 16, weight: FontWeight.w500)),
                  SizedBox(height: size.width * .008),
                  Row(
                    children: [
                      Text("assigned by: ",
                          style: GLTextStyles.openSans(
                              size: 11,
                              weight: FontWeight.w400,
                              color: Colors.grey)),
                      Text('${taskList[index].assignedByUser?.name}',
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
                          Text("Start date",
                              style: GLTextStyles.openSans(
                                  size: 11,
                                  weight: FontWeight.w400,
                                  color: Colors.grey)),
                          Text(
                              taskList[index].startDate != null
                                  ? DateFormat('dd.MM.yyyy').format(
                                      DateTime.parse(
                                          "${taskList[index].startDate}"))
                                  : "Not Started",
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
