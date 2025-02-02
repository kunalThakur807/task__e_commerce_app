import 'package:get/get.dart';
import '../models/product.dart';
import 'package:get_storage/get_storage.dart';
import 'product_controller.dart'; // Import ProductController

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  final box = GetStorage();
  final ProductController productController =
      Get.find<ProductController>(); // Get ProductController instance

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  void addToCart(Product product) {
    cartItems.add(product);
    saveCart();
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    saveCart();
  }

  void saveCart() {
    box.write(
        'cart', cartItems.map((e) => e.id).toList()); // Save only product IDs
  }

  double totalValue() {
    double total = 0.0;
    for (var element in cartItems) {
      total += element.price;
    }
    print(total);
    return total;
  }

  void loadCart() {
    List<dynamic>? storedCart = box.read<List<dynamic>>('cart');
    if (storedCart != null) {
      cartItems.assignAll(storedCart.map((id) => productController.productsData
          .firstWhere((p) => p.id == id,
              orElse: () => Product(
                  id: 0,
                  title: "Unknown",
                  description: "N/A",
                  image: "",
                  price: 0.0,
                  category: null,
                  rating: Rating(rate: 1, count: 1)))));
    }
  }
}
