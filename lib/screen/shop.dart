// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../model/category.dart';
import '../model/view_all_model.dart';
import '../routes/routes.dart';

// ignore: camel_case_types
class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  final colorstheme = Color(0xff4b4b87);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Shop',
      //     style: TextStyle(fontSize: 20, color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   shadowColor: Colors.transparent,
      // ),
      body: CardWidget(),
    );
  }
}

class CardWidget extends StatefulWidget {
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  List data = [
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
  ];

  final colorwhite = Colors.white;

  final HomeController homeController = Get.find();

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: homeController.mainCategories.length,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorColor: homeIndicatorColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: _controller.mainCategories
                  .map((e) => Tab(
                        child: SizedBox(
                            width: 100,
                            child: Text(
                              e.name,
                              style: const TextStyle(fontSize: 16),
                            )),
                      ))
                  .toList()),
        ),
        body: TabBarView(
            controller: _tabController,
            children: homeController.mainCategories
                .map((e) =>
                    subCategory(_controller.getSubcategoryByMainId(e.id)))
                .toList()),
      ),
    );
  }
}

Widget subCategory(List<Category> list) {
  final HomeController _controller = Get.find();
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GridView.builder(
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 7,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final cate = list[index];
        return InkWell(
          onTap: () {
            _controller.setViewAllProducts(ViewAllModel(
              status: "${cate.name}",
              products: _controller.items
                  .where((e) => e.category == cate.name)
                  .toList(),
            ));
            Get.toNamed(viewAllUrl);
          },
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  color: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: CachedNetworkImage(
                      height: 110,
                      width: 180,
                      imageUrl: cate.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      cate.name,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(left: 20, top: 20),
                //         child: Text(
                //           cate.name,
                //           style: TextStyle(color: Colors.black, fontSize: 20),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //     alignment: Alignment.bottomRight,
                //     padding: EdgeInsets.only(right:10),
                //     child: Column(
                //       children: [
                //         cate.image!.isNotEmpty ?
                //         CachedNetworkImage(
                //           imageUrl: cate.image!,
                //           width: 90,
                //           height: 100,
                //           fit: BoxFit.cover,
                //         ) : const SizedBox(),
                //       ],
                //     ))
              ],
            ),
          ),
        );
      },
    ),
  );
}
