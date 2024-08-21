import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:omnisell_worksportal/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:omnisell_worksportal/presentation/home_screen/controller/home_controller.dart';
import 'package:omnisell_worksportal/presentation/login_screen/controller/login_controller.dart';
import 'package:omnisell_worksportal/presentation/login_screen/view/login_screen.dart';
import 'app_config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(AppConfig.loggedIn) ?? false;

  // Retrieve the userId from SharedPreferences
  int userId = prefs.getInt(AppConfig.userId) ?? 0;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => HomeController()),
      ChangeNotifierProvider(create: (context) => BottomNavigationController()),
    ],
    child: MyApp(isLoggedIn: loggedIn, userId: userId),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final int userId;

  const MyApp({super.key, required this.isLoggedIn, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        popupMenuTheme: const PopupMenuThemeData(
          elevation: 0,
          color: Colors.white70,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? StatusNavigationBar(userId: userId)
          : const LoginScreen(),
    );
  }
}
