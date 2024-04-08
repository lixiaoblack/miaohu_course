import 'package:miaohu_course/pages/index.dart';
import 'package:get/get.dart';

/// 主界面依赖
class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
