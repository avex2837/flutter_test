import 'package:flutter/material.dart';
import 'package:flutter_application_1/https/http_service.dart';
import 'package:flutter_application_1/mvvm/view_model/hom_view_model.dart';
import 'package:flutter_application_1/router/routers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  //建立URL策略，用以移除頁出現http://localhost:5654/#/的#字hash
  setUrlStrategy(PathUrlStrategy());
  HttpService service = HttpService.instance;
  service.initDio();
  //啟動(預設使用MultiProvider 去包，預備之後可能須多個共用ViewModel)
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeViewModel())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //印出當前觸發build的Widget資訊
    debugPrint(context.toString());
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      routerConfig: router,
    );
  }
}
