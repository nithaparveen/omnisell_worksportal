import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/presentation/custom_dashboard_screen/controller/custom_dashboard_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key, this.dashboardId});
  final int? dashboardId;
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() async {
    await Provider.of<CustomDashboardController>(context, listen: false)
        .fetchCards(context, widget.dashboardId);
  }

  void createCard(BuildContext context, int userId) {
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
          // leading: Icon(Icons.arrow_back_ios),
          title:
              Text("Dashboard Cards", style: GLTextStyles.cabinStyle(size: 22)),
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
          // automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
        ),
        floatingActionButton: FloatingActionButton.small(
            onPressed: () => createCard(context, widget.dashboardId ?? 0),
            backgroundColor: ColorTheme.spider,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Consumer<CustomDashboardController>(
          builder: (context, controller, _) {
            if (controller.isCardLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorTheme.spider,
                  size: 30,
                ),
              );
            }

            if (controller.cardListModel.data == null ||
                controller.cardListModel.data!.isEmpty) {
              return Center(
                  child: Text(
                "No Cards available",
                style: GLTextStyles.cabinStyle(
                    size: 16, weight: FontWeight.w400, color: Colors.grey),
              ));
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(controller.cardListModel.data?[index].id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    surfaceTintColor: ColorTheme.white,
                                    title: Text(
                                      'Confirm Delete',
                                      style: GLTextStyles.cabinStyle(
                                        color: ColorTheme.spider,
                                        size: 16,
                                        weight: FontWeight.w500,
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to delete?',
                                      style: GLTextStyles.cabinStyle(
                                        color: ColorTheme.spider,
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
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
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xff468585))),
                                        onPressed: () async {
                                          controller.deleteCard(
                                              controller
                                                  .cardListModel.data?[index].id
                                                  .toString(),
                                              context);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(
                                                  seconds: 1, milliseconds: 50),
                                              content: Text(
                                                "Card successfully deleted",
                                                style: GLTextStyles.cabinStyle(
                                                    color: ColorTheme.white,
                                                    weight: FontWeight.w500,
                                                    size: 14),
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 97, 182, 86),
                                            ),
                                          );
                                          fetchData();
                                        },
                                        child: Text('Confirm',
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
                            },
                            backgroundColor: ColorTheme.white,
                            foregroundColor: ColorTheme.spider,
                            icon: CupertinoIcons.delete_solid,
                          ),
                        ],
                      ),
                      child: Card(
                        surfaceTintColor: ColorTheme.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18, right: 18, top: 12, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Card type : ",
                                  style: GLTextStyles.openSans(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: Colors.grey)),
                              Text(
                                  controller.cardListModel.data?[index]
                                          .cardName ??
                                      'Card Name',
                                  style: GLTextStyles.openSans(
                                      size: 18, weight: FontWeight.w500)),
                              Text(
                                  controller.cardListModel.data?[index]
                                          .cardDescription ??
                                      'Description',
                                  style: GLTextStyles.openSans(
                                      size: 14,
                                      weight: FontWeight.w500,
                                      color: Colors.grey)),
                              SizedBox(height: size.width * .005),
                              const Divider(thickness: .25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Created by",
                                          style: GLTextStyles.openSans(
                                              size: 11,
                                              weight: FontWeight.w400,
                                              color: Colors.grey)),
                                      Text(
                                        "user",
                                        style: GLTextStyles.openSans(
                                            size: 12,
                                            weight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      if (controller.customListModel
                                              .data?[index].createDate !=
                                          null)
                                        Text("Created date",
                                            style: GLTextStyles.openSans(
                                                size: 11,
                                                weight: FontWeight.w400,
                                                color: Colors.grey)),
                                      if (controller.customListModel
                                              .data?[index].createDate !=
                                          null)
                                        Text(
                                          DateFormat('dd/MM/yyyy').format(
                                              controller
                                                  .customListModel
                                                  .data![index]
                                                  .createDate as DateTime),
                                          style: GLTextStyles.openSans(
                                              size: 12,
                                              weight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Priority",
                                          style: GLTextStyles.openSans(
                                              size: 11,
                                              weight: FontWeight.w400,
                                              color: Colors.grey)),
                                      Text(
                                        "Medium",
                                        style: GLTextStyles.openSans(
                                            size: 12,
                                            weight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
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
                  separatorBuilder: (context, index) => SizedBox(
                    height: size.height * .001,
                  ),
                  itemCount: controller.cardListModel.data?.length ?? 0,
                ),
              ),
            );
          },
        ));
  }
}
