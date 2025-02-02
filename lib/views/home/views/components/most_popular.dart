import 'package:app_task/controllers/product_controller.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:app_task/views/components/product/secondary_product_card.dart';
import 'package:app_task/views/components/skleton/product/secondery_produts_skelton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/constants.dart';

class MostPopular extends GetView<ProductController> {
  const MostPopular({
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
            "Most popular",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // SeconderyProductsSkelton(),
        Obx(() {
          return controller.isLoading.value
              ? SeconderyProductsSkelton()
              : SizedBox(
                  height: Responsive.isDesktop(context) ? 150 : 114,
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
                      child: SecondaryProductCard(
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
      ],
    );
  }
}
