import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_config/app_config.dart';
import '../../../core/constants/textstyles.dart';
import '../../login_screen/view/login_screen.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
        .fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        title: Text(
          "Work Board",
          style: GLTextStyles.cabinStyle(size: 22),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, size: 20),
            onPressed: () => _logoutConfirmation(),
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
                  DateTime? dueDate =
                      controller.taskModel.data?.data?[index].dueDate;
                  String formattedDate = dueDate != null
                      ? DateFormat('dd/MM/yyyy').format(dueDate)
                      : 'No Due Date';

                  return Card(
                    surfaceTintColor: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.taskModel.data?.data?[index].title}",
                            style: GLTextStyles.openSans(
                                size: 18, weight: FontWeight.w500),
                          ),
                          Text(
                            "${controller.taskModel.data?.data?[index].project?.name}",
                            style: GLTextStyles.openSans(
                                size: 16,
                                weight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          Divider(thickness: .2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Assigned by",
                                      style: GLTextStyles.openSans(
                                          size: 12,
                                          weight: FontWeight.w400,
                                          color: Colors.grey)),
                                  Text(
                                      "${controller.taskModel.data?.data?[index].assignedByUser?.name}",
                                      style: GLTextStyles.openSans(
                                          size: 14,
                                          weight: FontWeight.w400,
                                          color: Colors.black)),
                                ],
                              ),
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
                            ],
                          ),
                        ],
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

  Future<void> _logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AppConfig.token);
    sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _logoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _logout(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
