import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/view/widgets/activities_screen.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/view/widgets/detail_screen.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/view/widgets/members_screen.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/view/widgets/tasks_screen.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen(
      {super.key, required this.projectId, required this.userId});
  final int projectId;
  final int userId;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text(
          "Project Details",
          style: GLTextStyles.cabinStyle(size: 20),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // fetchData();
        //     },
        //     tooltip: "Refresh",
        //     icon: const Icon(
        //       CupertinoIcons.refresh_circled,
        //       size: 24,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorColor: const Color.fromARGB(255, 46, 146, 157),
          tabs: [
            Tab(
                child:
                    Text("Details", style: GLTextStyles.cabinStyle(size: 12))),
            Tab(child: Text("Tasks", style: GLTextStyles.cabinStyle(size: 12))),
            Tab(
                child: Text("Activities",
                    style: GLTextStyles.cabinStyle(size: 12))),
            Tab(
                child:
                    Text("Members", style: GLTextStyles.cabinStyle(size: 12))),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          DetailsScreen(projectId: widget.projectId),
          TasksScreen(projectId: widget.projectId),
          ActivitiesScreen(projectId: widget.projectId, userId: widget.userId),
          MembersScreen(projectId: widget.projectId),
        ],
      ),
    );
  }
}
