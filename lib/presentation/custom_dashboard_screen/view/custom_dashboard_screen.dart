import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/presentation/custom_dashboard_screen/view/widgets/card_screen.dart';
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

  void createDashboard(BuildContext context, int userId) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Create Dashboard",
                  style: GLTextStyles.cabinStyle(size: 18)),
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
                          backgroundColor: Colors.red,
                          icon: Icons.error,
                          iconColor: Colors.white,
                        );
                      } else {
                        final formattedDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());

                        Provider.of<CustomDashboardController>(context,
                                listen: false)
                            .createDashboard(
                          nameController.text.trim(),
                          descriptionController.text.trim(),
                          userId,
                          formattedDate,
                          context,
                        );
                        Navigator.of(context).pop();
                        AppUtils.showFlushbar(
                            context: context,
                            message: "Dashboard created successfully",
                            backgroundColor:
                                const Color.fromARGB(255, 230, 230, 230),
                            icon: Icons.done,
                            iconColor: Colors.green);
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
      ),
    );
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
          IconButton(
            onPressed: fetchData,
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => createDashboard(context, userId ?? 0),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color.fromARGB(255, 129, 166, 184)),
      ),
      body: Consumer<CustomDashboardController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorTheme.spider,
                size: 30,
              ),
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
                  final isEvenPosition = (index ~/ 2 + index % 2) % 2 == 0;
                  final gridColor = isEvenPosition
                      ? const Color.fromARGB(255, 129, 166, 184)
                      : const Color.fromARGB(255, 191, 223, 226);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardScreen(
                              dashboardId:
                                  controller.customListModel.data?[index].id ?? 0
                            ),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: gridColor,
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
                                size: 13,
                                weight: FontWeight.w500,
                              ),
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
