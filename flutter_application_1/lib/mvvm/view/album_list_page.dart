import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:flutter_application_1/mvvm/view_model/album_view_model.dart';
import 'package:flutter_application_1/mvvm/view_model/hom_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key});

  @override
  State<StatefulWidget> createState() => AlbumListPageState();
}

class AlbumListPageState extends State<AlbumListPage> {
  //宣告獨立的 AlbumViewModel，不取得共享AlbumViewModel，避免變動刷新
  final AlbumViewModel albumViewModel = AlbumViewModel();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //印出當前觸發build的Widget資訊
    debugPrint(context.toString());
    //取出前一頁帶入的資訊
    Map<String, dynamic> qparams =
        GoRouterState.of(context).uri.queryParameters;
    //取出帶入的Query
    String query = qparams.containsKey("title") ? qparams["title"] : "";
    // 等待畫面初始化完成
    albumViewModel.getAlbumData(query);
    //使用變化通知Provider 包覆 並指定 當前頁面的 albumViewModel
    return ChangeNotifierProvider(
      create: (context) => albumViewModel,
      child: Scaffold(
        body: Center(
            //建立列表widget
            child: ListView.separated(
                //指定簡單的標題容器作為
                itemBuilder: (BuildContext cotext, int index) {
                  //index + 前頁帶過來的字串，做為顯示標題
                  int num = index + 1;
                  //回傳標題資訊
                  return Consumer<AlbumViewModel>(
                      builder: (context, value, child) => ListTile(
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
                          ));
                },
                //定義每個item的分隔器
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.blue),
                //指定數量100筆
                itemCount: 100)),
        floatingActionButton: TextButton(
            style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
            onPressed: () {
              //取出首頁共享數據模組
              HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context,listen: false);
              //設定前頁共享的ColorModel
              homeViewModel.setColor("#FFB7DD");
              //返回上一頁
              context.goNamed("home");
            },
            child: const Text('返回上一頁')),
      ),
    );
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
