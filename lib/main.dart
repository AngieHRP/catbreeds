import 'package:catbreeds/splash.dart';
import 'package:flutter/material.dart';
import 'package:catbreeds/utils/constants.dart';

import 'app/app_settings.dart';
import 'app/application.dart';
import 'di/dependecy_injection.dart';

void main() {

  final AppSettings appSettings = AppSettings(
    url: Constants.url,
  );
  Application().appSettings = appSettings;
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'splash',
      routes: <String, WidgetBuilder>{
        'splash': (BuildContext context) => const SplashPage(),
      },
    );
  }
}

