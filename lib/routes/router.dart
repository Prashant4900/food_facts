import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_facts/repositories/auth_repository.dart';
import 'package:food_facts/setup.dart';
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

FutureOr<String?> _routeRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  final isAuthenticated = await getIt<AuthRepository>().isUserAuth();
  final location = state.matchedLocation;

  bool isLogoutOnlyScreen(String location) {
    return location == MyRoutes.onboardingScreen ||
        location == MyRoutes.logInScreen;
  }

  bool isLoginOnlyScreen(String location) {
    return [
      MyRoutes.home,
      MyRoutes.settingScreen,
      MyRoutes.notificationScreen,
      MyRoutes.accountDetailScreen,
      MyRoutes.themeScreen,
    ].contains(location);
  }

  if (!isAuthenticated && isLoginOnlyScreen(location)) {
    return MyRoutes.languageScreen;
  }

  if (isAuthenticated && isLogoutOnlyScreen(location)) {
    return MyRoutes.home;
  }

  return null; // No redirection needed
}

final routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: kDebugMode,
  redirect: _routeRedirect,
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
);
