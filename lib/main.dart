import 'package:flutter/material.dart';
import 'package:omnisell_worksportal/presentation/attendance_screen/controller/attendance_controller.dart';
import 'package:omnisell_worksportal/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:omnisell_worksportal/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:omnisell_worksportal/presentation/custom_dashboard_screen/controller/custom_dashboard_controller.dart';
import 'package:omnisell_worksportal/presentation/profile_screen/controller/profile_controller.dart';
import 'package:omnisell_worksportal/presentation/project_detail_screen/controller/project_detail_controller.dart';
import 'package:omnisell_worksportal/presentation/project_screen/controller/project_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
  int userId = prefs.getInt(AppConfig.userId) ?? 0;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => HomeController()),
      ChangeNotifierProvider(create: (context) => BottomNavigationController()),
      ChangeNotifierProvider(create: (context) => AttendanceController()),
      ChangeNotifierProvider(create: (context) => ProjectController()),
      ChangeNotifierProvider(create: (context) => ProjectDetailsController()),
      ChangeNotifierProvider(create: (context) => ProfileController()),
      ChangeNotifierProvider(create: (context) => CustomDashboardController()),
    ],
    child: MyApp(isLoggedIn: loggedIn, userId: userId),
  ));
  await initOneSignal();
}

Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("19ba2058-3400-4f7a-a3ce-9ebfa69a56c0");
  await OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final int userId;

  const MyApp({super.key, required this.isLoggedIn, required this.userId});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    onClickOneSignal();
    return MaterialApp(
      theme: ThemeData(
        popupMenuTheme: const PopupMenuThemeData(
          elevation: 0,
          color: Colors.white70,
        ),
      ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn
          ? StatusNavigationBar(userId: userId)
          : const LoginScreen(),
    );
  }

  void onClickOneSignal() {
    OneSignal.Notifications.addClickListener((event) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
            builder: (context) => StatusNavigationBar(userId: userId)),
      );
    });
  }
}
