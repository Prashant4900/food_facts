import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_facts/views/screens/account/account_details_screen.dart';
import 'package:food_facts/views/screens/auth/login_screen.dart';
import 'package:food_facts/views/screens/dashboard.dart';
import 'package:food_facts/views/screens/home/home_screen.dart';
import 'package:food_facts/views/screens/language/language_screen.dart';
import 'package:food_facts/views/screens/notification/notifications_screen.dart';
import 'package:food_facts/views/screens/onboarding/onboarding_screen.dart';
import 'package:food_facts/views/screens/setting/setting_page.dart';
import 'package:food_facts/views/screens/theme/theme_screen.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class MyRoutes {
  static const home = '/';
  static const settingScreen = '/setting';
  static const onboardingScreen = '/onboarding';
  static const logInScreen = '/login';
  static const languageScreen = '/language';
  static const notificationScreen = '/notification';
  static const themeScreen = '/theme';
  static const accountDetailScreen = '/accountDetail';
}

final routerConfig = GoRouter(
  initialLocation: MyRoutes.languageScreen,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: MyRoutes.onboardingScreen,
      builder: (context, state) => const MyOnboardingScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: MyRoutes.logInScreen,
      builder: (context, state) => const MyLoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: MyRoutes.languageScreen,
      builder: (context, state) => const MyLanguageScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: MyRoutes.notificationScreen,
      builder: (context, state) => const MyNotificationScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: MyRoutes.themeScreen,
      builder: (context, state) => const MyThemeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: MyRoutes.accountDetailScreen,
      builder: (context, state) => const MyAccountDetailScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MyDashboard(child: child),
      routes: [
        GoRoute(
          path: MyRoutes.home,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MyHomePage()),
        ),
        GoRoute(
          path: MyRoutes.settingScreen,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MySettingPage()),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    return null;
  },
);
