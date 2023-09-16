import 'package:flutter/material.dart';
import 'package:flutter_application_1/https/api/basic/base_api.dart';
import 'package:flutter_application_1/https/api/beans/album_bean.dart';
import 'package:flutter_application_1/https/api/request/album_request';
import 'package:flutter_application_1/https/api/response/api_response.dart';
import 'package:flutter_application_1/mvvm/model/data.dart';
///ViewModel
class ViewModel extends ChangeNotifier {
  //資料暫存區
  final _dataModel = DataModel();
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
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

  //取得此次請求結果
  ApiResponse get response {
    return _apiResponse;
  }
  //取得請求像標題
  String getRequestAlbumTitle()
  {
    if(isFetchSuccess()) {
     
    }
    switch(_apiResponse.status)
    {    
      case Status.completed:
      {
         Album album = _apiResponse.data;
         return album.getTitle();
      }
      case Status.initial:
      case Status.loading:
        return "";
      default:
            return "取值失敗，Flutter真是垃圾";
    }
  }

  //是否取植成功
  bool isFetchSuccess()
  {
    return _apiResponse.status ==Status.completed;
  }
  
  //取的相簿
  fetchAlbumData(String title) {
    BaseApi apiRequest = FetchAlbumRequest(title);
    _send(apiRequest);
  }

  //創建相簿
  createAlbumData(String title) {
    BaseApi apiRequest = CreateAlbumRequest(title);
    _send(apiRequest);
  }

  //發送Request
  _send(BaseApi apiRequest) async {
    _apiResponse = ApiResponse.loading('Create album data');
    notifyListeners();
    apiRequest.request(successCallBack: (data) async {
      final album = Album.fromJson(data);
      _apiResponse = ApiResponse.completed(album);
      notifyListeners();
    }, errorCallBack: (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    });
  }
}
