import 'package:flutter/material.dart';
import 'package:washmen/colors.dart';
import 'package:washmen/dashboard/dashboard_menus/bookiong_screen.dart';
import 'package:washmen/dashboard/dashboard_menus/customer_portal_screen.dart';
import 'package:washmen/dashboard/dashboard_menus/downloads_screen.dart';
import 'package:washmen/dashboard/dashboard_menus/events_screen.dart';
import 'package:washmen/dashboard/dashboard_menus/sops_screen.dart';
import 'package:washmen/dashboard/sales_center_screen.dart';
import 'package:washmen/development_progress.dart';
import 'package:washmen/dashboard/dashboard_menus/online_payments_screen.dart';
import 'package:washmen/dashboard/dashboard_menus/social_screen.dart';
import '../bottom_app_bar/bottom_app_bar.dart';
import '../constants/image_constant.dart';
import '../customs/dialogs/development_progress_dialog.dart';
import '../customs/login_check_util.dart';
import 'dashboard_menus/payment_plans_screen.dart';
import '../login_screen.dart';

class DashboardMenus extends StatefulWidget {
  const DashboardMenus({super.key});

  @override
  State<DashboardMenus> createState() => _DashboardMenusState();
}

class _DashboardMenusState extends State<DashboardMenus> {
  final List<String> projects = const [
    'Gwadar Golf City',
    'New Metro City Sarai Alamgir',
    'New Metro City Gujar Khan',
    'New Metro City Mandi Bahauddin',
    'New Metro City Ravi Lahore',
  ];

  late ScrollController _scrollController;
  bool _showDownArrow = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
      setState(() => _showDownArrow = true);
    } else if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() => _showDownArrow = false);
    }
  }

  void _scrollTo(bool toBottom) {
    _scrollController.animateTo(
      toBottom ? _scrollController.position.maxScrollExtent : _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _handleNavigationWithLoginCheck(BuildContext context, Widget screen, {bool requiresLogin = false}) async {
    if (requiresLogin) {
      final isLoggedIn = await LoginCheckUtil.isUserLoggedIn();

      if (!isLoggedIn) {
        // Show login required dialog
        LoginCheckUtil.showLoginRequiredDialog(
          context,
          onYesPressed: () {
            // Navigate to login screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        );
        return;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainWrapper(
          initialIndex: 0,
          child: screen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide > 600;

    final menuItems = [
      {
        'icon': ImageConstant.portal,
        'title': 'Customer Portal',
        'onTap': () => _handleNavigationWithLoginCheck(
          context,
          CustomerPortalScreen(),
          requiresLogin: true,
        ),
      },
      {
        'icon': ImageConstant.booking,
        'title': 'Booking',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: BookingScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.pay,
        'title': 'Payment Plan',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: PaymentPlanScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.social,
        'title': 'Social',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: SocialScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.payment,
        'title': 'Online Payments',
        'onTap': () => _handleNavigationWithLoginCheck(
          context,
          OnlinePaymentsScreen(),
          requiresLogin: true,
        ),
      },
      {
        'icon': ImageConstant.devlop,
        'title': 'Development Progress',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: GetDevelopmentProgressScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.gallery,
        'title': 'Events',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: GetEventsScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.vr,
        'title': 'VR Tour',
        'onTap': () => print('VR Tour tapped'),
      },
      {
        'icon': ImageConstant.download,
        'title': 'Downloads',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: DocumentsScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.sops,
        'title': 'SOPs',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainWrapper(
              initialIndex: 0,
              child: SOPsScreen(),
            ),
          ),
        ),
      },
      {
        'icon': ImageConstant.policy,
        'title': 'Privacy Policy',
        'onTap': () => print('Privacy Policy tapped'),
      },
    ];

    return Container(
      color: AppColors.appColor,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
                vertical: screenSize.height * 0.02,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 4 : 3,
                  crossAxisSpacing: screenSize.width * 0.09,
                  mainAxisSpacing: screenSize.height * 0.01,
                  childAspectRatio: 0.85,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildMenuItem(
                    context,
                    item['icon'] as String,
                    item['title'] as String,
                    onTap: item['onTap'] as VoidCallback?,
                  );
                },
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.appColor.withOpacity(0.1),
                    AppColors.appColor.withOpacity(0.3),
                    AppColors.appColor.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: screenSize.height * 0.02,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => _scrollTo(_showDownArrow),
                child: Container(
                  padding: EdgeInsets.all(screenSize.width * 0.015),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Icon(
                      _showDownArrow ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                      key: ValueKey<bool>(_showDownArrow),
                      color: Colors.white,
                      size: screenSize.width * 0.06,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String iconPath, String text, {VoidCallback? onTap}) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide > 600;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(screenSize.width * 0.03),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isTablet ? screenSize.width * 0.16 : screenSize.width * 0.18,
            height: isTablet ? screenSize.width * 0.16 : screenSize.width * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenSize.width * 0.03),
              color: AppColors.whiteBg,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: isTablet ? screenSize.width * 0.07 : screenSize.width * 0.08,
                height: isTablet ? screenSize.width * 0.07 : screenSize.width * 0.08,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.005),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenSize.width * 0.25,
              maxHeight: screenSize.height * 0.06,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? screenSize.width * 0.025 : screenSize.width * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}