import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:flutter_application_1/beans/data.dart';
import 'package:flutter_application_1/pages/browser/page_a.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //計數參數
  int _counter = 0;
  void reset() {
    setState(() {
       _counter=0;
    });
  }

  //點擊按鈕計數
  void _incrementCounter() {
    setState(() {
        if(_counter<5){
          _counter++;
        }
    });
  }
  //建立按鈕三態
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
    //是否超過次數
    bool isOver = _counter>4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isOver?Colors.red:Theme.of(context).colorScheme.inversePrimary,
        title: Text(isOver?'Complete':widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<DataModel>(builder: (context, value, child) => 
            Text(
              'You have pushed the button this many times:',
              //顏色會於頁面跳轉返回後改變
              style: TextStyle(fontSize: 30,color:value.getColor()),
            )),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: isOver ? null: _incrementCounter,
            child: const Icon(Icons.add)
            )
            ,
          const SizedBox(width: 20)
          ,
          FloatingActionButton(
            onPressed: isOver ? reset : null,
            child: const Icon(Icons.refresh)
            )
            ,
          const SizedBox(width: 20)
          ,
          TextButton (
            style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
            onPressed: () {
              //下一頁須知道共享資料，故啟動頁面需進行消費
              Navigator.push(context,MaterialPageRoute(builder:(context) {
                return Consumer(builder:(context, value, child) => const PageA());
              },));
            },
            child: const Text('前往下一頁',)
            )
          ]
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
