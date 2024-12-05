import 'package:video_player/controllers/setting_controller.dart';
import 'package:video_player/controllers/home_controller.dart';
import 'package:get/get.dart';

class AllBindings {
  Future<void> allBindingInitialize() async {
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
