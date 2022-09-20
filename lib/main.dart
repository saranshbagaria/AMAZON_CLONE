import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/features/auth/Screens/auth_screen.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './constants/global_variable.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (create)=> UserProvider(), 
        ),
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: (settings) => genrateRoute(settings),
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )
        ),
        primarySwatch: Colors.blue,
      ),
      home:   Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
        ),
        body: Column(
          children:  [
             const Center(
              child: Text(
                'Flutter Demo Home Page'
              ),
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                    onPressed: () => {
                        Navigator.pushNamed(context, AuthScreen.routeName)
                    },
                    child: const Text('click'));
              }
            )
          ],
        ),
      )
    );
  }
}
