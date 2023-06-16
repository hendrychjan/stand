import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stand/getx/app_controller.dart';

class InitService {
  static Future<void> initApp() async {
    await _initGetStorage();
    await _initHive();
  }

  static Future<void> _initGetStorage() async {
    await GetStorage.init();
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter();
    await AppController.to.hiveService.init();
  }
}
