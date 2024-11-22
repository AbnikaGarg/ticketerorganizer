import 'package:get/get.dart';

import '../controller/splashController.dart';


class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  
  }
}