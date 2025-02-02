import 'package:app_task/utils/constants/constants.dart';
import 'package:app_task/controllers/product_controller.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:app_task/views/components/product/product_card.dart';
import 'package:app_task/views/components/skleton/product/products_skelton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BestSellers extends GetView<ProductController> {
  const BestSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Best sellers",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Obx(() {
          return controller.isLoading.value
              ? ProductsSkelton()
              : SizedBox(
                  height: Responsive.isDesktop(context) ? 300 : 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.productsData.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == controller.productsData.length - 1
                            ? defaultPadding
                            : 0,
                      ),
                      child: ProductCard(
                        image: controller.productsData[index].image,
                        brandName: controller.productsData[index].category,
                        title: controller.productsData[index].title,
                        price: controller.productsData[index].price,
                        priceAfetDiscount: controller.productsData[index].price,
                        dicountpercent: controller.productsData[index].price,
                        press: () {
                          Get.toNamed(
                              '/productDetail/${"${controller.productsData[index].title}".replaceAll(" ", "")}',
                              arguments: controller.productsData[index]);
                        },
                      ),
                    ),
                  ),
                );
        }),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
