
import 'package:amazon_clone/features/auth/Screens/auth_screen.dart';
import 'package:amazon_clone/features/home/Screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name){
    case AuthScreen.routeName :
      return MaterialPageRoute(builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName :
      return MaterialPageRoute(builder: (_) => const HomeScreen(),
      );
    default: 
      return MaterialPageRoute(builder: (_) => const Scaffold(
        body: Center(
          child: Text('Screen does not exist'),
        ),
      ),
      );
  }
}