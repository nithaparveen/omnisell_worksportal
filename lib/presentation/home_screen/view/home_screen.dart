import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/widgets/task_detail_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/textstyles.dart';
import '../../login_screen/view/login_screen.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userId, this.statusFilter});

  final int userId;
  final String? statusFilter;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Provider.of<HomeController>(context, listen: false);
    homeController.setUserId(widget.userId);
    fetchData();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   fetchData();
  // }

  void fetchData() async {
    String statusFilter = widget.statusFilter ?? '';
    await homeController.fetchTasksByStatus(context, statusFilter);
  }

  final Map<String, Color> statusColors = {
    'Not Started': Colors.grey,
    'In Progress': Colors.blue,
    'Review Pending': Colors.orange,
    'Review Failed': Colors.red,
    'Completed': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
                height: 30,
                width: 20,
                child: Image.asset("assets/logo-sw.png")),
            const SizedBox(
              width: 15,
            ),
            Text("Work Board", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
//         Row(
//   children: [
//     SizedBox(
//       height: MediaQuery.of(context).size.height * 0.05,
//       width: MediaQuery.of(context).size.width * 0.1,
//       child: Image.asset("assets/logo-sw.png"),
//     ),
//     const SizedBox(width: 15,),
//     Text(
//       "Work Board",
//       style: GLTextStyles.cabinStyle(size: MediaQuery.of(context).size.width * 0.05),
//     ),
//   ],
// ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
              color: Colors.black,
            ),
            onPressed: showLogoutConfirmation,
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Consumer<HomeController>(builder: (context, controller, _) {
        var filteredTasks = controller.taskModel.data?.data?.where((task) {
              return widget.statusFilter == null ||
                  task.status == widget.statusFilter;
            }).toList() ??
            [];

        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 46, 146, 157)
            ),
          );
        }

        if (filteredTasks.isEmpty) {
          return Center(
              child: Text(
            "No tasks available",
            style: GLTextStyles.cabinStyle(
                size: 16, weight: FontWeight.w400, color: Colors.grey),
          ));
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  var task = filteredTasks[index];
                  DateTime? dueDate = task.dueDate;
                  String formattedDate = dueDate != null
                      ? DateFormat('dd/MM/yyyy').format(dueDate)
                      : 'No Due Date';

                  String currentStatus = task.status ?? 'Not Started';
                  Color currentColor =
                      statusColors[currentStatus] ?? Colors.grey;

                  return InkWell(
                    onTap: () =>
                        showTaskDetailBottomSheet(context, task, currentColor),
                    child: Card(
                      // surfaceTintColor: Colors.white,
                      color: ColorTheme.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title ?? 'No Title',
                              style: GLTextStyles.openSans(
                                  size: 18, weight: FontWeight.w500),
                            ),
                            Text(
                              task.project?.name ?? 'No Project',
                              style: GLTextStyles.openSans(
                                  size: 16,
                                  weight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: size.width * .008),
                            Row(
                              children: [
                                Text(
                                  "assigned by: ",
                                  style: GLTextStyles.openSans(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                Text(
                                  task.assignedByUser?.name ?? 'Unknown',
                                  style: GLTextStyles.openSans(
                                      size: 13,
                                      weight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const Divider(thickness: .25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Due date",
                                      style: GLTextStyles.openSans(
                                          size: 12,
                                          weight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: GLTextStyles.openSans(
                                          size: 14,
                                          weight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.width * .055,
                                  width: size.width * .26,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: currentColor,
                                  ),
                                  child: Center(
                                    child: PopupMenuButton<String>(
                                      onSelected: (String value) =>
                                          onStatusSelected(
                                              context, task, value),
                                      itemBuilder: (BuildContext context) {
                                        return statusColors.keys
                                            .map((String status) {
                                          return PopupMenuItem<String>(
                                            value: status,
                                            child: Container(
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .all(5),
                                              height: size.width * .075,
                                              width: size.width * .24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                color: statusColors[status],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  status,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      child: Text(
                                        currentStatus,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.width * .01),
              )
            ],
          ),
        );
      }),
    );
  }

  void showTaskDetailBottomSheet(
      BuildContext context, task, Color statusColor) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TaskDetailBottomSheet(
          title: task?.title ?? 'No Title',
          projectName: task?.project?.name ?? 'No Project',
          assignedBy: task?.assignedByUser?.name ?? 'Unknown',
          dueDate: formatDate(task?.dueDate),
          status: task?.status ?? 'Not Started',
          statusColor: statusColor,
          priority: getPriorityLabel(task?.priority ?? 0),
          reviewer: task?.reviewer?.name ?? 'Unknown',
          description: cleanDescription(task?.description ?? ''),
          onStatusChange: (String newStatus) async {
            final int taskId = task?.id ?? 0;
            const String statusNote = 'Some Note';
            try {
              await homeController.changeStatus(
                  context, taskId, newStatus, statusNote);
              await homeController.fetchTasksByStatus(
                  context, widget.statusFilter ?? '');
              setState(() {});
              Navigator.pop(context);
            } catch (e) {
              log("Error changing status: $e");
            }
            setState(() {});
          },
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
    );
  }

  String formatDate(DateTime? dueDate) {
    return dueDate != null
        ? DateFormat('dd/MM/yyyy').format(dueDate)
        : 'No Due Date';
  }

  String cleanDescription(String description) {
    String cleaned = description.replaceAll(RegExp(r'<[^>]*>'), '');
    cleaned = cleaned.replaceAll('&nbsp;', ' ');
    cleaned = cleaned.replaceAll('\n', ' ');
    cleaned = cleaned.trim();
    return cleaned;
  }

  String getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Critical';
      case 2:
        return 'High';
      case 3:
        return 'Medium';
      case 4:
        return 'Low';
      default:
        return 'Unknown';
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppConfig.token);
    await sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void showLogoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.cabinStyle(size: 18),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void onStatusSelected(BuildContext context, task, String newStatus) async {
    final int taskId = task.id ?? 0;
    const String statusNote = 'Some Note';

    try {
      await homeController.changeStatus(context, taskId, newStatus, statusNote);
      await homeController.fetchTasksByStatus(
          context, widget.statusFilter ?? '');
      setState(() {});
    } catch (e) {
      log('Error changing status: $e');
    }
  }
}
