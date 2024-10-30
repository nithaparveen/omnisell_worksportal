import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/core/utils/app_utils.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/controller/project_detail_controller.dart';
import 'package:provider/provider.dart';

class SprintsScreen extends StatefulWidget {
  const SprintsScreen({super.key, required this.projectId});
  final int projectId;

  @override
  State<SprintsScreen> createState() => _SprintsScreenState();
}

class _SprintsScreenState extends State<SprintsScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<ProjectDetailsController>(context, listen: false)
        .fetchSprints(context, widget.projectId);
  }

  void createSprint() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddSprintForm(projectId: widget.projectId),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<ProjectDetailsController>(
        builder: (context, controller, _) {
      if (controller.isSprintsLoading) {
        return  Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
             
              color: ColorTheme.spider,
              size: 30,
            ),
        );
      }
      if (controller.sprintListModel.data == null ||
          controller.sprintListModel.data!.isEmpty) {
        return Center(
            child: Text(
          "No sprints added for this project",
          style: GLTextStyles.cabinStyle(
              size: 16, weight: FontWeight.w400, color: Colors.grey),
        ));
      }
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
            child: ListView.separated(
              itemBuilder: (context, index) => Card(
                surfaceTintColor: ColorTheme.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          controller.sprintListModel.data?[index].name ??
                              'No Title',
                          style: GLTextStyles.openSans(
                              size: 18, weight: FontWeight.w500)),
                      Text(
                          controller.sprintListModel.data?[index].description ??
                              'No Project',
                          style: GLTextStyles.openSans(
                              size: 16,
                              weight: FontWeight.w400,
                              color: Colors.grey)),
                      SizedBox(height: size.width * .008),
                      const Divider(thickness: .25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start date",
                                  style: GLTextStyles.openSans(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: Colors.grey)),
                              Text(
                                controller.sprintListModel.data?[index]
                                            .startDate !=
                                        null
                                    ? DateFormat('dd/MM/yyyy').format(controller
                                        .sprintListModel
                                        .data![index]
                                        .startDate as DateTime)
                                    : "",
                                style: GLTextStyles.openSans(
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              if (controller
                                      .sprintListModel.data?[index].endDate !=
                                  null)
                                Text("End date",
                                    style: GLTextStyles.openSans(
                                        size: 12,
                                        weight: FontWeight.w400,
                                        color: Colors.grey)),
                              if (controller
                                      .sprintListModel.data?[index].endDate !=
                                  null)
                                Text(
                                  controller.sprintListModel.data?[index]
                                              .endDate !=
                                          null
                                      ? DateFormat('dd/MM/yyyy').format(
                                          controller.sprintListModel
                                              .data![index].endDate as DateTime)
                                      : "",
                                  style: GLTextStyles.openSans(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Due date",
                                  style: GLTextStyles.openSans(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: Colors.grey)),
                              Text(
                                controller.sprintListModel.data?[index]
                                            .dueDate !=
                                        null
                                    ? DateFormat('dd/MM/yyyy').format(controller
                                        .sprintListModel
                                        .data![index]
                                        .dueDate as DateTime)
                                    : "",
                                style: GLTextStyles.openSans(
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text("Status",
                                  style: GLTextStyles.openSans(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: Colors.grey)),
                              Text(
                                  controller.sprintListModel.data![index]
                                          .status ??
                                      'No Status',
                                  style: GLTextStyles.openSans(
                                      size: 12,
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
              separatorBuilder: (context, index) => SizedBox(
                height: size.height * .005,
              ),
              itemCount: controller.sprintListModel.data!.length,
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: createSprint,
              backgroundColor: ColorTheme.spider,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class AddSprintForm extends StatefulWidget {
  final int projectId;

  const AddSprintForm({super.key, required this.projectId});

  @override
  State<AddSprintForm> createState() => _AddSprintFormState();
}

class _AddSprintFormState extends State<AddSprintForm> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController startDateController;
  late final TextEditingController dueDateController;
  late final TextEditingController expectedHoursController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    startDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    dueDateController = TextEditingController();
    expectedHoursController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    dueDateController.dispose();
    expectedHoursController.dispose();
    super.dispose();
  }

  Future<void> selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Create Sprint", style: GLTextStyles.cabinStyle(size: 18)),
            TextField(
              controller: nameController,
              style: GLTextStyles.openSans(
                size: 16,
                weight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GLTextStyles.openSans(
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              style: GLTextStyles.openSans(
                size: 16,
                weight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: GLTextStyles.openSans(
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: startDateController,
                    readOnly: true,
                    style: GLTextStyles.openSans(
                      size: 16,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      labelStyle: GLTextStyles.openSans(
                        size: 14,
                        weight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () => selectDate(startDateController),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: dueDateController,
                    readOnly: true,
                    style: GLTextStyles.openSans(
                      size: 16,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      labelStyle: GLTextStyles.openSans(
                        size: 14,
                        weight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () => selectDate(dueDateController),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expectedHoursController,
              keyboardType: TextInputType.number,
              style: GLTextStyles.openSans(
                size: 16,
                weight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: 'Expected Hours',
                labelStyle: GLTextStyles.openSans(
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  Color(0xff468585),
                ),
              ),
              onPressed: () {
                Provider.of<ProjectDetailsController>(context, listen: false)
                    .createSprint(
                        nameController.text.trim(),
                        descriptionController.text.trim(),
                        widget.projectId,
                        startDateController.text.trim(),
                        dueDateController.text.trim(),
                        expectedHoursController.text.trim(),
                        context);
                Navigator.pop(context);
                AppUtils.showFlushbar(
                    context: context,
                    message: "Sprint created successfully",
                    backgroundColor: const Color.fromARGB(255, 230, 230, 230),
                    icon: Icons.done,
                    iconColor: Colors.green);
              },
              child: Text(
                'Add Sprint',
                style: GLTextStyles.cabinStyle(
                  size: 16,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
