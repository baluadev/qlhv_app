import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qlhv_app/configs/assets.dart';
import 'package:qlhv_app/configs/colors.dart';
import 'package:qlhv_app/helper/bottom_nav_bar/persistent_bottom_nav_bar_v2.dart';
import 'package:qlhv_app/helper/extentions.dart';
import 'package:qlhv_app/pages/add/add_page.dart';
import 'package:qlhv_app/pages/home/home_page.dart';
import 'package:qlhv_app/pages/notifications/notifications_page.dart';
import 'package:qlhv_app/pages/search/search_page.dart';
import 'package:qlhv_app/pages/settings/settings_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PersistentTabController controller;
  @override
  void initState() {
    controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: PersistentTabView(
        controller: controller,
        tabs: [
          _buildTab(
              screen: const HomePage(),
              icon: Assets.icHome.svg(),
              inactiveIcon: Assets.icHome.svg(),
              title: ''),
          _buildTab(
              screen: const SearchPage(),
              icon: Assets.icSearch.svg(),
              inactiveIcon: Assets.icSearch.svg(),
              title: ''),
          _buildTab(
              screen: const AddPage(),
              icon: Assets.icAddCircle.svg(),
              inactiveIcon: Assets.icAddCircle.svg(),
              title: ''),
          _buildTab(
              screen: const NotificationPage(),
              icon: Assets.icNotification.svg(),
              inactiveIcon: Assets.icNotification.svg(),
              title: ''),
          _buildTab(
              screen: const SettingsPage(),
              icon: Assets.icSetting.svg(),
              inactiveIcon: Assets.icSetting.svg(),
              title: ' '),
        ],
        navBarBuilder: (navBarConfig) => Style5BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: Colors.black,
            padding: EdgeInsets.only(top: 10.w),
            border: Border.all(
              width: 0.1,
              color: context.color.black,
            ),
          ),
        ),
      ),
    );
  }

  PersistentTabConfig _buildTab({
    required Widget screen,
    required Widget icon,
    required Widget inactiveIcon,
    required String title,
  }) {
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        icon: icon,
        inactiveIcon: inactiveIcon,
        title: title,
        activeForegroundColor: Colors.white,
        inactiveForegroundColor: Colors.white,
        textStyle: Theme.of(context).textTheme.titleSmall!,
      ),
    );
  }
}
