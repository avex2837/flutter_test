import 'package:flutter/material.dart';
import 'package:flutter_application_1/beans/data.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PreviewPage extends StatelessWidget{
  const PreviewPage({super.key});

//建立按鈕點擊事件
MaterialStateProperty<Color> createTextBtnBgColor() {
  return MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed)) { 
        return "#509cf6".toColor();
        } 
        else if (states.contains(MaterialState.disabled)) {
          return "#509cf6".toColor();
    }
    return "#FF208FF9".toColor(); 
  });
}  

@override
Widget build(BuildContext context) {
  print(context.toString());
  //取出前一頁帶入的資訊
  Map<String,dynamic> qparams = GoRouterState.of(context).uri.queryParameters;
  //取出前頁帶來的數量，決定列表的數量
  String query = qparams["query"];
  return Scaffold(
    body: Center(
      child:ListView.separated(
        itemBuilder:(BuildContext cotext,int index ){
          //index + 前頁帶過來的字串，做為顯示標題
          String displayValue = "$index $query";
          //回傳標題資訊
          return ListTile(title: Text(displayValue));
        }, 
        separatorBuilder:(context, index) => const Divider(color: Colors.blue), 
        itemCount: 100)),
    floatingActionButton: Consumer<DataModel>(
      builder: (context, value, child) => TextButton (
        style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
        onPressed: () {
          //設定前頁共享的ColorModel
          value.setColor("#FFB7DD");
          //返回上一頁
          context.go("/");
        },
        child: const Text('返回上一頁'))
        )
    );
  }
}

