import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meow/data/constant.dart';
import 'package:meow/model/category.dart';
import 'package:meow/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/home_controller.dart';
import '../../model/status.dart';
import '../../widgets/button/button.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Input input = Input(input: {
    "status": TextEditingController(),
  });

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Center(
              child: Text(
            "Status အုပ်စုများ",
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
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Container(
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: input.input.values.first,
                          validator: input.validateInput,
                          decoration: InputDecoration(
                            //hintText: ,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      ExButton(
                        color: homeIndicatorColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        label: "Add",
                        height: 36.0,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _homeController.addStatus(
                              Status(
                                name: input.input.values.first.text,
                                id: Uuid().v1(),
                                dateTime: DateTime.now(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (_homeController.categories.isEmpty) {
                      return const Center(
                          child: Text(
                        "No status yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: _homeController.statusList.length,
                      itemBuilder: (context, index) {
                        var cate = _homeController.statusList[index];

                        return InkWell(
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Text(cate.name),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      _homeController.deleteStatus(cate.id);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ),
                                ],
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
        ));
  }
}
