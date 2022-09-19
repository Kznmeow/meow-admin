import 'package:get/get.dart';
import 'package:meow/screen/main_category/controller/main_category_controller.dart';

class MainCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainCategoryController());
  }
}
