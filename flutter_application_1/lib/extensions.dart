import 'dart:ui';

import 'package:flutter_application_1/enums.dart';

//延伸 字串轉換Color功能
extension HexColor on String {
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

///語系顯示字串
extension LanguageExtension on Language {
  String getDisplayValue() {
    return switch (this) {
      Language.chineseTrad => '繁體中文',
      Language.chineseSimp => '简体中文',
      Language.english => 'English',
      Language.japanese => '日本語',
      Language.korean => '한국어',
      Language.vietnam => 'Việt Nam',
      Language.thailand => 'ภาษาไทย',
      Language.indonesia => 'Bahasa Indonesia',
    };
  }
}

///菜單顯示字串
extension MainMenuExtension on MainMenu {
  String getDisplayValue() {
    return switch (this) {
      MainMenu.introduce => '功能介紹',
      MainMenu.feature => '產品特色',
      MainMenu.description => '使用說明',
      MainMenu.contact => '聯絡我們'
    };
  }
}