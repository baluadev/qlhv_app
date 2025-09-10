import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qlhv_app/detail_screen.dart';
import 'package:qlhv_app/home.dart';
import 'package:qlhv_app/login.dart';
import 'package:qlhv_app/models/user_model.dart';
import 'package:qlhv_app/services/local_store.dart';

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

    return MaterialApp(
      navigatorKey: NavigationService.inst.rootNavigatorKey,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', ''), // Tiếng Việt
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LocalStore.inst.getUser() != null ? '/home' : '/login',
      routes: <String, WidgetBuilder>{
        '/login': (_) => LoginScreen(userModel: userModel),
        '/home': (_) => const HomeScreen(),
        '/detail': (_) => const DetailScreen(),
      },
    );
  }
}
