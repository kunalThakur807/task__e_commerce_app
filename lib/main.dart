import 'package:app_task/theme/app_theme.dart';
import 'package:app_task/utils/utils.dart';
import 'package:app_task/views/auth/views/login_screen.dart';
import 'package:app_task/views/home/views/home_screen.dart';
import 'package:app_task/views/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'views/product/views/product_detail.dart';
import 'views/cart/cart_page.dart';
import 'views/chat/chat_page.dart';

void main() {
  registerControllers();
  setPathUrlStrategy();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,

      initialRoute: '/',
      // Apply bindings
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/productDetail/:id', page: () => ProductDetailPage()),
        GetPage(name: '/cart', page: () => CartPage()),
        GetPage(name: '/chat', page: () => ChatPage()),
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
      ],
    );
  }
}
