import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/controller/project_detail_controller.dart';
import 'package:provider/provider.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key, required this.projectId});
  final int projectId;

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await Provider.of<ProjectDetailsController>(context, listen: false)
        .fetchMembers(context, widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<ProjectDetailsController>(
        builder: (context, controller, _) {
      if (controller.membersModel.data!.data!.isEmpty) {
        return Center(
            child: Text(
          "No members added for this project",
          style: GLTextStyles.cabinStyle(
              size: 16, weight: FontWeight.w400, color: Colors.grey),
        ));
      }
      if (controller.isMembersLoading) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Color.fromARGB(255, 46, 146, 157),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  tileColor: Colors.teal[50],
                  title: Text(
                      controller.membersModel.data?.data?[index].name ?? "",
                      style: GLTextStyles.cabinStyle(
                        size: 16,
                        weight: FontWeight.w400,
                      )),
                  trailing: controller
                              .membersModel.data?.data?[index].isProjectOwner !=
                          0
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 150, 186, 190),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Project Owner",
                              style: GLTextStyles.cabinStyle(
                                  size: 12,
                                  weight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : null,
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: size.height * .01,
                ),
            itemCount: controller.membersModel.data!.data!.length),
      );
    });
  }
}
