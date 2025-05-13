import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/allmodules.dart';

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
      // home:AllHm2(),
      // home:AllHmes(),
      // home:AllHmes3(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

