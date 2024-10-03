import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koha/core/widgets/drawer.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const DrawerContent(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        surfaceTintColor: const Color(0xFF1E1E1E),
        leadingWidth: 30,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: SvgPicture.asset(
                  'assets/image/menu-icon.svg',
                  width: 21,
                  height: 14,
                ),
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/image/search-icon.svg',
              width: 28,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/image/bell-icon.svg',
              width: 28,
              height: 28,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF595959),
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/image/home-menu-icon.svg',
                width: 24, height: 20),
            activeIcon: SvgPicture.asset('assets/image/home-menu-icon.svg',
                width: 24, height: 24, color: Colors.white),
            label: 'Ballina',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/image/video-inactive.svg',
                width: 24, height: 17),
            activeIcon: SvgPicture.asset('assets/image/video.svg',
                width: 24, height: 24),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/image/live-inactive.svg',
                width: 24, height: 23),
            activeIcon: SvgPicture.asset('assets/image/live.svg',
                width: 24, height: 24),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/image/profile.png', width: 24, height: 24),
            activeIcon: SvgPicture.asset('assets/image/profile.png',
                width: 24, height: 24),
            label: 'Une',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/video')) {
      return 1;
    }
    if (location.startsWith('/live')) {
      return 2;
    }
    // We don't return 3 for profile anymore, as it's not part of this navigation
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/video');
        break;
      case 2:
        GoRouter.of(context).go('/live');
        break;
      case 3:
        // For profile, we navigate outside of the ShellRoute
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
