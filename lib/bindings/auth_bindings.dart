import 'package:get/get.dart';
import 'package:ticketerorganisers/controller/authController.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  
  }
}