import 'package:bookstore/features/pages/Homepage.pages.dart';
import 'package:bookstore/features/service/addProduct.provider.dart';
import 'package:bookstore/features/service/productDelete.provider.dart';
import 'package:bookstore/features/service/productGet.provider.dart';
import 'package:bookstore/features/service/updateProduct.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GetAppProductProvider()),
          ChangeNotifierProvider(create: (_) => ProductDeleteProvider()),
          ChangeNotifierProvider(create: (_) => AddProductProvider()),
          ChangeNotifierProvider(create: (_) => UpdateProductProvider()),
        ],
        builder: (context, child) {
          // Add the 'child' parameter
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              useMaterial3: true,
            ),
            home: const Homepage(),
          );
        });
  }
}
