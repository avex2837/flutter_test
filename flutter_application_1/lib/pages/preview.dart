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
  //印出當前觸發build的Widget資訊
  print(context.toString());
  //取出前一頁帶入的資訊
  Map<String,dynamic> qparams = GoRouterState.of(context).uri.queryParameters;
  //取出前頁帶來的數量，決定列表的數量
  String query = qparams.containsKey("query") ? qparams["query"] : "";
  return Scaffold(
    body: Center(
      //建立列表widget
      child:ListView.separated(
        //指定簡單的標題容器作為
        itemBuilder:(BuildContext cotext,int index ){
          //index + 前頁帶過來的字串，做為顯示標題
          int num = index+1;
          //回傳標題資訊
          return ListTile(
            //項目圖片
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.numbers),
                Text(
                  "$num",
                  style: const TextStyle(fontSize: 20),)
              ],),
            // //項目背景
            // tileColor: index%2==0?Colors.amber:Colors.purple,
            //項目文字主標題
            title: const Text(
              "我是標題",
              style:TextStyle(
                color: Colors.blue)),
            //項目文字次標題
            subtitle: Text(
              query,
              style:const TextStyle(
                color: Colors.red)),
          );
        }, 
        //定義每個item的分隔器
        separatorBuilder:(context, index) => const Divider(color: Colors.blue), 
        //指定數量100筆
        itemCount: 100)),
    floatingActionButton: Consumer<DataModel>(
      builder: (context, value, child) => TextButton (
        style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
        onPressed: () {
          //設定前頁共享的ColorModel
          value.setColor("#FFB7DD");
          //返回上一頁
          context.goNamed("home");
        },
        child: const Text('返回上一頁'))
        )
    );
  }
}

