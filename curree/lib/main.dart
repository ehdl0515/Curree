import 'package:curree/providers/filter_provider.dart';
import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'bottom_navigation_bar.dart';



void main() {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => GlobalStore()),
          ChangeNotifierProvider(create: (create) => FilterProvider(GlobalStore())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          theme: ThemeData(
            fontFamily: 'SUITE',
          ),
          home: const Scaffold(
            body: MyBottomNavigationBar(),
          ),
        ),
      ),
      );

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}




