import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_template/core/mvp/base_presenter.dart';
import 'package:my_template/core/net/net.dart';
import 'dart:io';
import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {
  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  late CancelToken _cancelToken;

  @override
  void dispose() {
    /// 銷燬時，將請求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  /// 返回Future 適用於刷新，加載更多
  Future<dynamic> requestNetwork<T>(
    Method method, {
    required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    return DioUtils.instance.requestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (isClose) {
          debugPrint("going to close progress");
          view.closeProgress();
        }
        onSuccess?.call(data);
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  void asyncRequestNetwork<T>(
    Method method, {
    required String url,
    bool isShow = true,
    bool isClose = true,
    NetSuccessCallback<T?>? onSuccess,
    NetErrorCallback? onError,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    if (isShow) {
      view.showProgress();
    }
    DioUtils.instance.asyncRequestNetwork<T>(
      method,
      url,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
      onSuccess: (data) {
        if (isClose) {
          view.closeProgress();
        }
        onSuccess?.call(data);
      },
      onError: (code, msg) {
        _onError(code, msg, onError);
      },
    );
  }

  /// 上傳圖片實現
  Future<String> uploadImg(File image) async {
    String imgPath = '';
    try {
      final String path = image.path;
      final String name = path.substring(path.lastIndexOf('/') + 1);
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'uploadIcon': await MultipartFile.fromFile(path, filename: name)
      });
      await requestNetwork<String>(Method.post,
          url: HttpApiUrl.upload, params: formData, onSuccess: (data) {
        imgPath = data ?? '';
      });
    } catch (e) {
      view.showToast('圖片上傳失敗！');
    }
    return imgPath;
  }

  void _onError(int code, String msg, NetErrorCallback? onError) {
    /// 異常時直接關閉加載圈，不受isClose影響
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }

    /// 頁面如果dispose，則不回調onError
    if (onError != null) {
      onError(code, msg);
    }
  }
}
