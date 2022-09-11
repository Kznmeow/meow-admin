import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:meow/widgets/home/sublist_widget.dart';

import '../../controller/home_controller.dart';
import '../../model/category.dart';
import '../../screen/view/home.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({
    Key? key,
    required this.controller,
    required this.size,
  }) : super(key: key);

  final HomeController controller;
  final Size size;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  late List<List<Category>> subCategories =
      widget.controller.getSubCategories();
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0);
    scrollController.addListener(() {
      var currentIndex = (scrollController.offset / widget.size.width).round();
      widget.controller.setCategoriesIndex = currentIndex;
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) //Right Scroll
      {
        if (widget.controller.categoriesIndex.value != 0 &&
            currentIndex != widget.controller.categoriesIndex.value) {
          widget.controller.setCategoriesIndex =
              widget.controller.categoriesIndex.value - 1;
        }
      } else {
        //Left Scroll
        if (!(widget.controller.categoriesIndex.value ==
                subCategories.length - 1) &&
            currentIndex != widget.controller.categoriesIndex.value) {
          //if not last index && not previous index because this listener
          //notify more than 1
          widget.controller.setCategoriesIndex =
              widget.controller.categoriesIndex.value + 1;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Column(
          children: [
            //Horizontal ListView
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final subList = subCategories[index];
                  return IndividualCategory(
                    size: widget.size,
                    list: subList,
                  );
                },
              ),
            ),
            //Indicator
            SizedBox(
              height: 8,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          )),
                      height: 8,
                      width: (40 * subCategories.length) + 0.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: subCategories.length,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          final isActive =
                              index == widget.controller.categoriesIndex.value;
                          return AnimatedContainer(
                            decoration: BoxDecoration(
                                color: isActive
                                    ? Colours.goldenRod
                                    : Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 500),
                            height: 8,
                            width: 40,
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
