import 'package:flutter/material.dart';
import 'package:stand/getx/app_controller.dart';
import 'package:get/get.dart';
import 'package:stand/pages/splash_page.dart';
import 'package:stand/theme/main_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  Get.put(AppController());

  runApp(
    GetMaterialApp(
      title: 'Stand',
      home: const SplashPage(),
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}
