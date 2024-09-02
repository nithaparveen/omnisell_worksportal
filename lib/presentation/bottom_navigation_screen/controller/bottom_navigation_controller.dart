import 'package:flutter/material.dart';

class BottomNavigationController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void updateSelectedIndex(BuildContext context, int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void fetchDataForTab(BuildContext context, int index, int userId) async {
    // Update this method if required for fetching data related to tabs
  }
}
