import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meow/data/constant.dart';
import 'package:meow/model/main_category.dart';
import 'package:meow/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

class MainCategoryController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required.";
    } else {
      return null;
    }
  }

  Future<void> addCategory() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    showLoading();
    try {
      final mainCategory = MainCategory(
        id: Uuid().v1(),
        name: nameController.text,
        dateTime: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection(mainCategoryCollection)
          .doc(mainCategory.id)
          .set(mainCategory.toJson());
      nameController.clear();
    } catch (e) {
      Get.snackbar("Failed!", "Try again.");
    }
    hideLoading();
  }

  Future<void> delete(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(mainCategoryCollection)
          .doc(id)
          .delete();
    } catch (e) {
      Get.snackbar("Failed!", "Try again.");
    }
  }
}
