import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/home_controller.dart';
import '../../model/category.dart';
import '../../model/view_all_model.dart';
import '../../routes/routes.dart';

class IndividualCategory extends StatelessWidget {
  const IndividualCategory({
    Key? key,
    required this.size,
    required this.list,
  }) : super(key: key);

  final List<Category> list;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return SizedBox(
      width: size.width,
      child: GridView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final element = list[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: size.width * 0.15,
                  child: InkWell(
                    onTap: () {
                      controller.setViewAllProducts(ViewAllModel(
                        status: "${element.name} Products",
                        products: controller.items
                            .where((e) => e.category == element.name)
                            .toList(),
                      ));
                      Get.toNamed(viewAllUrl);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Image
                        CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, status) {
                            return Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.yellow,
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          },
                          errorWidget: (context, url, whatever) {
                            return const Text("Image not available");
                          },
                          imageUrl: element.image ?? "",
                          imageBuilder: (context, provider) {
                            return CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade300,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: provider,
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 5),
                        //Name
                        Text(
                          element.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
