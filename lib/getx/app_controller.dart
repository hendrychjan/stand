import 'package:get/get.dart';
import 'package:stand/services/hive_service.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  late HiveService hiveService;

  AppController() {
    hiveService = HiveService();
  }
}
