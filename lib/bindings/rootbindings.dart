import 'package:get/get.dart';
import '../controller/homepageController.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController());
    
  
  }
}