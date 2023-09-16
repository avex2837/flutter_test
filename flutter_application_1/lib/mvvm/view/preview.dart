import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:flutter_application_1/mvvm/view_model/prew_view_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

///預覽頁，繼承BaseViewModelWidget
class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    //印出當前觸發build的Widget資訊
    debugPrint(context.toString());
    //取出共享ViewModel，並設定監聽FALSE，避免使用MODEL重新觸發BUILD
    ViewModel viewModel = Provider.of<ViewModel>(context, listen: false);
    //取出前一頁帶入的資訊
    Map<String, dynamic> qparams =
        GoRouterState.of(context).uri.queryParameters;
    //取出帶入的Query
    String query = qparams.containsKey("title") ? qparams["title"] : "";
    return Consumer<ViewModel>(
        builder: (context, value, child) => Scaffold(
            body: Center(
                //建立列表widget
                child: ListView.separated(
                    //指定簡單的標題容器作為
                    itemBuilder: (BuildContext cotext, int index) {
                      //index + 前頁帶過來的字串，做為顯示標題
                      int num = index + 1;
                      //回傳標題資訊
                      return ListTile(
                        //項目圖片
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.numbers),
                            Text(
                              "$num",
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        // //項目背景
                        // tileColor: index%2==0?Colors.amber:Colors.purple,
                        //項目文字主標題
                        title: const Text("我是標題",
                            style: TextStyle(color: Colors.blue)),
                        //項目文字次標題
                        subtitle: Text(query,
                            style: const TextStyle(color: Colors.red)),
                      );
                    },
                    //定義每個item的分隔器
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.blue),
                    //指定數量100筆
                    itemCount: 100)),
            floatingActionButton: TextButton(
                style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
                onPressed: () {
                  //設定前頁共享的ColorModel
                  viewModel.setColor("#FFB7DD");
                  //返回上一頁
                  context.goNamed("home");
                },
                child: const Text('返回上一頁'))));
  }

  //建立按鈕點擊事件
  MaterialStateProperty<Color> createTextBtnBgColor() {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return "#509cf6".toColor();
      } else if (states.contains(MaterialState.disabled)) {
        return "#509cf6".toColor();
      }
      return "#FF208FF9".toColor();
    });
  }
}
