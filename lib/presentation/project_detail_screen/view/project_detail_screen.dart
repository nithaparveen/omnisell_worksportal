import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,size: 20,)),
        title: Text("ProjectName", style: GLTextStyles.cabinStyle(size: 22),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // fetchData();
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
        // bottom: TabBar(
        //   controller: tabController,
        //   labelColor: Colors.black,
        //   tabs: [
        //   Tab(child: Text("Tasks", style: GLTextStyles.cabinStyle(size: 12))),
        //     Tab(
        //         child: Text("Activities",
        //             style: GLTextStyles.cabinStyle(size: 12))),
        //     Tab(child: Text("Members", style: GLTextStyles.cabinStyle(size: 12))),
        // ],),
      ),
    );
  }
}
