import 'package:app_task/controllers/product_controller.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:app_task/views/components/Banner/M/banner_m_with_counter.dart';
import 'package:app_task/views/components/product/product_card.dart';
import 'package:app_task/views/components/skleton/product/products_skelton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/constants.dart';

class FlashSale extends GetView<ProductController> {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading show 👇
        // const BannerMWithCounterSkelton(),
        BannerMWithCounter(
          duration: const Duration(hours: 8),
          text: "Super Flash Sale \n50% Off",
          press: () {},
        ),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Flash sale",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading show 👇
        // const

        Obx(() {
          return controller.isLoading.value
              ? ProductsSkelton()
              : SizedBox(
                  height: Responsive.isDesktop(context) ? 300 : 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Find demoFlashSaleProducts on models/ProductModel.dart
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
        })
      ],
    );
  }
}
