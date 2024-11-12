import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/presentation/profile_screen/view/profile_screen.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging &&
          tabController.index == tabController.animation!.value) {
        fetchData();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      homeController.setUserId(widget.userId);

      if (widget.statusFilter != null) {
        tabController.animateTo(getTabIndexFromStatus(widget.statusFilter!));
      }

      fetchData();
    });
  }

  Future<void> fetchData() async {
    final homeController = Provider.of<HomeController>(context, listen: false);
    String statusFilter = getStatusFilter();
    await homeController.fetchTasksByStatus(context, statusFilter);
  }

  String getStatusFilter() {
    int index = tabController.index;
    switch (index) {
      case 0:
        return 'Not Started';
      case 1:
        return 'In Progress';
      case 2:
        return 'Review Pending';
      case 3:
        return 'Review Failed';
      case 4:
        return 'Completed';
      default:
        return 'Not Started';
    }
  }

  int getTabIndexFromStatus(String status) {
    switch (status) {
      case 'Not Started':
        return 0;
      case 'In Progress':
        return 1;
      case 'Review Pending':
        return 2;
      case 'Review Failed':
        return 3;
      case 'Completed':
        return 4;
      default:
        return 0;
    }
  }

  final Map<String, Color> statusColors = {
    'Not Started': Colors.grey,
    'In Progress': Colors.blue,
    'Review Pending': Colors.orange,
    'Review Failed': Colors.red,
    'Completed': Colors.green,
  };

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
                height: size.width * .075,
                width: size.width * .055,
                child: Image.asset("assets/logo-sw.png")),
            const SizedBox(width: 15),
            Text("Work Board", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
        actions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: PopupMenuButton<String>(
              color: Colors.teal[50],
              icon: const Icon(Icons.person_2_rounded),
              tooltip: "Profile",
              onSelected: (String result) {
                switch (result) {
                  case 'Profile':
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            userId: widget.userId,
                          ),
                        ));
                    break;
                  case 'Logout':
                    showLogoutConfirmation();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                    value: 'Profile',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(width: size.width * .03),
                        Text('Profile',
                            style: GLTextStyles.cabinStyle(size: 14)),
                      ],
                    )),
                PopupMenuItem<String>(
                    value: 'Logout',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(width: size.width * .03),
                        Text('Logout',
                            style: GLTextStyles.cabinStyle(size: 14)),
                      ],
                    )),
              ],
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: const Color.fromARGB(255, 46, 146, 157),
          labelColor: Colors.black,
          labelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          tabs: const [
            Tab(text: "Not Started"),
            Tab(text: "In Progress"),
            Tab(text: "Review Pending"),
            Tab(text: "Review Failed"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: List.generate(5, (index) {
          String statusFilter = getStatusFilter();
          var filteredTasks = Provider.of<HomeController>(context)
                  .taskModel
                  .data
                  ?.data
                  ?.where((task) => task.status == statusFilter)
                  .toList() ??
              [];

          if (Provider.of<HomeController>(context).isLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorTheme.spider,
                size: 30,
              ),
            );
          }

          if (filteredTasks.isEmpty) {
            return Center(
              child: Text(
                "No tasks available",
                style: GLTextStyles.cabinStyle(
                    size: 16, weight: FontWeight.w400, color: Colors.grey),
              ),
            );
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

                    Color currentColor =
                        statusColors[task.status] ?? Colors.grey;

                    return InkWell(
                      onTap: () => showTaskDetailBottomSheet(
                          context, task, currentColor),
                      child: Card(
                        surfaceTintColor: ColorTheme.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.title ?? 'No Title',
                                  style: GLTextStyles.openSans(
                                      size: 16, weight: FontWeight.w500)),
                              Text(task.project?.name ?? 'No Project',
                                  style: GLTextStyles.openSans(
                                      size: 14,
                                      weight: FontWeight.w400,
                                      color: Colors.grey)),
                              SizedBox(height: size.width * .008),
                              Row(
                                children: [
                                  Text("assigned by: ",
                                      style: GLTextStyles.openSans(
                                          size: 10,
                                          weight: FontWeight.w400,
                                          color: Colors.grey)),
                                  Text(task.assignedByUser?.name ?? 'Unknown',
                                      style: GLTextStyles.openSans(
                                          size: 11,
                                          weight: FontWeight.w400,
                                          color: Colors.black)),
                                ],
                              ),
                              const Divider(thickness: .25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Due date",
                                          style: GLTextStyles.openSans(
                                              size: 10,
                                              weight: FontWeight.w400,
                                              color: Colors.grey)),
                                      Text(formattedDate,
                                          style: GLTextStyles.openSans(
                                              size: 12,
                                              weight: FontWeight.w400,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Status",
                                          style: GLTextStyles.openSans(
                                              size: 10,
                                              weight: FontWeight.w400,
                                              color: Colors.grey)),
                                      Text(task.status ?? 'No Status',
                                          style: GLTextStyles.openSans(
                                              size: 12,
                                              weight: FontWeight.w600,
                                              color: currentColor)),
                                    ],
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
                      const SizedBox(height: 5),
                ),
              ],
            ),
          );
        }),
      ),
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
          onStatusChange: (
            String newStatus,
            String remark,
          ) async {
            final int taskId = task?.id ?? 0;
            try {
              final homeController =
                  Provider.of<HomeController>(context, listen: false);
              await homeController.changeStatus(
                  context, taskId, newStatus, remark);
              await homeController.fetchTasksByStatus(
                  context, widget.statusFilter ?? '');
              setState(() {});
              Navigator.pop(context);
              fetchData();
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
          surfaceTintColor: Colors.white,
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.cabinStyle(size: 18),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GLTextStyles.cabinStyle(
                  size: 14,
                  color: const Color(0xff468585),
                  weight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xff468585))),
              onPressed: () {
                Navigator.of(context).pop();
                logout(context);
              },
              child: Text('Logout',
                  style: GLTextStyles.cabinStyle(
                    size: 14,
                    color: Colors.white,
                    weight: FontWeight.w500,
                  )),
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
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      await homeController.changeStatus(context, taskId, newStatus, statusNote);
      await homeController.fetchTasksByStatus(
          context, widget.statusFilter ?? '');
      setState(() {});
    } catch (e) {
      log('Error changing status: $e');
    }
  }
}
