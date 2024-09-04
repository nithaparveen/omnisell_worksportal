import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/core/constants/colors.dart';
import 'package:omnisell_worksportal/core/constants/textstyles.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/view/attendance_screen.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/home_screen.dart';
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
      AttendanceScreen(),  // Assuming AttendanceScreen is a separate screen for handling attendances
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.work_outlined,size: 18,),
        title: "Work Board",
        textStyle:GLTextStyles.cabinStyle(size: 20,weight: FontWeight.w500) ,
        activeColorPrimary:ColorTheme.spider,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.sticky_note_2_outlined , size:18),
        title: "Attendances",
        textStyle:GLTextStyles.cabinStyle(size: 20,weight: FontWeight.w500) ,
        activeColorPrimary: Color.fromARGB(255, 48, 119, 101),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
