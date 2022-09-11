import 'package:get/get.dart';
import 'package:meow/controller/home_controller.dart';
import 'package:meow/model/advertisement.dart';
import 'package:meow/service/database.dart';
import 'package:meow/widgets/show_loading/show_loading.dart';

import '../../../data/constant.dart';

class AdvertisementController extends GetxController {
  final Advertisement? advertisement;
  final _database = Database();
  AdvertisementController(this.advertisement);
  HomeController _homeController = Get.find();
  RxMap<String, String> advertisementProductMap = <String, String>{}.obs;
  var currentCategory = "All".obs;

  @override
  void onInit() {
    if (!(advertisement == null)) {
      //If advertisement is not null,we need to
      //search and add the products which include in this advertisement
      _homeController.items.forEach((element) {
        if (element.id == advertisement?.id) {
          advertisementProductMap.putIfAbsent(element.id, () => element.id);
        }
      });
    }
    super.onInit();
  }

  void changeCategory(String value) {
    currentCategory.value = value;
  }

  void addOrRemove(String productID) {
    if (advertisementProductMap.containsKey(productID)) {
      advertisementProductMap.remove(productID);
    } else {
      advertisementProductMap.putIfAbsent(productID, () => productID);
    }
  }

  Future<void> deleteAdvertisement(String id) async {
    showLoading();
    await _database.delete(advertisementCollection, path: id);
    hideLoading();
    Get.back();
  }

  Future<void> saveAdvertisement(Advertisement advertisement) async {
    showLoading();
    await _database.write(advertisementCollection,
        data: advertisement.toJson(), path: advertisement.id);
    hideLoading();
    Get.back();
  }
}
