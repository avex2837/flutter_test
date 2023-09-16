import 'package:flutter/material.dart';
import 'package:flutter_application_1/mvvm/model/data.dart';

///ViewModel
class MainViewModel extends ChangeNotifier {
  //資料暫存區
  final _dataModel = DataModel();
  //設定顏色
  void setColor(String value) {
    _dataModel.setColor(value);
    notifyListeners();
  }

  //取得Color
  Color getColor() {
    return _dataModel.getColor();
  }

  //計數
  void increaseCount() {
    _dataModel.increaseCount();
    notifyListeners();
  }

  int getCount() {
    return _dataModel.getCount();
  }

  //重新設定
  void resetCount() {
    _dataModel.resetCount();
    notifyListeners();
  }

  //是否超過
  bool isOver() => _dataModel.isOver();
}
