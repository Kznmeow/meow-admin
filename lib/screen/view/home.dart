import 'package:cached_network_image/cached_network_image.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:meow/controller/home_controller.dart';
import 'package:meow/data/constant.dart';
import 'package:meow/data/mock.dart';
import 'package:meow/model/view_all_model.dart';
import 'package:meow/routes/routes.dart';
import 'package:meow/widgets/home_category.dart';
import 'package:meow/widgets/home_category_main.dart';
import 'package:meow/widgets/home_pickup.dart';
import 'package:meow/widgets/normal_product_widget.dart';
import 'package:meow/widgets/reward_product_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/category.dart';
import '../../widgets/home/categories_wiget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          //Category
          const HomeCategoryMain(),
          const SizedBox(
            height: 10,
          ),
          //Advertisement
          Obx(() {
            return controller.slideLoading1.value
                ? const LoadingWidget()
                : HomePickUp(
                    advertisementList: controller.advertisementList,
                    showShopButton: true,
                  );
          }),
          const SizedBox(
            height: 10,
          ),
          //Categories
          CategoriesWidget(controller: controller, size: size),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            return controller.slideLoading2.value
                ? const LoadingWidget()
                : HomePickUp(
                    advertisementList: controller.advertisementList2,
                    showShopButton: false,
                  );
          }),
          Obx(() {
            return controller.statusLoading.value
                ? const LoadingWidget()
                : controller.statusList.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.statusList.length,
                        itemBuilder: (context, index) {
                          final sta = controller.statusList[index];
                          final products = controller.items
                              .where((element) => element.status == sta.name)
                              .toList();
                          if (products.isNotEmpty) {
                            if (products[0].status == forYou) {
                              //IF For You Status
                              return Card(
                                child: ListView(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Status Text
                                          Text(
                                            sta.name,
                                            style: GoogleFonts.bungeeInline(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),

                                          //See More
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {
                                                controller.setViewAllProducts(
                                                    ViewAllModel(
                                                        status: sta.name,
                                                        products: products));
                                                Get.toNamed(viewAllUrl);
                                              },
                                              child: const Text(
                                                "Show More",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.8,
                                      ),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: products.length,
                                      itemBuilder: (context, productIndex) {
                                        return NormalProductWidget(
                                          product: products[productIndex],
                                          padding: const EdgeInsets.all(10),
                                          isShopButton: false,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (!(products[0].requirePoint! > 0)) {
                              //If this products list is not reward list,how do we know reward list or not?
                              //we check first product's require point is greather than 0 then this is reward list,
                              //or not.
                              //OTHER WIDGET
                              return AspectRatio(
                                aspectRatio: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Status Text
                                              Text(
                                                sta.name,
                                                style: GoogleFonts.bungeeInline(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),

                                              //See More
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .setViewAllProducts(
                                                            ViewAllModel(
                                                                status:
                                                                    sta.name,
                                                                products:
                                                                    products));
                                                    Get.toNamed(viewAllUrl);
                                                  },
                                                  child: const Text(
                                                    "Show More",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: 2.35,
                                            ),
                                            /* separatorBuilder: (context, index) {
                                          return const SizedBox(width: 10);
                                        }, */
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: products.length,
                                            itemBuilder:
                                                (context, productIndex) {
                                              return NormalProductWidget(
                                                product: products[productIndex],
                                                isShopButton: true,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              //REWARD WIDGET
                              return AspectRatio(
                                aspectRatio: 16 / 13,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Status Text
                                              Text(
                                                sta.name,
                                                style: GoogleFonts.bungeeInline(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),

                                              //See More
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .setViewAllProducts(
                                                            ViewAllModel(
                                                                status:
                                                                    sta.name,
                                                                products:
                                                                    products));
                                                    Get.toNamed(viewAllUrl);
                                                  },
                                                  child: Text(
                                                    "View All",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: products.length,
                                            itemBuilder:
                                                (context, productIndex) {
                                              return RewardProductWidget(
                                                  product:
                                                      products[productIndex]);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    : const SizedBox();
          }),
          //const SizedBox(height: 100,),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
