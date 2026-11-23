import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:materisqflite/app_binding.dart';
import 'package:materisqflite/presentation/pages/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Materi SqfLite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: HomeScreen.new, binding: AppBinding()),
      ],
    );
  }
}
