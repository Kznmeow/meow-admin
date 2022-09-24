import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meow/model/product.dart';

import '../controller/home_controller.dart';
import '../routes/routes.dart';

class NormalProductWidget extends StatelessWidget {
  final Product product;
  final EdgeInsets? padding;
  final bool isShopButton;
  const NormalProductWidget({
    Key? key,
    required this.product,
    this.padding,
    required this.isShopButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find();
    return InkWell(
      onTap: isShopButton
          ? null
          : () {
              _homeController.setEditItem(product);
              Get.toNamed(detailScreen);
            },
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: product.photo1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.photo1,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* product.brandName!.isNotEmpty
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        product.brandName ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(), */
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2,
                          ),
                          child: Text(
                            "${product.price} Kyats",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isShopButton
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              _homeController.setEditItem(product);
                              Get.toNamed(detailScreen);
                            },
                            child: const Center(
                              child: Text("Shop Now"),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            //Tags
            Align(
              alignment: Alignment.topRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 150,
                  maxWidth: 150,
                ),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 2,
                    );
                  },
                  itemCount: product.tags.length,
                  itemBuilder: (context, index) {
                    final tag = product.tags[index];
                    return Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.all(3),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
