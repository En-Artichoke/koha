import 'package:go_router/go_router.dart';
import 'package:koha/features/home/screens/home_screen.dart';
import 'package:koha/features/profile/screen/profile_screen.dart';
import 'package:koha/navigator/scaffold_nav.dart';

class AppNavigation {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          // GoRoute(
          //   path: '/settings',
          //   builder: (context, state) => const SettingsScreen(),
          // ),
        ],
      ),
    ],
  );
}
