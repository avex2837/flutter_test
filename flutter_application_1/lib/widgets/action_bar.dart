import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums.dart';
import 'package:flutter_application_1/extensions.dart';
import 'package:flutter_application_1/utils/tools.dart';

///QPP樣式的ActionBar
class QppActionBar extends StatelessWidget {
  GlobalKey globalKey = GlobalKey();
  MenuController menuController = MenuController();
  QppActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeViewModel viewModel =
    //     Provider.of<HomeViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        // 左邊間距
        spacing(size.width, 321),
        //logo
        logo(size.width),
        // QPP -> Button 間距
        spacing(size.width, 466),
        //橫向菜單
        menuRow(size.width),
        //語系按鈕
        createLanguageDropdownMenu(menuController),
      ],
    );
  }
}

extension QppAppBarTitleExtension on QppActionBar {
  // 是否為小排版
  bool isSmallTypesetting(double width) => width < 800;

  /// 間距
  Widget spacing(double screenWidth, double width) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 10, maxWidth: width),
      child: SizedBox(
        width: getRealWidth(screenWidth, width),
      ),
    );
  }

  /// QPP Logo
  Widget logo(double width) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 148),
      child: Image.asset(
        'assets/images/desktop-pic-qpp-logo-01.png',
        width: getRealWidth(width, 148),
        scale: 46 / 148,
      ),
    );
  }

  /// 選單按鈕(Row)
  Widget menuRow(double width) {
    if (isSmallTypesetting(width)) {
      return const Spacer();
    }

    return Row(
      key: key,
      children: MainMenu.values
          .map(
            (e) => TextButton(
              onPressed: () => debugPrint(e.getDisplayValue()),
              child: Text(
                e.getDisplayValue(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }

  ///建立語系PopupMenu
  Widget createLanguagePoupMenu() {
    return PopupMenuButton(
        //定義key，之後可以透過key取得按鈕的位置
        // key: globalKey,
        //選單顏色
        color: const Color(0xff000b2b).withOpacity(0.6),
        //按鈕的大小
        iconSize: 20,
        //指定按鈕圖案
        icon: const Icon(Icons.language, color: Colors.white),
        //指定選單跳出的位置
        position: PopupMenuPosition.under,
        //偏移設定
        offset: const Offset(20, 0),
        //選單
        itemBuilder: (context) => Language.values
            .map((e) => PopupMenuItem(
                  //選單標題
                  value: e.getDisplayValue(),
                  //使用自訂義的Widget來監聽滑動
                  child: OnHover(
                    builder: (isHovered) {
                      return Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(e.getDisplayValue(),
                              //依據是否屬標移動到當前的選項，進行對應的變色處裡
                              style: TextStyle(
                                  color: isHovered
                                      ? Colors.yellow
                                      : Colors.white)),
                          const SizedBox(width: 10),
                        ],
                      );
                    },
                  ),
                ))
            .toList());
  }

  /// 語系下拉選單
  Widget createLanguageDropdownMenu(MenuController controller) {
    return MenuAnchor(
      controller: controller,
      builder: (context, controller, child) {
        return MouseRegion(
            onEnter: (event) => controller.open(),
            onExit: (event) {
              debugPrint('onExit');
            },
            onHover: (event) {
              debugPrint('onHover');
            },
            child: IconButton(
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              icon: const Icon(Icons.language, color: Colors.white),
            ));
      },
      //選項陣列
      menuChildren: Language.values
          .map((e) => MenuItemButton(
                onPressed: () {
                  debugPrint(e.getDisplayValue());
                },
                //使用自訂義的Widget來監聽滑動
                child: OnHover(
                  builder: (isHovered) {
                    return Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(e.getDisplayValue(),
                            //依據是否屬標移動到當前的選項，進行對應的變色處裡
                            style: TextStyle(
                                color:
                                    isHovered ? Colors.yellow : Colors.white)),
                        const SizedBox(width: 10),
                      ],
                    );
                  },
                ),
              ))
          .toList(),
      //定義Menu的Style
      style: MenuStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color(0xff000b2b).withOpacity(0.6)),
      ),
    );
  }
}

///自訂義 滑動狀態改變Widget
class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHover({super.key, required this.builder});

  @override
  HoverState createState() => HoverState();
}

class HoverState extends State<OnHover> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4.identity()..translate(10, 0, 0);
    final transform = isHover ? hovered : Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEnter(true),
      onExit: (event) => onEnter(false),
      child: AnimatedContainer(
          transform: transform,
          duration: const Duration(milliseconds: 200),
          child: widget.builder(isHover)),
    );
  }

  void onEnter(bool isHover) {
    setState(() {
      this.isHover = isHover;
    });
  }
}
