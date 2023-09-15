import 'package:flutter_application_1/mvvm/viewModel/basic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';
///P
class ViewModel extends PageViewModel{
   //顏色
  String color = "#509cf6";

  ViewModel(super.context);

  @override
  onCreate() {
    print("ViewModel onCreate ");
    
  }

  @override
  onDispose() {
    print("ViewModel onDispose");

  }

  //設定顏色
  void setColor(String value)
  {
    color = value;
    notifyListeners();
  }

  //取得Color
  Color getColor()
  {
    return color.toColor();
  }


}