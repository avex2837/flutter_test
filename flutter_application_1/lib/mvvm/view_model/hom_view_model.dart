import 'package:flutter/material.dart';
import 'package:flutter_application_1/mvvm/model/data.dart';
import 'package:flutter_application_1/mvvm/view_model/album_view_model.dart';

///HomeViewModel 繼承AlbumViewModel 讓其持有相簿model的功能
class HomeViewModel extends AlbumViewModel {
  //資料暫存區
  final _homeData = HomeData();

  HomeViewModel(super.context);

  @override
  onCreate() {
    debugPrint("HomeViewModel onCreate");
  }

  @override
  onDispose() {
    debugPrint("HomeViewModel onDispose");
  }

  //設定顏色
  void setColor(String value) {
    _homeData.setColor(value);
    notifyListeners();
  }

  //取得Color
  Color getColor() {
    return _homeData.getColor();
  }

  //計數
  void increaseCount() {
    _homeData.increaseCount();
    notifyListeners();
  }

  //取得次數
  int getCount() {
    return _homeData.getCount();
  }

  //重新設定
  void resetCount() {
    _homeData.resetCount();
    notifyListeners();
  }

  //是否超過
  bool isOver() => _homeData.isOver();
}
