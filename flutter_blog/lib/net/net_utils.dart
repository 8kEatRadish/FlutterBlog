import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class NetUtil {
  final String TAG = '<NetUtil>';
  static BuildContext context = null;
  Dio _dio;
  BaseOptions _options;
  static NetUtil _instance;
  static final CONNECTTIMEOUT = 30 * 1000;
  static final RECEIVETIMEOUT = 30 * 1000;

  static NetUtil getInstance() {
    if (null == _instance) {
      _instance = new NetUtil();
    }
    return _instance;
  }

  NetUtil() {
    _options = getDefOptions();
    _dio = new Dio(_options);
  }

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = CONNECTTIMEOUT;
    options.receiveTimeout = RECEIVETIMEOUT;
//    options.baseUrl = KKPlatformApi.BASE_URL;
    return options;
  }

  NetUtil setOptions(BaseOptions options) {
    _options = options;
    _dio.options = _options;
    return this;
  }

  static final LogicError unknowError = LogicError(-1, "未知错误");

  ///get
  Future<Map<String, dynamic>> get(String uri,
          {Map<String, dynamic> paras,
          Options options,
          Interceptor interceptor,
          Function(int, int) onReceiveProgress}) =>
      requests("get", uri,
          data: paras,
          options: options,
          interceptor: interceptor,
          onReceiveProgress: onReceiveProgress);

  /// post
  Future<Map<String, dynamic>> post(String uri,
          {Map<String, dynamic> paras,
          Options options,
          Interceptor interceptor,
          Function(int, int) onReceiveProgress}) =>
      requests("post", uri,
          data: paras,
          options: options,
          interceptor: interceptor,
          onReceiveProgress: onReceiveProgress);

  /// upload
  Future<Map<String, dynamic>> upload(String uri, FormData formData,
          {Map<String, dynamic> parmas,
          Options options,
          Interceptor interceptor,
          Function(int, int) onSendProgress}) =>
      requests('upload', uri,
          formData: formData,
          data: parmas,
          options: options,
          interceptor: interceptor,
          onSendProgress: onSendProgress);

  /// 实际请求函数
  Future<Map<String, dynamic>> requests(String method, String uri,
      {Map<String, dynamic> data,
      FormData formData,
      Options options,
      bool dataIsJson = true,
      Interceptor interceptor,
      Function(int, int) onSendProgress,
      Function(int, int) onReceiveProgress}) async {
    print('$TAG request');
    try {
      if (method == 'get') {
        dataIsJson = false;
      }

      print('$TAG -- request uri : $uri');
      print('$TAG -- request data : $data');
      print('$TAG -- request method : $method');

      if (interceptor != null) {
        _dio.interceptors.clear();
        if (!_dio.interceptors.contains(interceptor)) {
          _dio.interceptors.add(interceptor);
        }
      } else {
        _dio.interceptors.clear();
      }

      print('$TAG options headers : ${options?.headers}');

      Response resp;
      if (method == 'get') {
        resp = await _dio.get(uri,
            queryParameters: data,
            options: options,
            onReceiveProgress: onReceiveProgress);
      } else if (method == 'post') {
        resp = await _dio.post(uri,
            data: data,
            options: options,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress);
      } else if (method == 'upload') {
        resp = await _dio.post(uri,
            queryParameters: data,
            data: formData,
            options: options,
            onSendProgress: onSendProgress);
      }
//       resp = await _dio.request(uri, data: data, options: options);
      LogicError logicError;
      if (resp == null) {
        logicError = LogicError(-1, 'resp == null!');
        return Future.error(logicError);
      }
      if (resp.data != null) {
        print('-- _handlerReponseTransform response data == ${resp.data}');
        if (resp.data is LogicError) {
          return Future.error(resp.data);
        }
        print('http response statusCode ： ${resp.statusCode}');
        if (resp.statusCode == HttpStatus.ok ||
            resp.statusCode == HttpStatus.created) {
          Map<String, dynamic> map;
          print("response data : ${resp.data}");
          try {
            if (resp.data is Map<String, dynamic>) {
              map = resp.data;
            } else {
              map = json.decode(resp.data.toString());
            }
            return map;
          } catch (error) {
            logicError = LogicError(-1, "响应数据解析异常! error:$error");
            return Future.error(logicError);
          }
        } else {
          logicError =
              LogicError(resp.statusCode, '服务端请求失败! ${resp.statusMessage}');
          return Future.error(logicError);
        }
      } else {
        logicError = LogicError(-1, '服务端请求失败!');
        return Future.error(logicError);
      }
    } on DioError catch (e) {
      LogicError logicError = LogicError(-1, '未知错误!');
      if (e.type == DioErrorType.connectTimeout) {
        // It occurs when url is opened timeout.
        logicError.errorMsg = '连接超时';
        print("连接超时 $e");
      } else if (e.type == DioErrorType.sendTimeout) {
        // It occurs when url is sent timeout.
        logicError.errorMsg = '请求超时';
        print("请求超时 $e");
      } else if (e.type == DioErrorType.receiveTimeout) {
        //It occurs when receiving timeout
        logicError.errorMsg = '响应超时';
        print("响应超时 $e");
      } else if (e.type == DioErrorType.response) {
        // When the server response, but with a incorrect status, such as 404, 503...
        var baseUrl = e.requestOptions.uri;
        if (e.response != null) {
          if (e.response.statusCode == 404 || e.response.statusCode == 500) {
            logicError.errorMsg = '服务端出现异常';
          } else {
            logicError.errorMsg = '网络出现异常';
          }
          logicError.errorCode = e.response.statusCode;
        }
        print(
            "出现异常 $e  baseUrl = $baseUrl --- response : ${e.response?.data?.toString()}");
      } else if (e.type == DioErrorType.cancel) {
        logicError.errorMsg = '请求取消';
        // When the request is cancelled, dio will throw a error with this type.
        print("请求取消 $e");
      } else if (e.type == DioErrorType.cancel) {
        logicError.errorMsg = '网络异常';
      } else {
        logicError.errorMsg = '未知错误';
        //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
        print("未知错误 $e");
      }
      return Future.error(logicError);
    }
  }

  Future<Response> downLoadRequest(String method, String uri,
      {Map<String, dynamic> data,
      FormData formData,
      Options options,
      Interceptor interceptor,
      Function(int, int) onSendProgress,
      Function(int, int) onReceiveProgress}) async {
    print('$TAG request');
    try {
      print('$TAG -- request uri : $uri');
      print('$TAG -- request data : $data');
      print('$TAG -- request method : $method');

      if (interceptor != null) {
        _dio.interceptors.clear();
        if (!_dio.interceptors.contains(interceptor)) {
          _dio.interceptors.add(interceptor);
        }
      } else {
        _dio.interceptors.clear();
      }

      print('$TAG options headers : ${options?.headers}');
      Response resp;
      if (method == 'get') {
        resp = await _dio.get(uri,
            queryParameters: data,
            options: options,
            onReceiveProgress: onReceiveProgress);
      } else if (method == 'post') {
        resp = await _dio.post(uri,
            data: data,
            options: options,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress);
      }
      LogicError logicError;
      if (resp == null) {
        logicError = LogicError(-1, 'resp == null!');
        return Future.error(logicError);
      }
      if (resp.data != null) {
        print('-- _handlerReponseTransform response data == ${resp.data}');
        if (resp.data is LogicError) {
          return Future.error(resp.data);
        }
        print('http response statusCode ： ${resp.statusCode}');
        if (resp.statusCode == HttpStatus.ok ||
            resp.statusCode == HttpStatus.created) {
//          LogUtils.d("response data : ${resp.data}");
          try {
            return resp;
          } catch (error) {
            logicError = LogicError(-1, "响应数据解析异常! error:$error");
            return Future.error(logicError);
          }
        } else {
          logicError =
              LogicError(resp.statusCode, '服务端请求失败! ${resp.statusMessage}');
          return Future.error(logicError);
        }
      } else {
        logicError = LogicError(-1, '服务端请求失败!');
        return Future.error(logicError);
      }
    } on DioError catch (e) {
      LogicError logicError = LogicError(-1, '未知错误!');
      if (e.type == DioErrorType.connectTimeout) {
        // It occurs when url is opened timeout.
        logicError.errorMsg = '连接超时';
        print("连接超时 $e");
      } else if (e.type == DioErrorType.sendTimeout) {
        // It occurs when url is sent timeout.
        logicError.errorMsg = '请求超时';
        print("请求超时 $e");
      } else if (e.type == DioErrorType.receiveTimeout) {
        //It occurs when receiving timeout
        logicError.errorMsg = '响应超时';
        print("响应超时 $e");
      } else if (e.type == DioErrorType.response) {
        // When the server response, but with a incorrect status, such as 404, 503...
        var baseUrl = _dio.options.baseUrl;
        if (e.response != null) {
          if (e.response.statusCode == 404 || e.response.statusCode == 500) {
            logicError.errorMsg = '服务端出现异常';
          } else {
            logicError.errorMsg = '网络出现异常';
          }
          logicError.errorCode = e.response.statusCode;
        }
        print(
            "出现异常 $e  baseUrl = $baseUrl --- response : ${e.response?.data?.toString()}");
      } else if (e.type == DioErrorType.cancel) {
        logicError.errorMsg = '请求取消';
        // When the request is cancelled, dio will throw a error with this type.
        print("请求取消 $e");
      } else if (e.type == DioErrorType.other) {
        logicError.errorMsg = '网络异常';
      } else {
        logicError.errorMsg = '未知错误';
        //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
        print("未知错误 $e");
      }
      return Future.error(logicError);
    }
  }
}

class LogicError {
  int errorCode;
  String errorMsg;

  @override
  String toString() {
    return 'LogicError{errorCode: $errorCode, errorMsg: $errorMsg, error: $error}';
  }

  dynamic error;

  LogicError(int errorCode, String errorMsg, {dynamic error}) {
    this.errorCode = errorCode;
    this.errorMsg = errorMsg;
    this.error = error;
  }
}
