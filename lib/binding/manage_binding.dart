import 'package:get/instance_manager.dart';
import 'package:meow/controller/manage_controller.dart';

class ManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MangeController());
  }
}
