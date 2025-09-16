import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qlhv_app/add_profile_screen.dart';
import 'package:qlhv_app/detail_screen.dart';
import 'package:qlhv_app/home.dart';
import 'package:qlhv_app/login.dart';
import 'package:qlhv_app/models/user_model.dart';
import 'package:qlhv_app/services/local_store.dart';

import 'configs/app_routes.dart';
import 'configs/themes.dart';
import 'helper/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStore.inst.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel();
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: NavigationService.inst.rootNavigatorKey,
          title: 'GVQL',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', ''), // Tiếng Việt
          ],
          theme: AppThemes.lightTheme,
          initialRoute: AppRoutes.root,
          onGenerateRoute: AppRoutes().onGenerateRoute,
        );
      },
    );
  }
}
