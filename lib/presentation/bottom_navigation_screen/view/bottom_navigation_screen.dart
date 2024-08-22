import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../controller/bottom_navigation_controller.dart';

class StatusNavigationBar extends StatefulWidget {
  const StatusNavigationBar({super.key, required this.userId});

  final int userId;

  @override
  State<StatusNavigationBar> createState() => _StatusNavigationBarState();
}

class _StatusNavigationBarState extends State<StatusNavigationBar> {
  late PersistentTabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = PersistentTabController(initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BottomNavigationController>(context, listen: false)
          .fetchDataForTab(context, tabController.index, widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationController>(
        builder: (context, provider, child) {
          return PersistentTabView(
            context,
            controller: tabController,
            screens: provider.buildScreens(widget.userId),
            items: provider.navBarsItems(),
            confineToSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            navBarStyle: NavBarStyle.style1,
            onItemSelected: (index) {
              provider.updateSelectedIndex(context, index, widget.userId);

              setState(() {
                tabController.index = index;
              });
            },
          );
        },
      ),
    );
  }
}
