import 'package:get/instance_manager.dart';
import 'package:meow/controller/upload_controller.dart';

class UploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadController());
  }
}
