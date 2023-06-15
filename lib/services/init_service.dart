import 'package:get_storage/get_storage.dart';

class InitService {
  static Future<void> initApp() async {
    await _initGetStorage();
  }

  static Future<void> _initGetStorage() async {
    await GetStorage.init();
  }
}
