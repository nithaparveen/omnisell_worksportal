import 'package:flutter/material.dart';

import '../../../core/constants/textstyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    surfaceTintColor: Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 25, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Task Title",
                            style: GLTextStyles.openSans(
                                size: 20, weight: FontWeight.w500),
                          ),
                          Text(
                            "Project Name",
                            style: GLTextStyles.openSans(
                                size: 16,
                                weight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          Divider(
                            thickness: .2,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Assigned by",
                                    style: GLTextStyles.openSans(
                                        size: 12,
                                        weight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "Name",
                                    style: GLTextStyles.openSans(
                                      size: 14,
                                      weight: FontWeight.w400,
                                    ),
                                  ),
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
                                  Text(
                                    "Date",
                                    style: GLTextStyles.openSans(
                                      size: 14,
                                      weight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: size.width * .02,
                  );
                },
              )
            ],
          ),
        ));
  }
}
