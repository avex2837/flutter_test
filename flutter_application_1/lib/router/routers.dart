import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/preview.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: "首頁"),
      routes: [
        GoRoute(
          name: "preview",
          path: "preview",
          builder: (BuildContext context, GoRouterState state) {
            return const PreviewPage();
          },),
      ]
    ),
  ],
);