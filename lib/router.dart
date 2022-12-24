import 'package:amazon_clone/common/widget/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/product.dart';
import 'package:amazon_clone/features/auth/Screens/auth_screen.dart';
import 'package:amazon_clone/features/home/Screens/category_deal_screen.dart';
import 'package:amazon_clone/features/home/Screens/home_screen.dart';
import 'package:amazon_clone/features/home/features/product_detail/product_detail_screen.dart';
import 'package:amazon_clone/features/home/features/search.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomBar(),
      );
    case ProductDetailScreen.routeName:
      Product product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case CategoryDealScreen.routeName:
      String category = routeSettings.arguments.toString();
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(category: category),
      );
    case SearchScreen.routeName:
      String searchQuery = routeSettings.arguments.toString();
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}
