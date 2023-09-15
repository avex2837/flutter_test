import 'package:flutter/material.dart';
import 'package:flutter_application_1/mvvm/viewModel/basic_view_model.dart';


//定義基礎Page 繼承
abstract class BasePage<VM extends PageViewModel> extends BaseViewModelWidget<VM> {
  const BasePage({Key? key}) : super(key: key);


  @override
  BasePageState<BasePage,VM> createState();

}

//定義基礎PageState
abstract class BasePageState<T extends BasePage, VM extends PageViewModel>
    extends BaseViewModelState<T, VM> {

}



///基礎ViewModelWidget
abstract class BaseViewModelWidget<VM extends BaseViewModel> extends StatefulWidget {
  const BaseViewModelWidget({Key? key}) : super(key: key);
  

  @override
  BaseViewModelState<BaseViewModelWidget,VM> createState();

}


///ViewModelState（相關View邏輯）
abstract class BaseViewModelState<T extends StatefulWidget,
    VM extends BaseViewModel> extends BaseState<T> {
    
  ///頁面實作的ViewModel
  late VM viewModel;

  ///进行初始化ViewModel相关操作
  @override
  void initState() {
    super.initState();
    //延遲初始化,避免在initState中context尚未初始化完畢
    Future.delayed(Duration.zero).then((value) {
      ///初始化ViewModel
      viewModel = initViewModel();
      ///调用ViewModel的生命周期，此时可以进行一些初始化，比如网络请求等
      viewModel.onCreate();
    });
  }

  ///
  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  //初始化ViewModel
  VM initViewModel();

}


//定義基礎State
abstract class BaseState<T extends StatefulWidget> extends State<T>{

}

