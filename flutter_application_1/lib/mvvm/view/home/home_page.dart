import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:flutter_application_1/mvvm/viewModel/prew_view_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  
  
  @override
  State createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
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
    print(context.toString());
       //取出共享viewModel
    ViewModel viewModel = Provider.of<ViewModel>(context);
    //是否超過次數
    bool isOver = viewModel.getCount()>4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isOver?Colors.red:Theme.of(context).colorScheme.inversePrimary,
        title: Text(isOver?'Complete':widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ViewModel>(builder: (context, value, child) => 
            Text(
              'You have pushed the button this many times:',
              //顏色會於頁面跳轉返回後改變
              style: TextStyle(fontSize: 30,color:value.getColor()),
            )),
            Text(
              viewModel.getCount().toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "counter",
            onPressed: isOver ? null: (){
              viewModel.increaseCount();
            },
            child: const Icon(Icons.add)
            )
            ,
          const SizedBox(width: 20)
          ,
          FloatingActionButton(
            heroTag: "reset",
            onPressed: isOver ? (){
              viewModel.resetCount();
            } : null,
            child: const Icon(Icons.refresh)
            )
            ,
          const SizedBox(width: 20)
          ,
          TextButton (
            style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
            onPressed: () {
              //下一頁須知道共享資料，故啟動頁面需進行消費
              context.goNamed("preview",queryParameters: {"query":"flucter 好麻煩"});
              // context.go("/preview?query=flucter 好麻煩");
            },
            child: const Text('前往下一頁',)
            )
          ]
      ), 
    );
  }
  
 
}
