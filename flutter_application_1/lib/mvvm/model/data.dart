//顏色物件
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';

class DataModel{
  //顏色
  String color = "#509cf6";

  //設定顏色
  void setColor(String value)
  {
    color = value;
  }

  //取得Color
  Color getColor()
  {
    return color.toColor();
  }
}