import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/widgets/task_detail_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_config/app_config.dart';
import '../../../core/constants/textstyles.dart';
import '../../login_screen/view/login_screen.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userId});
  final int userId;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await Provider.of<HomeController>(context, listen: false)
        .fetchData(context,widget.userId);
  }

  final Map<String, Color> _statusColors = {
    'Not Started': Colors.grey,
    'In Progress': Colors.blue,
    'Review Pending': Colors.orange,
    'Review Failed': Colors.red,
    'Completed': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        title: Text(
          "Work Board",
          style: GLTextStyles.cabinStyle(size: 22),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () => logoutConfirmation(),
          ),
        ],
      ),
      body: Consumer<HomeController>(builder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: controller.taskModel.data?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  var task = controller.taskModel.data?.data?[index];
                  DateTime? dueDate = task?.dueDate;
                  String formattedDate = dueDate != null
                      ? DateFormat('dd/MM/yyyy').format(dueDate)
                      : 'No Due Date';

                  String currentStatus = task?.status ?? 'Not Started';
                  Color currentColor =
                      _statusColors[currentStatus] ?? Colors.grey;

                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return TaskDetailBottomSheet(
                            title: task?.title ?? 'No Title',
                            projectName: task?.project?.name ?? 'No Project',
                            assignedBy: task?.assignedByUser?.name ?? 'Unknown',
                            dueDate: formattedDate,
                            status: currentStatus,
                            statusColor: currentColor,
                            priority: getPriorityLabel(task?.priority ?? 0),
                            reviewer: task?.reviewer?.name ?? 'Unknown',
                            description: cleanDescription(task?.description ?? ''),
                          );
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                      );
                    },
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task?.title ?? 'No Title',
                              style: GLTextStyles.openSans(
                                  size: 18, weight: FontWeight.w500),
                            ),
                            Text(
                              task?.project?.name ?? 'No Project',
                              style: GLTextStyles.openSans(
                                  size: 16,
                                  weight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: size.width * .008),
                            Row(
                              children: [
                                Text("assigned by  : ",
                                    style: GLTextStyles.openSans(
                                        size: 12,
                                        weight: FontWeight.w400,
                                        color: Colors.grey)),
                                Text(task?.assignedByUser?.name ?? 'Unknown',
                                    style: GLTextStyles.openSans(
                                        size: 13,
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
                                    Text(
                                      "Due date",
                                      style: GLTextStyles.openSans(
                                          size: 12,
                                          weight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                    Text(formattedDate,
                                        style: GLTextStyles.openSans(
                                            size: 14,
                                            weight: FontWeight.w400,
                                            color: Colors.black)),
                                  ],
                                ),
                                Container(
                                  height: size.width * .075,
                                  width: size.width * .26,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    color: currentColor,
                                  ),
                                  child: Center(
                                    child: PopupMenuButton<String>(
                                      onSelected: (String value) {
                                        final int taskId = task?.id ?? 0;
                                        const String statusNote = 'Some Note';
                                        controller.changeStatus(
                                            context, taskId, value, statusNote);
                                        setState(() {
                                          task?.status = value;
                                        });
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return _statusColors.keys
                                            .map((String status) {
                                          return PopupMenuItem<String>(
                                            value: status,
                                            child: Container(
                                              height: size.width * .075,
                                              width: size.width * .24,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                color: _statusColors[status],
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

  String cleanDescription(String description) {
    String cleaned = description.replaceAll(RegExp(r'<[^>]*>'), '');

    cleaned = cleaned.replaceAll('&nbsp;', ' ');

    cleaned = cleaned.replaceAll('\n', ' ');

    cleaned = cleaned.trim();

    return cleaned;
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

  void logoutConfirmation() {
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
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
                log("logged out");
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
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
}
