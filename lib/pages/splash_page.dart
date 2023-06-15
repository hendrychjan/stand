import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand/pages/main_page.dart';
import 'package:stand/services/init_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _runAppInit() async {
    await InitService.initApp();

    Get.offAll(() => const MainPage());
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _runAppInit);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
