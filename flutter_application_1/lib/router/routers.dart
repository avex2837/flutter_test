import 'package:flutter/material.dart';
import 'package:flutter_application_1/mvvm/view/error_screen.dart';
import 'package:flutter_application_1/mvvm/view/home/home_page.dart';
import 'package:flutter_application_1/mvvm/view/preview.dart';
import 'package:go_router/go_router.dart';
//建立全域路由器，定義頁面導向邏輯
final router = GoRouter(
  errorBuilder: (context, state) => const ErrorScreenPage(),
  //定義起點
  initialLocation: "/",
  routes: [
    GoRoute(
      //定義名稱，可使用goNamed的方式進行導向
      name: "home",
      //定義路徑，可使用go指定路徑方式進行導向
      path: '/',
      builder: (context, state) => const MyHomePage(title: "首頁"),
      routes: [
        GoRoute(
          //定義名稱，可使用goNamed的方式進行導向
          name: "preview",
          //定義路徑，可使用go指定路徑方式進行導向
          path: "preview",
          builder: (BuildContext context, GoRouterState state) {
            return const PreviewPage();
          },),
      ]
    ),
  ],
);