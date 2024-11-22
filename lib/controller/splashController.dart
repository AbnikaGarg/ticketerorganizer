import 'dart:async';
import 'package:get/get.dart';

import '../service/shared_pref.dart';
import '../utils/app_images.dart';
import '../view/home/Selectprofile.dart';

class SplashController extends GetxController {
  SplashController();
  final image = Images.logo;

  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 2), () {
      if (PreferenceUtils.isLoggedIn()) {
        final rawJson = PreferenceUtils.getString('vendorProfile') ?? '';

        if (rawJson != '') {
          Get.offAllNamed("/");
        } else {
          Get.offAll(SelectProfilePage());
        }
      } else {
        Get.offAllNamed("/login");
      }
    });
  }
}
