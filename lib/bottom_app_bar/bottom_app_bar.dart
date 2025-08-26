import 'package:flutter/material.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/dashboard/about_us_screen.dart';
import 'package:washmen/dashboard/profile_screen.dart';
import 'package:washmen/dashboard/sales_center_screen.dart';
import '../constants/image_constant.dart';
import '../dashboard/main_screen.dart';

class BottomNavItem {
  final String label;
  final String iconPath;
  final Widget screen;

  const BottomNavItem({
    required this.label,
    required this.iconPath,
    required this.screen,
  });
}

class MainWrapper extends StatefulWidget {
  final int initialIndex;
  final Widget? child;

  const MainWrapper({super.key, this.initialIndex = 0, this.child});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _currentIndex;
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    // Initialize all screens once
    _screens.addAll([
      const MainScreen(),
      const ProfileScreen(title: 'Profile'),
      const SalesCenterScreen(title: 'Sales Centers'),
      const AboutUsScreen(title: 'About us'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.child ?? _screens[_currentIndex],
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _navItems.length,
              (index) => GestureDetector(
            onTap: () => _handleNavTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  _navItems[index].iconPath,
                  width: 24,
                  height: 24,
                  color: _currentIndex == index ? AppColors.appColor : Colors.grey,
                ),
                const SizedBox(height: 4),
                Text(
                  _navItems[index].label,
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentIndex == index ? AppColors.appColor : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavTap(int index) {
    if (widget.child != null) {
      // If coming from a child route, reset the navigation stack
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainWrapper(initialIndex: index),
        ),
            (route) => false,
      );
    } else {
      // Normal tab switch
      if (_currentIndex != index) {
        setState(() => _currentIndex = index);
      }
    }
  }

  static final List<BottomNavItem> _navItems = [
     BottomNavItem(
      label: 'Home',
      iconPath: ImageConstant.home,
      screen: MainScreen(),
    ),
     BottomNavItem(
      label: 'Profile',
      iconPath: ImageConstant.profile,
      screen: ProfileScreen(title: 'Profile'),
    ),
     BottomNavItem(
      label: 'Sales Centers',
      iconPath: ImageConstant.sales,
      screen: SalesCenterScreen(title: 'Sales Centers'),
    ),
    BottomNavItem(
      label: 'About us',
      iconPath: ImageConstant.about,
      screen: const AboutUsScreen(title: 'About us'),
    ),
  ];
}