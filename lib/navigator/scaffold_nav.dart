import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: SvgPicture.asset(
            'assets/image/menu-icon.svg',
            width: 21,
            height: 14,
          ),
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
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/image/home-menu-icon.svg'),
            activeIcon: SvgPicture.asset('assets/image/home-menu-icon.svg',
                width: 24, height: 17, color: Colors.white),
            label: 'Ballina',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/image/video-inactive.svg',
                width: 24, height: 17),
            activeIcon: SvgPicture.asset('assets/image/video.svg',
                width: 24, height: 17),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/image/live-inactive.svg',
                width: 24, height: 17),
            activeIcon: SvgPicture.asset('assets/image/live.svg',
                width: 24, height: 17),
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
    if (location == '/') {
      return 0;
    }
    if (location.startsWith('/video')) {
      return 1;
    }
    if (location.startsWith('/live')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/video');
        break;
      case 2:
        GoRouter.of(context).go('/live');
        break;
      case 3:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
