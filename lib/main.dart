import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stand/getx/app_controller.dart';
import 'package:get/get.dart';
import 'package:stand/pages/splash_page.dart';

void main() {
  Get.put(AppController());

  runApp(GetMaterialApp(
    title: 'Stand',
    home: const SplashPage(),
    theme: ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 255, 183, 138),
        secondary: Color.fromARGB(255, 163, 195, 255),
      ),
      useMaterial3: true,
    ),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'), // English
      Locale('cs'), // Czech
    ],
  ));
}
