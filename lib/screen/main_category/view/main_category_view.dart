import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:meow/controller/home_controller.dart';
import 'package:meow/data/constant.dart';
import 'package:meow/utils/utils.dart';

import '../controller/main_category_controller.dart';

class MainCategoryView extends StatelessWidget {
  const MainCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final MainCategoryController mainController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Center(
            child: Text(
          "Main Categories",
          style: appBarTitleStyle,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          top: 20,
        ),
        child: Form(
          key: mainController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /**Form*/
              TextFormField(
                controller: mainController.nameController,
                validator: mainController.validator,
                maxLines: 1,
                decoration: const InputDecoration(
                  counter: null,
                  counterText: "",
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: homeIndicatorColor,
                ),
                onPressed: () => mainController.addCategory(),
                child: const Text("Save"),
              ),
              const SizedBox(height: 15),
              /**Advertisement List*/
              Expanded(
                child: Obx(
                  () {
                    if (homeController.mainCategories.isEmpty) {
                      return const Center(
                          child: Text(
                        "No main categories yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: homeController.mainCategories.length,
                      itemBuilder: (context, index) {
                        var advertisement =
                            homeController.mainCategories[index];

                        return SwipeActionCell(
                          key: ValueKey(advertisement.id),
                          trailingActions: [
                            SwipeAction(
                              onTap: (CompletionHandler _) async {
                                await _(true);
                                await mainController.delete(advertisement.id);
                              },
                              content: Container(
                                color: Colors.red,
                                height: 35,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "DELETE",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ],
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                advertisement.name,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
