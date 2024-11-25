import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/cart.dart';
import 'model/product_list.dart';
import 'model/order.dart';
import 'model/auth.dart';
import 'utils/app_routes.dart';
import 'pages/products_overview_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/cart_page.dart';
import 'pages/product_form_page.dart';
import 'pages/auth_screen.dart';
import 'pages/orders_page.dart';
import 'pages/product_manager_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductList()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Minha Loja',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                  primary: Colors.pink,
                  secondary: Colors.orangeAccent,
                ),
          ),
          home: auth.isAuth ? ProductsOverviewPage() : AuthScreen(),
          routes: {
            AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
            AppRoutes.PRODUCT_FORM: (ctx) => ProductFormPage(),
            AppRoutes.CART: (ctx) => CartPage(),
            AppRoutes.AUTH: (ctx) => AuthScreen(),
            AppRoutes.ORDERS: (ctx) => OrdersPage(),
            AppRoutes.PRODUCT_MANAGER: (ctx) => ProductManagerPage(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
