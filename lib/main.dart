import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/presentation/home_screen/controller/home_controller.dart';
import 'package:omnisell_worksportal/presentation/home_screen/view/home_screen.dart';
import 'package:omnisell_worksportal/presentation/login_screen/controller/login_controller.dart';
import 'package:omnisell_worksportal/presentation/login_screen/view/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(AppConfig.loggedIn) ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => HomeController()),
  ], child: MyApp(isLoggedIn: loggedIn)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

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
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
