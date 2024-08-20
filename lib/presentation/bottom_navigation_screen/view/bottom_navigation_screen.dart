import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../home_screen/controller/home_controller.dart';
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
  }

  List<Widget> buildScreens() {
    return statusData.keys.map((status) {
      return HomeScreen(userId: widget.userId, statusFilter: status);
    }).toList();
  }


  final Map<String, Map<String, dynamic>> statusData = {
    'Not Started': {
      'icon': Icons.circle_outlined,
      'color': Colors.grey,
    },
    'In Progress': {
      'icon': Icons.sync,
      'color': Colors.blue,
    },
    'Review Pending': {
      'icon': Icons.pending,
      'color': Colors.orange,
    },
    'Review Failed': {
      'icon': Icons.error,
      'color': Colors.red,
    },
    'Completed': {
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
  };

  List<PersistentBottomNavBarItem> navBarsItems() {
    return statusData.entries.map((entry) {
      return PersistentBottomNavBarItem(
        icon: Icon(entry.value['icon'],size: 22),
        title: entry.key,
        activeColorPrimary: entry.value['color'],
        inactiveColorPrimary: Colors.grey,
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationController>(builder: (context, provider, child) {
        tabController.index = provider.selectedIndex;
        return PersistentTabView(
          context,
          controller: tabController,
          screens: buildScreens(),
          items: navBarsItems(),
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
            provider.selectedIndex = index;
            var status = statusData.keys.elementAt(index);
            Provider.of<HomeController>(context, listen: false).fetchTasksByStatus(context, status);
          },
        );
      }),
    );
  }
}
