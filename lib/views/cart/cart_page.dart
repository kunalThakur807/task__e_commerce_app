import 'package:app_task/utils/constants/constants.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:app_task/views/components/product/secondary_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Checkout"),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Cart',
              style: Responsive.isDesktop(context)
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleSmall)),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Obx(() {
            return controller.cartItems.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/shopping.png",
                          height: 200,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Empty Cart",
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.titleMedium
                              : Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  )
                : CartBody(controller: controller, size: size);
          })),
    );
  }
}

class CartBody extends StatelessWidget {
  const CartBody({
    super.key,
    required this.controller,
    required this.size,
  });

  final CartController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Review your order',
              style: Responsive.isDesktop(context)
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleSmall),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                var product = controller.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SecondaryProductCard(
                    image: controller.cartItems[index].image,
                    brandName: controller.cartItems[index].category,
                    title: controller.cartItems[index].title,
                    price: controller.cartItems[index].price,
                    priceAfetDiscount: controller.cartItems[index].price,
                    dicountpercent: controller.cartItems[index].price,
                    isCart: true,
                    remove: () {
                      controller.removeFromCart(product);
                    },
                    press: () {
                      // Get.toNamed(
                      //     '/productDetail/${"${controller.cartItems[index].title}".replaceAll(" ", "")}',
                      //     arguments: controller.productsData[index]);
                    },
                  ),
                );
              },
            );
          }),
          const SizedBox(
            height: 8,
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                minimumSize: const Size(120, 200),
                maximumSize: Size(size.width, 200),
                padding: const EdgeInsets.all(8)),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary',
                      style: Responsive.isDesktop(context)
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SubTotal',
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.bodySmall),
                      Obx(() {
                        return Text('\$${controller.totalValue()}',
                            style: Responsive.isDesktop(context)
                                ? Theme.of(context).textTheme.titleMedium
                                : Theme.of(context).textTheme.titleSmall);
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping Fee',
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.bodySmall),
                      Text('Free',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Responsive.isDesktop(context)
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize
                                  : Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .fontSize)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total(include of VAT)',
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.bodySmall),
                      Obx(() {
                        return Text('\$${controller.totalValue() + 1}',
                            style: Responsive.isDesktop(context)
                                ? Theme.of(context).textTheme.titleMedium
                                : Theme.of(context).textTheme.titleSmall);
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimated VAT',
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context).textTheme.bodySmall),
                      Text('\$1',
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.titleMedium
                              : Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
