import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meow/model/category.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../../data/constant.dart';
import '../../../utils/utils.dart';

class ProductCategoryManagement extends StatefulWidget {
  final Category? category;
  const ProductCategoryManagement(this.category, {Key? key}) : super(key: key);

  @override
  State<ProductCategoryManagement> createState() =>
      _ProductCategoryManagementState();
}

class _ProductCategoryManagementState extends State<ProductCategoryManagement> {
  late Input input;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.find();

  @override
  void initState() {
    input = Input(input: {
      "name": TextEditingController()..text = widget.category?.name ?? "",
      "image": TextEditingController()..text = widget.category?.image ?? "",
    });
    homeController.setSelectedMainID(widget.category?.mainId ?? "");
    super.initState();
  }

  @override
  void dispose() {
    homeController.setSelectedMainID("");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Manage Categories",
          style: appBarTitleStyle,
        )),
        actions: [
          if (!(widget.category == null)) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: homeIndicatorColor,
                ),
                child: Text("Delete"),
                onPressed: () =>
                    _homeController.deleteCategory(widget.category?.id ?? ""),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: homeIndicatorColor,
              ),
              child: Text("Save"),
              onPressed: () => _homeController.addCategory(
                Category(
                  name: input.input["name"]?.value.text ?? "",
                  image: input.input["image"]?.value.text ?? "",
                  id: widget.category?.id ?? Uuid().v1(),
                  mainId: homeController.selectedMainID.value,
                  dateTime: DateTime.now(),
                ),
              ),
            ),
          ),
        ],
        elevation: 5,
        backgroundColor: detailBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: homeController.mainCategories.length,
                  itemBuilder: (context, index) {
                    final item = homeController.mainCategories[index];

                    return Obx(() {
                      final isSelected =
                          item.id == homeController.selectedMainID.value;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:
                                  isSelected ? homeIndicatorColor : Colors.grey,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              )),
                          onPressed: () =>
                              homeController.setSelectedMainID(item.id),
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Hint Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: input.input.values.first,
                    keyboardType: TextInputType.text,
                    validator: input.validateInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            //Description
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Hint Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Image",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: input.input["image"],
                    keyboardType: TextInputType.text,
                    validator: input.validateInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
