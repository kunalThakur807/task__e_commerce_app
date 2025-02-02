import 'package:app_task/controllers/cart_controller.dart';
import 'package:app_task/controllers/product_controller.dart';
import 'package:app_task/controllers/websocket_controller.dart';
import 'package:get/get.dart';

void registerControllers() {
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(WebSocketController());
}
