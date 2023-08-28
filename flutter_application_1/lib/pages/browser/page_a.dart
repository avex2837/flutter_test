import 'package:flutter/material.dart';
import 'package:flutter_application_1/beans/data.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:provider/provider.dart';

class PageA extends StatelessWidget{
  const PageA({super.key});

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

  return Scaffold(
    body: const Center(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '我是第二個頁面',
              style: TextStyle(fontSize: 30,color:Colors.black,),
            )
          ]
      )),
    floatingActionButton: Consumer<DataModel>(
      builder: (context, value, child) => TextButton (
        style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
        onPressed: () {
          //設定前頁共享的ColorModel
          value.setColor("#FFB7DD");
          //返回上一頁
          Navigator.pop(context);
        },
        child: const Text('返回上一頁'))
        )
    );
  }
}

