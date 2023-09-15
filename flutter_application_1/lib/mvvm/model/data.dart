//顏色物件
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/utils.dart';

class DataModel{
  //顏色
  String color = "#509cf6";
  //計數
  int _count=0;

  //設定顏色
  void setColor(String value)
  {
    color = value;
  }

  //取得Color
  Color getColor()=>color.toColor();

  ///計數
  void increaseCount(){
      if(_count<5) {
        _count++;
      }
  }

  //重新設定
  void resetCount() {
     _count=0;
  }

  int getCount()=>_count;
}