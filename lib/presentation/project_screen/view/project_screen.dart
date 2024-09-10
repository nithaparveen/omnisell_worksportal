import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omnisell_worksportal/app_config/app_config.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/view/project_detail_screen.dart';
import 'package:omnisell_worksportal/presentation/project_screen/controller/project_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late ScrollController scrollController;
  int? userId;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
    fetchUserId();
    fetchData();
  }

  Future<void> fetchUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt(AppConfig.userId);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void fetchData() async {
    await Provider.of<ProjectController>(context, listen: false)
        .fetchProjects(context);
    setState(() {});
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Provider.of<ProjectController>(context, listen: false)
          .fetchMoreProjects(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
            Text("Projects", style: GLTextStyles.cabinStyle(size: 22)),
          ],
        ),
        actions: [
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
      body: Consumer<ProjectController>(builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              color: Color.fromARGB(255, 46, 146, 157),
            ),
          );
        }

        if (controller.projectModel.data?.data?.isEmpty ?? true) {
          return const Center(child: Text("No Projects Available"));
        }
        return SafeArea(
          child: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                controller: scrollController,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.vertical,
                itemCount: controller.projectModel.data?.data?.length ??
                    0 + (controller.isMoreLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.projectModel.data?.data?.length &&
                      controller.isMoreLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Color.fromARGB(255, 46, 146, 157),
                      ),
                    );
                  }
                  final project = controller.projectModel.data?.data?[index];

                  int row = index ~/ 2;
                  int column = index % 2;
                  final isEvenPosition = (row + column) % 2 == 0;
                  final gridColor = isEvenPosition
                      ? const Color.fromARGB(255, 191, 223, 226)
                      : const Color.fromARGB(255, 129, 166, 184);

                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailScreen(
                          projectId: project?.id ?? 0,
                          userId: userId ?? 0,
                          projectName: project?.name ?? "",
                        ),
                      ),
                    ),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project?.name ?? '',
                                  maxLines: 3,
                                  style: GLTextStyles.interStyle(size: 15),
                                ),
                                SizedBox(height: size.width * .015),
                                Text(
                                  project?.account?.accountName ?? '',
                                  maxLines: 3,
                                  style: GLTextStyles.interStyle(
                                    size: 13,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              project?.startDate != null
                                  ? DateFormat('dd.MM.yyyy').format(DateTime.parse(
                                      "${controller.projectModel.data!.data![index].startDate!}"))
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
          ),
        );
      }),
    );
  }
}
