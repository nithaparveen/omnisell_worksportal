import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/presentation/home_screen/controller/home_controller.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavigationController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
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

  List<Widget> buildScreens(int userId) {
    return statusData.keys.map((status) {
      return HomeScreen(userId: userId, statusFilter: status);
    }).toList();
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return statusData.entries.map((entry) {
      return PersistentBottomNavBarItem(
        icon: Icon(entry.value['icon'], size: 22),
        title: entry.key,
        activeColorPrimary: entry.value['color'],
        inactiveColorPrimary: Colors.grey,
      );
    }).toList();
  }

  void updateSelectedIndex(BuildContext context, int index, int userId) {
    _selectedIndex = index;
    fetchDataForTab(context, index, userId);
    notifyListeners();
  }

  void fetchDataForTab(BuildContext context, int index, int userId) async {
    var status = statusData.keys.elementAt(index);
    await Provider.of<HomeController>(context, listen: false)
        .fetchTasksByStatus(context, status);
    notifyListeners();
  }
}
