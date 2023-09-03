import 'package:flutter/material.dart';
import 'package:flutter_application_1/beans/data.dart';
import 'package:flutter_application_1/router/routers.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context) =>DataModel(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //印出當前觸發build的Widget資訊
    print(context.toString());
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true),
      routerConfig: router,
    );
  }
}


