import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/allmodules.dart';
import 'package:multimodule/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home:HomePage(),
      home:Allmodules(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

