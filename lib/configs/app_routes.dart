import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:qlhv_app/pages/main_view.dart';

class AppRoutes {
  static const String root = '/';

  Route onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
        builder: (_) => _buildAppWidget(), settings: settings);
  }

  Widget _buildAppWidget() {
    return _getHome();
  }

  Widget _getHome() {
    // return BlocBuilder<AuthCubit, AuthState>(
    //   builder: (c, state) {
    // if (state is AuthOnboardingState) {
    //   return const OnBoardingView();
    // }

    return const MainView();
    //   },
    // );
  }
}

// Hiệu ứng chuyển màn Hero
class CustomPageRoute extends PageRouteBuilder {
  final Widget? page;
  final RouteSettings? settings1;
  CustomPageRoute({this.page, this.settings1})
      : super(
          settings: settings1,
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}
