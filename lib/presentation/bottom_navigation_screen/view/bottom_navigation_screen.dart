import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/view/attendance_screen.dart';
import 'package:omnisell_worksportal/presentation/custom_dashboard_screen/view/custom_dashboard_screen.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/home_screen.dart';
import 'package:omnisell_worksportal/presentation/project_screen/view/project_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: tabController,
        screens: _buildScreens(widget.userId),
        items: _navBarsItems(),
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
      ),
    );
  }

  List<Widget> _buildScreens(int userId) {
    return [
      HomeScreen(userId: userId),
      const AttendanceScreen(),
      const ProjectScreen(),
      const CustomDashboardScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.dashboard,
          size: 18,
        ),
        title: "Work Board",
        textStyle: GLTextStyles.cabinStyle(size: 20, weight: FontWeight.w500),
        activeColorPrimary: const Color.fromARGB(255, 24, 133, 115),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sticky_note_2, size: 18),
        title: "Attendances",
        textStyle: GLTextStyles.cabinStyle(size: 20, weight: FontWeight.w500),
        activeColorPrimary: const Color(0xff1c96ac),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.note, size: 18),
        title: "Projects",
        textStyle: GLTextStyles.cabinStyle(size: 14, weight: FontWeight.w500),
        activeColorPrimary: const Color(0xff2c74a4),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.note, size: 18),
        title: "Dashboard",
        textStyle: GLTextStyles.cabinStyle(size: 14, weight: FontWeight.w500),
        activeColorPrimary: const Color(0xff2c74a4),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
