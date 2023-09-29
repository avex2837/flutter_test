
import 'package:flutter/material.dart';

double getRealWidth(double screenWidth, double width) {
//   // First get the FlutterView.
//   FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

// // Dimensions in physical pixels (px)
//   Size size = view.physicalSize;
//   double screenWidth = size.width;
//   double screenHeight = size.height;

// // Dimensions in logical pixels (dp)
// Size size = view.physicalSize / view.devicePixelRatio;
// double width = size.width;
// double height = size.height;

  return screenWidth * width / 1980;
}

///取得Widget的位置
Rect getWidgetGlobalRect(GlobalKey key) {
  assert(key.currentContext != null, '');

  RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  var offset = renderBox.localToGlobal(Offset.zero);
  return Rect.fromLTWH(
      offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
}