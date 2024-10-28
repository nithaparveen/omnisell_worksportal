import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/presentation/custom_dashboard_screen/controller/custom_dashboard_controller.dart';
import 'package:provider/provider.dart';

class CustomDashboardScreen extends StatefulWidget {
  const CustomDashboardScreen({super.key});

  @override
  State<CustomDashboardScreen> createState() => _CustomDashboardScreenState();
}

class _CustomDashboardScreenState extends State<CustomDashboardScreen> {
  int? userId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() async {
    await Provider.of<CustomDashboardController>(context, listen: false)
        .fetchDashboards(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: size.width * .075,
              width: size.width * .055,
              child: Image.asset("assets/logo-sw.png"),
            ),
            const SizedBox(width: 15),
            Text("Custom Dashboard", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                builder: (context) => CreateBottomSheet(
                  userId: userId ?? 0,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: .5)),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "CREATE",
                      style: GLTextStyles.cabinStyle(
                          size: 13,
                          weight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              fetchData();
            },
            tooltip: "Refresh",
            icon: const Icon(
              CupertinoIcons.refresh_circled,
              size: 24,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: Consumer<CustomDashboardController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.customListModel.data?.isEmpty ?? true) {
            return const Center(child: Text("No Dashboards Available"));
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: controller.customListModel.data!.length,
                itemBuilder: (context, index) {
                  final dashboard = controller.customListModel.data![index];

                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index.isEven
                            ? const Color.fromARGB(255, 129, 166, 184)
                            : const Color.fromARGB(255, 191, 223, 226),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dashboard.dashboardName ?? '',
                              maxLines: 3,
                              style: GLTextStyles.interStyle(size: 15),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dashboard.description ?? '',
                              maxLines: 3,
                              style: GLTextStyles.interStyle(
                                size: 13,
                                weight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              dashboard.createDate != null
                                  ? DateFormat('dd.MM.yyyy').format(
                                      DateTime.parse(
                                          dashboard.createDate!.toString()))
                                  : '',
                              style: GLTextStyles.interStyle(
                                  size: 13, weight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({
    super.key,
    required this.userId,
  });
  final int userId;
  @override
  CreateBottomSheetState createState() => CreateBottomSheetState();
}

class CreateBottomSheetState extends State<CreateBottomSheet> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomDashboardController>(
        builder: (context, controller, _) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        AppUtils.showFlushbar(
                            context: context,
                            message: "Please fill in all the fields",
                            backgroundColor:
                                const Color.fromARGB(255, 255, 0, 0),
                            icon: Icons.error,
                            iconColor: Colors.white);
                      } else {
                        final formattedDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());

                        Provider.of<CustomDashboardController>(context,
                                listen: false)
                            .createDashboard(
                          nameController.text.trim(),
                          descriptionController.text.trim(),
                          widget.userId,
                          formattedDate,
                          context,
                        );
                        Navigator.of(context).pop();
                        AppUtils.showFlushbar(
                          context: context,
                          message: "Dashboard created successfully",
                          backgroundColor:
                              const Color.fromARGB(255, 244, 244, 244),
                          icon: Icons.done,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF353967),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
