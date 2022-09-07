import 'package:flutter/material.dart';
import 'package:my_template/features/module_A/model/filmModel.dart';
// import 'package:my_template/account/models/city_entity.dart';
import 'package:my_template/core/iview/home_iview.dart';
import 'package:my_template/core/mvp/base_page_presenter.dart';
import 'package:my_template/core/net/dio_utils.dart';
import 'package:my_template/core/net/http_api_url.dart';
// import 'package:my_template/shop/models/user_entity.dart';

class HomePagePresenter extends BasePagePresenter<HomeIMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (view.isAccessibilityTest) {
        return;
      }

      /*
      
      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
      asyncRequestNetwork<UserEntity>(Method.get,
        url: HttpApi.users,
        onSuccess: (data) {
          view.setUser(data);
        },
      );
      */
    });
  }

  void testListData() {
    /*
    /// 測試返回List類型數據解析
    asyncRequestNetwork<List<CityEntity>>(Method.get,
      url: HttpApi.subscriptions,
      onSuccess: (data) {

      },
      
    );*/
  }

  Future<dynamic> search(String text, int page, bool isShowDialog) {
    final Map<String, String> params = <String, String>{};
    params['q'] = text;
    params['page'] = page.toString();
    params['l'] = 'Dart';

    return requestNetwork<Map<String, dynamic>>(Method.get,
        url: HttpApiUrl.film,
        queryParameters: params,
        isShow: isShowDialog, onSuccess: (baseRespData) {
      debugPrint("got data back from http");
      if (baseRespData != null) {
        Map<String, dynamic> baseResp = baseRespData;
        final model = FilmModel.fromJson(baseResp);
        debugPrint(model.title);
        /*
        /// 一頁30條數據，等於30條認為有下一頁
        /// 具體的處理邏輯根據具體的接口情況處理，這部分可以抽離出來
        view.provider.hasMore = data.items!.length == 30;
        if (page == 1) {
          /// 刷新
          view.provider.list.clear();
          if (data.items!.isEmpty) {
            view.provider.setStateType(StateType.order);
          } else {
            view.provider.addAll(data.items!);
          }
        } else {
          view.provider.addAll(data.items!);
        }
      } else {
        /// 加载失败
        view.provider.hasMore = false;
        view.provider.setStateType(StateType.network);
      }
      */
      }
    }, onError: (_, __) {
      /// 加载失败
      debugPrint("Error with http api request");
      /*
      view.provider.hasMore = false;
      view.provider.setStateType(StateType.network);
      */
    });
  }
}
