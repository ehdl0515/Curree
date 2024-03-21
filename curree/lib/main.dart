import 'package:curree/providers/filter_provider.dart';
import 'package:curree/providers/logger_provider.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:curree/providers/rate_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bottom_navigation_bar.dart';



void main() {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final loggerProvider = LoggerProvider();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: loggerProvider),
          ChangeNotifierProvider(create: (create) => RateProvider()),
          ChangeNotifierProvider(create: (create) => SettingProvider()),
          ChangeNotifierProvider(create: (create) => FilterProvider()),
        ],
        child: const MyApp(),
      ),
      );

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final logger = Provider.of<LoggerProvider>(context).logger;
    if (kDebugMode) {
      logger.d('Curree 앱을 시작합니다.');
      logger.d(DateTime.timestamp());
      logger.d("디버그 모드입니다.");
    } else if (kReleaseMode) {
      logger.d("릴리즈 모드입니다.");
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        fontFamily: 'SUITE',
      ),
      home: const Scaffold(
        body: MyBottomNavigationBar(),
      ),
    );
  }
}
