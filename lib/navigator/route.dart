import 'package:go_router/go_router.dart';
import 'package:koha/features/home/screens/home_screen.dart';
import 'package:koha/features/profile/screen/profile_screen.dart';
import 'package:koha/features/profile/widget/denonco.dart';
import 'package:koha/features/splash_screen/screens/splash_screen.dart';
import 'package:koha/navigator/scaffold_nav.dart';

class AppNavigation {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),

          // GoRoute(
          //   path: '/settings',
          //   builder: (context, state) => const SettingsScreen(),
          // ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/denonco',
        builder: (context, state) => const DenoncoScreen(),
      ),
    ],
  );
}
