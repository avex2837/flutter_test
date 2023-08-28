import 'package:flutter/material.dart';
import 'package:flutter_application_1/beans/data.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:provider/provider.dart';
void main() {
  //
  runApp(ChangeNotifierProvider(
    create: (context) =>DataModel(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
    ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


