import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/constants_value.dart';
import 'package:flutter_application_1/https/api/basic/base_api.dart';
import 'package:flutter_application_1/https/api/beans/album_bean.dart';
import 'package:flutter_application_1/https/api/request/album_request';
import 'package:flutter_application_1/https/api/response/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

///ViewModel
class AlbumViewModel extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

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
  getAlbumData(String title) {
    BaseApi apiRequest = FetchAlbumRequest(title);
    apiRequest.request(
      onCompplete: (jsonMap) async {
        //轉換Json to Album 物件
        final album = Album.fromJson(jsonMap);
        _apiResponse = ApiResponse.completed(album);
        //將此次取得成功的資料寫入Preference
        final preferences = await SharedPreferences.getInstance();
        preferences.setString(
            Constants.SHARE_PREFERENCES_KEY_ALBUM, jsonMap.toString());
        notifyListeners();
      },
      onError: (e) {
        _apiResponse = ApiResponse.error(e.toString());
        notifyListeners();
      },
    );
  }

  //創建相簿
  createAlbumData(String title) {
    BaseApi apiRequest = CreateAlbumRequest(title);
    apiRequest.request(
      onCompplete: (jsonMap) async {
        //轉換Json to Album 物件
        final album = Album.fromJson(jsonMap);
        _apiResponse = ApiResponse.completed(album);
        notifyListeners();
      },
      onError: (e) {
        _apiResponse = ApiResponse.error(e.toString());
        notifyListeners();
      },
    );
  }
}