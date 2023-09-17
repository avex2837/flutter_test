import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';
import 'package:flutter_application_1/https/api/response/api_response.dart';
import 'package:flutter_application_1/mvvm/view/basic/base_widget.dart';
import 'package:flutter_application_1/mvvm/view_model/album_view_model.dart';
import 'package:flutter_application_1/mvvm/view_model/basic_view_model.dart';
import 'package:flutter_application_1/mvvm/view_model/hom_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyHomePage extends BasePage<HomeViewModel> {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  BasePageState<BasePage<PageViewModel>, HomeViewModel> createState() =>_MyHomePageState();
}

class _MyHomePageState extends BasePageState<MyHomePage,HomeViewModel> {
  final _controller = TextEditingController(); //EditText元件 控制器
  //建立按鈕三態
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

 
  @override
  HomeViewModel initViewModel(BuildContext context) =>Provider.of<HomeViewModel>(context,listen: false);

  @override
  Widget build(BuildContext context) {
    debugPrint(context.toString());
    //由於整個頁面的操作都須會因為變動而更新，直接在外層夾擊Consumer負責監聽變動數據
    return Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: value.isOver()
                    ? Colors.red
                    : Theme.of(context).colorScheme.inversePrimary,
                title: Text(value.isOver() ? 'Complete' : widget.title),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have pushed the button this many times:',
                      //顏色會於頁面跳轉返回後改變
                      style: TextStyle(fontSize: 30, color: value.getColor()),
                    ),
                    Text(
                      value.getCount().toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _controller,
                        decoration:
                            const InputDecoration(hintText: 'Enter Title'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        value.createAlbumData(_controller.text);
                      },
                      child: const Text('send createAlbumRequest'),
                    ),
                    //依據請求，決定要顯示的UI
                    getDisplayWidgetWhenSendRequest(value)
                  ],
                ),
              ),
              floatingActionButton:
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                    heroTag: "counter",
                    onPressed: value.isOver()
                        ? null
                        : () {
                            value.increaseCount();
                          },
                    child: const Icon(Icons.add)),
                const SizedBox(width: 20),
                FloatingActionButton(
                    heroTag: "reset",
                    onPressed: value.isOver()
                        ? () {
                            value.resetCount();
                          }
                        : null,
                    child: const Icon(Icons.refresh)),
                const SizedBox(width: 20),
                TextButton(
                    style: ButtonStyle(backgroundColor: createTextBtnBgColor()),
                    onPressed: () {
                      if (value.isFetchSuccess()) {
                        //下一頁須知道共享資料，故啟動頁面需進行消費
                        context.goNamed("preview", queryParameters: {
                          "title": value.getRequestAlbumTitle()
                        });
                        // context.go("/preview?title=1");
                      } else {
                        Fluttertoast.showToast(msg: "請先創建相簿送出才能前往下一頁");
                      }
                    },
                    child: const Text(
                      '前往下一頁',
                    ))
              ]),
            ));
  }
  

}

//取得送出請求要顯示的UI
Widget getDisplayWidgetWhenSendRequest(AlbumViewModel value) {
  switch (value.response.status) {
    case Status.error:
      return const FlutterLogo();
    case Status.initial:
    case Status.completed:
      return Text(value.getRequestAlbumTitle());
    default:
      return const CircularProgressIndicator();
  }
}
