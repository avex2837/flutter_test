import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/constants_value.dart';
import 'package:flutter_application_1/https/api/basic/base_api.dart';
import 'package:flutter_application_1/https/api/beans/album_bean.dart';
import 'package:flutter_application_1/https/api/request/album_request';
import 'package:flutter_application_1/https/api/response/api_response.dart';
import 'package:flutter_application_1/mvvm/model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String getRequestAlbumTitle() {
    if (isFetchSuccess()) {}
    switch (_apiResponse.status) {
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
  bool isFetchSuccess() {
    return _apiResponse.status == Status.completed;
  }

  //取的相簿
  fetchAlbumData(String title) {
    BaseApi apiRequest = FetchAlbumRequest(title);
    _sendWithCallBack(apiRequest,successCallBack: (data) async {
      final prefs = await SharedPreferences.getInstance();
      //將此次取得資料寫入Preference
      prefs.setString(Constants.SHARE_PREFERENCES_KEY_ALBUM, value)
      final album = Album.fromJson(data);
      //將此次取得成功的資料寫入Preference
      final preferences = await SharedPreferences.getInstance();
      preferences.setString(Constants.SHARE_PREFERENCES_KEY_ALBUM, data.toString());
      _apiResponse = ApiResponse.completed(album);
      notifyListeners();
    }, errorCallBack: (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    });
  }

  //創建相簿
  createAlbumData(String title) {
    BaseApi apiRequest = CreateAlbumRequest(title);
    _send(apiRequest);

  }

  //發送Request
  _send(BaseApi apiRequest) async {
    _sendWithCallBack(apiRequest, successCallBack: (data) async {
      final album = Album.fromJson(data);
      _apiResponse = ApiResponse.completed(album);
      notifyListeners();
    }, errorCallBack: (e) {
      _apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    });
  }

  //發送Request
  _sendWithCallBack(BaseApi apiRequest,
      {required Function successCallBack,
      required Function errorCallBack}) async {
    _apiResponse = ApiResponse.loading('Create album data');
    notifyListeners();
    apiRequest.request(successCallBack: successCallBack,errorCallBack: errorCallBack);
  }
}
