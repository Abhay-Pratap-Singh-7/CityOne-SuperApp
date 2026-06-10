import 'package:cityoneapp/screens/home_screen.dart';
import 'package:cityoneapp/screens/notification_hub.dart';
import 'package:cityoneapp/widgets/main_shell.dart';
import 'package:cityoneapp/screens/OnBoarding&Auth/welcome_screen.dart';
import 'package:cityoneapp/screens/OnBoarding&Auth/login_screen.dart';
import 'package:cityoneapp/screens/OnBoarding&Auth/otp_verification_screen.dart';
import 'package:cityoneapp/screens/OnBoarding&Auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeDashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Orders Screen Placeholder')),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/ride',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Ride Screen Placeholder')),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/alerts',
              builder: (context, state) => const Scaffold(
                body: NotificationHubScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Profile Screen Placeholder')),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
