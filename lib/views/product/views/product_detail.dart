import 'package:app_task/utils/constants/constants.dart';
import 'package:app_task/utils/responsive.dart';
import 'package:app_task/views/components/custom_modal_bottom_sheet.dart';
import 'package:app_task/views/components/product/product_card.dart';
import 'package:app_task/views/components/review_card.dart';
import 'package:app_task/views/product/views/components/cart_button.dart';
import 'package:app_task/views/product/views/components/product_images.dart';
import 'package:app_task/views/product/views/components/product_info.dart';
import 'package:app_task/views/product/views/components/product_list_tile.dart';
import 'package:app_task/views/product/views/product_buy_now_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product? product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CartButton(
        price: product?.price,
        press: () {
          customModalBottomSheet(
            context,
            height: MediaQuery.of(context).size.height * 0.92,
            child: ProductBuyNowScreen(
              product: product!,
            ),
          );
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProductImages(
              images: [product?.image, product?.image, product?.image],
            ),
            ProductInfo(
              brand: "${product?.category}",
              title: "${product?.title}",
              isAvailable: true,
              description: "${product?.description}",
              rating: product?.rating.rate,
              numOfReviews: 126,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Product.svg",
              title: "Product Details",
              press: () {},
            ),
            ProductListTile(
              svgSrc: "assets/icons/Delivery.svg",
              title: "Shipping Information",
              press: () {},
            ),
            ProductListTile(
              svgSrc: "assets/icons/Return.svg",
              title: "Returns",
              isShowBottomBorder: true,
              press: () {},
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ReviewCard(
                  rating: product?.rating.rate,
                  numOfReviews: product?.rating.count,
                  numOfFiveStar: 80,
                  numOfFourStar: 30,
                  numOfThreeStar: 5,
                  numOfTwoStar: 4,
                  numOfOneStar: 1,
                ),
              ),
            ),
            ProductListTile(
              svgSrc: "assets/icons/Chat.svg",
              title: "Reviews",
              isShowBottomBorder: true,
              press: () {
                // Navigator.pushNamed(context, productReviewsScreenRoute);
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: Responsive.isDesktop(context) ? 275 : 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == 4 ? defaultPadding : 0),
                    child: ProductCard(
                      image: product?.image,
                      title: "Sleeveless Tiered Dobby Swing Dress",
                      brandName: "LIPSY LONDON",
                      price: 24.65,
                      priceAfetDiscount: index.isEven ? 20.99 : null,
                      dicountpercent: index.isEven ? 25 : null,
                      press: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
